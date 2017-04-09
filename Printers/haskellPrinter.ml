(*
 * Copyright (c) 2012, Prologin
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)

(** Haskell Printer
    note : http://xkcd.com/1312/
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper

module E = AstFun.Expr
module Type = Ast.Type



let prelude_and = "
(<&&>) a b =
	do c <- a
	   if c then b
		 else return False"
let prelude_or = "(<||>) a b =
	do c <- a
	   if c then return True
		 else b"
let prelude_ifm = "ifM :: IO Bool -> IO a -> IO a -> IO a
ifM c i e =
  do b <- c
     if b then i else e"
let prelude_writeIOA = "writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray"
let prelude_readIOA = "readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray"
let prelude_skip = "skip_whitespaces :: IO ()
skip_whitespaces =
  ifM isEOF
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\\n' || c == '\\t' || c == '\\r' then
           do getChar
              skip_whitespaces
           else return ())"

let prelude_readint = "read_int_a :: Int -> IO Int
read_int_a b =
  ifM isEOF
      (return b)
      (do c <- hLookAhead stdin
          if isNumber c then
           do getChar
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\\x -> -1::Int) $ hGetChar stdin
                 else return 1
      (* sign) <$> read_int_a 0"

let array_init_withenv = "array_init_withenv :: Int -> ( Int -> env -> IO(env, tabcontent)) -> env -> IO(env, IOArray Int tabcontent)
array_init_withenv len f env =
  do (env, li) <- g 0 env
     (,) env <$> newListArray (0, len - 1) li
  where g i env =
           if i == len
           then return (env, [])
           else do (env', item) <- f i env
                   (env'', li) <- g (i+1) env'
                   return (env'', item:li)"

let array_init1 = "array_init len f = fmap snd (array_init_withenv len (\\x () -> fmap ((,) ()) (f x)) ())"

let array_init2 = "array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)"

let nop = -100
let fun_priority = 20
let fun_priority_op = 18
let lambda_priority = 18

let parens (p:int) p2 f fmt =
  let fmt = if p >= p2 then let open Format in "(" ^^ fmt ^^ ")" else fmt in
  Format.fprintf f fmt

let hsapply p f fun_ apply_side_effects args =
  match args with
  | [] -> parens p fun_priority f "%a ()" fun_ ()
  | [false, pr, x] when apply_side_effects -> parens p fun_priority f "%a >>= %a" (pr fun_priority) x fun_ ()
  | _ ->
    let count = if apply_side_effects then List.length args else 0 (* ne sera jamais atteind *) in
    let _, pure, pr = List.fold_left
        (fun (c, pure, p) (isPure, parg, arg) ->
           match pure, isPure with
             (true, true) -> c+1, true, (fun f () -> Format.fprintf f "%a %a" p () (parg fun_priority) arg)
           | (true, false) when c = count -> c+1, true, (fun f () -> Format.fprintf f "%a =<< %a" p () (parg fun_priority) arg)
           | (true, false)  -> c+1, false, (fun f () -> Format.fprintf f "%a <$> %a" p () (parg fun_priority) arg)
           | (false, false) -> c+1, false, (fun f () -> Format.fprintf f "%a <*> %a" p () (parg fun_priority) arg)
           | (false, true) -> c+1, false, (fun f () -> Format.fprintf f "%a <*> return %a" p () (parg fun_priority) arg)
        ) (1, true, fun_) args
    in
    if not pure && apply_side_effects then parens p fun_priority f "join $ %a" pr ()
    else parens p fun_priority f "%a" pr ()

let commutative = function
  | Ast.Expr.Add -> Some Ast.Expr.Add
  | Ast.Expr.Mul -> Some Ast.Expr.Mul
  | Ast.Expr.Eq -> Some Ast.Expr.Eq
  | Ast.Expr.Diff -> Some Ast.Expr.Diff
  | Ast.Expr.Or -> Some Ast.Expr.Or
  | Ast.Expr.And -> Some Ast.Expr.And
  | Ast.Expr.Lower -> Some Ast.Expr.Higher
  | Ast.Expr.LowerEq -> Some Ast.Expr.HigherEq
  | Ast.Expr.Higher -> Some Ast.Expr.Lower
  | Ast.Expr.HigherEq -> Some Ast.Expr.LowerEq
  | Ast.Expr.Div
  | Ast.Expr.Mod
  | Ast.Expr.Sub -> None


  let binopstr = function
    | Ast.Expr.Add -> "+"
    | Ast.Expr.Sub -> "-"
    | Ast.Expr.Mul -> "*"
    | Ast.Expr.Div -> "quot"
    | Ast.Expr.Mod -> "rem"
    | Ast.Expr.Or -> "||"
    | Ast.Expr.And -> "&&"
    | Ast.Expr.Lower -> "<"
    | Ast.Expr.LowerEq -> "<="
    | Ast.Expr.Higher -> ">"
    | Ast.Expr.HigherEq -> ">="
    | Ast.Expr.Eq -> "=="
    | Ast.Expr.Diff -> "/="

  let binop_priority = function
    | Ast.Expr.Add -> -1, -2, -2
    | Ast.Expr.Sub -> -1, -2, -1
    | Ast.Expr.Mul -> 0, -1, -1
    | Ast.Expr.Div -> -10, 15, 15
    | Ast.Expr.Mod -> -10, 15, 15
    | Ast.Expr.Or -> -8, -8, -8
    | Ast.Expr.And -> -10, -10, -10
    | Ast.Expr.Lower -> -5, -5, -5
    | Ast.Expr.LowerEq -> -5, -5, -5
    | Ast.Expr.Higher -> -5, -5, -5
    | Ast.Expr.HigherEq -> -5, -5, -5
    | Ast.Expr.Eq -> -6, -5, -5
    | Ast.Expr.Diff -> -5, -5, -5

  let binopShortCut = function
    | Ast.Expr.And -> Some "<&&>"
    | Ast.Expr.Or -> Some "<||>"
    | _ -> None

  let binopf = function
    | Ast.Expr.Div
    | Ast.Expr.Mod -> true
    | _ -> false


let unopstr = function
  | Ast.Expr.Neg -> "-"
  | Ast.Expr.Not -> "not"

let unopstrf = function
  | Ast.Expr.Neg -> "(-)"
  | Ast.Expr.Not -> "not"


let pbinopf f op =
  if binopf op
  then Format.fprintf f "%s" (binopstr op)
  else Format.fprintf f "(%s)" (binopstr op)

let pbinop f op =
  if binopf op
  then Format.fprintf f "`%s`" (binopstr op)
  else Format.fprintf f "%s" (binopstr op)

let punop f op = Format.fprintf f "%s" (unopstr op)
let punopf f op = Format.fprintf f "%s" (unopstrf op)


let tname f name = Format.fprintf f "%s" (String.capitalize name)
let ptype f t =
  let open Type in
  let open Format in
  let ptype ty f () = match ty with
    | Integer -> fprintf f "Int"
    | String -> fprintf f "String"
    | Array a -> fprintf f "(IOArray Int %a)" a ()
    | Void ->  fprintf f "()"
    | Bool -> fprintf f "Bool"
    | Char -> fprintf f "Char"
    | Named n -> tname f n
    | Struct li ->
      fprintf f "{@[<v 2>@\n%a@\n}@]"
        (print_list
           (fun t (name, type_) ->
              fprintf t "_%s :: IORef %a" name type_ ()
           )
           (sep "%a,@\n%a")
        ) li
    | Enum li ->
      fprintf f "%a"
        (print_list
           (fun t name ->
              Format.fprintf t "%s" name
           )
           (sep "%a@\n| %a")
        ) li
    | Lexems -> assert false
    | Auto -> assert false
    | Tuple li ->
      fprintf f "(%a)"
        (print_list (fun f g -> g f ()) sep_c) li
  in Fixed.Deep.fold ptype t f ()

let binding f s = match s with
  | Ast.UserName s -> Format.fprintf f "%s" s
  | Ast.InternalName i -> Format.fprintf f "internal_%d" i

let rec extract_fun_params' e acc = match E.unfix e with
    | E.Fun ([], e) ->
      let acc f () = Format.fprintf f "%a ()" acc ()
      in true, extract_fun_params e acc
    | E.Fun (params, e) ->
      let acc f () = Format.fprintf f "%a %a" acc () (print_list binding sep_space) params
      in true, extract_fun_params e acc
    | E.FunTuple (params, e) ->
      let acc f () = Format.fprintf f "%a (%a)" acc () (print_list binding sep_c) params
      in true, extract_fun_params e acc
    | _ -> false, (acc, e)
and extract_fun_params e acc = snd @$ extract_fun_params' e acc

let header binand binor array_init array_make ifm read_array write_array f opts =
    let need_stdinsep = opts.AstFun.hasSkip in
    let need_readint = Ast.TypeSet.mem (Type.integer) opts.AstFun.reads in
    let imports = [
      "Text.Printf";
      "Control.Applicative";
      "Control.Monad";
      "Data.Array.MArray";
      "Data.Array.IO";
      "Data.Char";
      "System.IO";
      "Data.IORef"
    ] in
    Format.fprintf f "@[%a@]@\n%a%a%a%a%a%a%a%a@\nmain :: IO ()"
      (print_list (fun f s -> Format.fprintf f "import %s" s) sep_nl) imports
      (fun f () -> if binand then Format.fprintf f "%s@\n" prelude_and) ()
      (fun f () -> if binor then Format.fprintf f "%s@\n" prelude_or) ()
      (fun f () -> if ifm then Format.fprintf f "%s@\n" prelude_ifm) ()
      (fun f () -> if need_stdinsep then Format.fprintf f "%s@\n" prelude_skip) ()
      (fun f () -> if need_readint then Format.fprintf f "%s@\n" prelude_readint) ()
      (fun f () -> if write_array then Format.fprintf f "%s@\n" prelude_writeIOA) ()
      (fun f () -> if read_array then Format.fprintf f "%s@\n" prelude_readIOA) ()
      (fun f () ->
         match array_init, array_make with
         | (true, true) -> Format.fprintf f "%s@\n%s@\n" array_init_withenv array_init1
         | true, false -> Format.fprintf f "%s@\n" array_init2
         | false, true -> Format.fprintf f "%s@\n" array_init_withenv
         | false, false -> ()
      ) ()


(*
  if p1 >= p2 then
    Format.fprintf f "(%a)" f e else p f e
*)
class haskellPrinter = object(self)

  method lang () = "hs"

  val mutable macros = Ast.BindingMap.empty
  val mutable side_effects = IntMap.empty
  val mutable typerEnv : Typer.env = Typer.empty
  method getTyperEnv () = typerEnv
  method setTyperEnv t = typerEnv <- t
  method typename_of_field field = Typer.typename_for_field field typerEnv

  val mutable recursives_definitions = StringSet.empty
  method setRecursive b = recursives_definitions <- b

  method binop p f a op b = 
    let cq, q1, q2 = binop_priority op in
    match self#isPure a, self#isPure b, binopShortCut op, commutative op with
    | true, true, _, _ -> parens p cq f "%a %a %a" (self#expr q1) a pbinop op (self#expr q2)  b
    | true, false, None, _ -> Format.fprintf f "((%a %a) <$> %a)" pbinopf op (self#expr fun_priority) a (self#expr fun_priority) b
    | false, true, _, Some op2 -> Format.fprintf f "((%a %a) <$> %a)" pbinopf op2 (self#expr fun_priority) b (self#expr fun_priority) a
    | _, _, None, _ -> Format.fprintf f "(%a <$> %a <*> %a)" pbinopf op (self#eM fun_priority) a (self#eM fun_priority) b
    | _, _, Some s, _ -> Format.fprintf f "(%a %s %a)" (self#eM fun_priority) a s (self#eM fun_priority) b

  method unop p f a op =
    let pr = match op with
      | Ast.Expr.Neg -> 2
      | Ast.Expr.Not -> fun_priority
    in
    if self#isPure a then parens p pr f "%a %a" punop op (self#expr pr) a
    else parens p (fun_priority - 1) f "fmap %a %a"punopf op (self#expr fun_priority) a

  method comment fe f str c = Format.fprintf f "@[<v>{-%s-}@\n%a@]" str fe c

  method fun_ p f params e =
    let pparams, e = extract_fun_params (E.fun_ params e) (fun f () -> ()) in
    parens p lambda_priority f "@[<v 2>\\%a ->@\n%a@]" pparams () (self#eM nop) e

  method funtuple p f params e =
    let pparams, e = extract_fun_params (E.funtuple params e) (fun f () -> ()) in
    parens p lambda_priority f "@[<v 2>(\\%a ->@\n%a)@]" pparams () (self#eM nop) e

  method letrecin p f name params e1 e2 = match params with
    | [] -> parens p (fun_priority -1) f "let %a @[<v>() =@\n%a in@\n%a@]"
              binding name
              (self#expr nop) e1
              (self#expr nop) e2
    | _ ->
      parens p (fun_priority -1) f "let %a @[<v>%a =@\n%a in@\n%a@]"
        binding name
        (print_list binding sep_space) params
        (self#expr nop) e1
        (self#expr nop) e2

  method isSideEffect expr = match IntMap.find (E.Fixed.annot expr) side_effects with
    | AstFun.EMacro -> false
    | AstFun.EPure -> false
    | AstFun.EEffect -> true

  method isPure expr = not (self#isSideEffect expr)

  method eM p f expr =
    match E.unfix expr with
    | E.Comment (s, c) -> self#comment (self#eM p) f s c
    | E.Block _ -> self#expr p f expr
    | E.LetIn (name, v, e) ->
      if self#isPure expr then self#letin p f name v e (self#eM nop)
      else self#expr p f expr
    | _ ->
      if self#isSideEffect expr then self#expr p f expr
      else parens p (fun_priority - 1) f "return %a" (self#expr fun_priority) expr

  method typename f s = Format.fprintf f "%s" s

  method expand_macro_call f name t params code li =
    let lang = self#lang () in
    let canBePure = List.for_all self#isPure li in
    let code_to_expand = List.fold_left
        (fun acc (clang, expantion) ->
           if clang = "" || clang = lang then
             if acc = None then Some (self#eM nop, expantion) else acc
           else if canBePure && ( clang = "" || clang = lang  ^ "_pure") then
             Some ((self#expr fun_priority), expantion)
           else acc
        ) None
        code
    in match code_to_expand with
    | None -> assert false (* TODO *)
    | Some (pr, s) ->
      let listr = List.map
          (fun e ->
             let b = Buffer.create 1 in
             let fb = Format.formatter_of_buffer b in
             Format.fprintf fb "@[<h>%a@]%!" pr e;
             Buffer.contents b
          ) li in
      let expanded = List.fold_left
          (fun s ((param, _type), string) ->
             String.replace ("$"^param) string s
          )
          s
          (List.combine params listr)
      in Format.fprintf f "(%s)" expanded

  method blockContent f li =
    print_list
      (fun f e ->
         match E.unfix e with
         | E.ReadIn( Type.Fixed.F(_, Type.Integer),
                     E.Fixed.F(_, E.Fun ( [name], next))
                   ) ->
           Format.fprintf f "@[<h>%a <- read_int@]@\n%a" binding name
             self#blockContent [next]
         | E.ReadIn( Type.Fixed.F(_, Type.Char),
                     E.Fixed.F(_, E.Fun ( [name], next))
                   ) ->
           Format.fprintf f "@[<h>%a <- getChar@]@\n%a" binding name
             self#blockContent [next]
         | E.Block li -> self#blockContent f li
         | E.LetIn (s, v, e) ->
           let isfun, (pparams, a) = extract_fun_params' v (fun f () -> ()) in
           if self#isPure v then
             Format.fprintf f "@[<h>let %a%a = @[<v>%a@]@]@\n%a" binding s pparams ()
               (if isfun then self#eM nop else self#expr nop) a
               self#blockContent [e]
           else
             Format.fprintf f "@[<h>%a%a <-@[<v> %a@]@]@\n%a" binding s pparams () (self#expr nop) a
               self#blockContent [e]
         | _ -> self#eM nop f e
      ) sep_nl f li

  method block p f li =
    parens p (fun_priority -1) f "do @[<v>%a@]" self#blockContent li

  method print_format f formats =
    Format.fprintf f "%S" (format_to_string formats)

  method printf f () = Format.fprintf f "printf"
  method multiprint p f formats exprs =
    let side_effect =  List.exists (fun (e, _) -> self#isSideEffect e) exprs in
    let exprs = List.map (fun (e, ty) ->
        let pure = self#isPure e in
        pure, (fun p f () ->
            if pure then
              Format.fprintf f "(%a::%a)" (self#expr p) e ptype ty
            else Format.fprintf f "(%a::IO %a)" (self#expr p) e ptype ty
          ), ()
      ) exprs in
    let params = (true, (fun p f () -> self#print_format f formats), ()) :: exprs in
    parens p fun_priority f (if side_effect then "%a" else "%a :: IO()")
      (fun f () -> hsapply p f self#printf true params) ()

  method expr p f e = match E.unfix e with
    | E.ApplyMacro (fun_, li) ->
      begin match Ast.BindingMap.find_opt fun_ macros with
        | None -> assert false
        | Some ((t, params, code)) -> self#expand_macro_call f fun_ t params code li
      end
    | E.MultiPrint (formats, exprs) -> self#multiprint p f formats exprs
    | E.LetRecIn (name, params, e1, e2) -> self#letrecin p f name params e1 e2
    | E.BinOp (a, op, b) -> self#binop p f a op b
    | E.UnOp (a, op) -> self#unop p f a op
    | E.Fun (params, e) -> self#fun_ p f params e
    | E.FunTuple (params, e) -> self#funtuple p f params e
    | E.Apply (e, li) ->
      let default () = let li = List.map (fun e -> self#isPure e, self#expr, e) li in
        hsapply p f (fun f () -> (self#expr nop)f e) true li in
      begin match E.unfix e with
        | E.Lief ( E.Binding binding ) ->
          begin match Ast.BindingMap.find_opt binding macros with
            | None -> default ()
            | Some ((t, params, code)) -> self#expand_macro_call f binding t params code li
          end
        | _ -> default ()
      end
    | E.Tuple li -> if List.for_all self#isPure li then
        Format.fprintf f "(%a)" (print_list (self#expr nop) sep_c) li
      else
        let li = List.map (fun e -> self#isPure e, self#expr, e) li in
        hsapply nop f (fun f () -> Format.fprintf f "(%a)" (print_list (fun _ _ -> ()) sep_c) li)
          false li
    | E.Lief l ->
      begin match l with
        | E.Error -> Format.fprintf f "(assert false)"
        | E.Unit -> Format.fprintf f "()"
        | E.Char c -> Format.fprintf f "%C" c
        | E.String s -> Format.fprintf f "%S" s
        | E.Integer i ->
          (if i < 0 then parens p nop else Format.fprintf) f "%i" i
        | E.Bool true -> Format.fprintf f "True"
        | E.Bool false -> Format.fprintf f "False"
        | E.Enum s -> Format.fprintf f "%s" s
        | E.Binding s -> binding f s
      end
    | E.Comment (s, c) -> self#comment (self#expr p) f s c
    | E.If (e1, e2, e3) ->
      let pr = if self#isPure e2 && self#isPure e3 then self#expr nop else self#eM nop in
      if self#isPure e1 then parens p (-1) f "@[<v>if %a@\nthen %a@\nelse %a@]" (self#expr nop) e1 pr e2 pr e3
      else parens p (fun_priority - 1) f "@[<h>ifM @[<v>%a@\n%a@\n%a@]@]" (self#eM fun_priority) e1 (self#eM fun_priority) e2 (self#eM fun_priority) e3
    | E.Print (expr, t) ->
      begin
        match E.unfix expr with
        | E.Lief (E.String s) -> parens p fun_priority f "%a %S :: IO ()" self#printf () s
        | _ ->
          if self#isPure expr then
            parens p fun_priority f "@[%a %S (%a :: %a) :: IO ()@]"
              self#printf () (format_type t)
              (self#expr nop) expr
              ptype t
          else
            parens p fun_priority f "@[%a %S =<< (%a :: IO %a)@]"
              self#printf () (format_type t)
              (self#expr nop) expr
              ptype t
      end
    | E.ReadIn (ty, next) -> self#read p f ty next
    | E.Skip ->  Format.fprintf f "skip_whitespaces"
    | E.Block [e] -> self#expr p f e
    | E.Block li -> self#block p f li
    | E.Record li -> (* TODO trier les champs dans le bon ordre et parentheser correctement *)
      let t = Typer.typename_for_field (snd (List.hd li) ) typerEnv in
      Format.fprintf f "@[<v>(%a <$> %a)@]"
        tname t
        (print_list
           (fun f (expr, field) ->
              hsapply fun_priority f (fun f () -> Format.fprintf f "newIORef") true
                [self#isPure expr, self#expr, expr])
           (sep "%a <*> %a")) li
    | E.RecordAccess (record, field) ->
      hsapply p f (fun f () -> Format.fprintf f "readIORef") true
        [self#isPure record, (fun p f () ->
             hsapply p f (fun f () -> Format.fprintf f "_%s" field) false
               [self#isPure record, self#expr, record]), ()]
    | E.RecordAffect (record, field, value) ->    hsapply p f (fun f () -> Format.fprintf f "writeIORef") true
      [self#isPure record, (fun p f () ->
           hsapply p f (fun f () -> Format.fprintf f "_%s" field) false
             [self#isPure record, self#expr, record]), ();
       self#isPure value, (fun p f () -> self#expr p f value), ()
      ]
    | E.ArrayMake (len, lambda, env) ->
      let f' e = self#isPure e, self#expr, e in    
      hsapply p f (fun f () -> Format.fprintf f "array_init_withenv") true [f' len; f' lambda; f' env]
    | E.ArrayInit (len, lambda) ->
      let f' e = self#isPure e, self#expr, e in    
      hsapply p f (fun f () -> Format.fprintf f "array_init") true [f' len; f' lambda]      
    | E.ArrayAccess (tab, indexes) -> self#arrayindex p f tab indexes
    | E.ArrayAffect (tab, indexes, v) ->
      begin match List.rev indexes with
        | [] -> assert false
        | hd::tl -> let tl = List.rev tl in
          let array_pure = self#isPure tab && List.for_all self#isPure tl in
          hsapply p f (fun f () -> Format.fprintf f "writeIOA") true
            [array_pure, (fun p f () -> self#arrayindex p f tab tl), ();
             self#isPure hd, (fun p f () -> self#expr p  f hd), (); 
             self#isPure v, (fun p f () -> self#expr p  f v), ()]
      end
    | E.LetIn (name, v, e') ->
      if self#isPure e then
        self#letin p f name v e' (self#expr nop)
      else self#block p f [e]

  method letin p f name v e pexpr =
    let pparams, v = extract_fun_params v (fun f () -> ()) in
    parens p (fun_priority -1) f "@[<h>let %a%a = @[<v>%a@\nin %a@]@]"
      binding name pparams () (self#expr nop) v pexpr e

  method read p f ty next =
    match Type.unfix ty, E.unfix next with

    | t, E.Fun ([o], E.Fixed.F(_, E.Lief (E.Binding o2) )) when o = o2 ->
      begin match t with
        | Type.Char -> Format.fprintf f "getChar"
        | Type.Integer -> Format.fprintf f "read_int"
        | _ -> assert false
      end
    | _, E.Fun ([_], _ ) -> self#block p f [ E.readin next ty]
    | Type.Integer, _ ->  parens p (fun_priority-1) f "@[<h>read_int >>=@[<v> (%a)@]@]" (self#expr nop) next
    | Type.Char, _ -> parens p (fun_priority-1) f "@[<h>getChar >>=@[<v> (%a)@]@]" (self#expr nop) next
    | _ -> assert false

  method arrayindex p f tab indexes =
    match List.rev indexes with
    | [] -> self#expr p f tab
    | hd::tl -> let tl = List.rev tl in
      let array_pure = self#isPure tab && List.for_all self#isPure tl in
      hsapply p f (fun f () -> Format.fprintf f "readIOA") true
        [array_pure, (fun p f () -> self#arrayindex p f tab tl), ();
         self#isPure hd, (fun p f () -> self#expr p f hd), ();]

  method decl f d = match d with
    | AstFun.Declaration (name, e) ->
      let pparams, e = extract_fun_params e (fun f () -> ()) in
      Format.fprintf f "@[<v 2>%a%a =@\n%a@]@\n" binding name pparams () (self#eM nop) e
    | AstFun.DeclareType (name, ty) ->
      begin match Type.unfix ty with
        | Type.Struct _ ->
          Format.fprintf f "@[<v 2>data %a = %a %a@]@\n  deriving Eq@\n@\n"
            tname name
            tname name 
            ptype ty
        | Type.Enum _ ->
          Format.fprintf f "@[<v 2>data %a = %a@]@\n  deriving Eq@\n@\n"
            tname name 
            ptype ty
        | _ ->
          Format.fprintf f "@[<v 2>type %a = %a@]@\n@\n"
            tname name 
            ptype ty
      end
    | AstFun.Macro (name, t, params, code) ->
      macros <- Ast.BindingMap.add
          name (t, params, code)
          macros;
      ()

  method prog (f:Format.formatter) (prog:AstFun.prog) =
    side_effects <- prog.AstFun.side_effects;
    let unsafeop op = AstFun.existsExpr (fun e ->
        match E.unfix e with
        | E.BinOp (a, op, b) -> self#isSideEffect a || self#isSideEffect b
        | _ -> false
      ) prog.AstFun.declarations
    in
    let need_readint = Ast.TypeSet.mem (Type.integer) prog.AstFun.options.AstFun.reads in
    let ifm = prog.AstFun.options.AstFun.hasSkip || need_readint || AstFun.existsExpr (fun e ->
        match E.unfix e with
        | E.If (a, b, c) -> self#isSideEffect a || self#isSideEffect b || self#isSideEffect c
        | _ -> false
      ) prog.AstFun.declarations in
    let read_array = AstFun.existsExpr (fun e ->match E.unfix e with
        | E.ArrayAccess _ -> true
        | _ -> false ) prog.AstFun.declarations in
    let write_array = AstFun.existsExpr (fun e ->match E.unfix e with
        | E.ArrayAffect _ -> true
        | _ -> false ) prog.AstFun.declarations in
    let array_init = AstFun.existsExpr (fun e ->match E.unfix e with
        | E.ArrayInit _ -> true
        | _ -> false ) prog.AstFun.declarations in
    let array_make = AstFun.existsExpr (fun e ->match E.unfix e with
        | E.ArrayMake _ -> true
        | _ -> false ) prog.AstFun.declarations in
    Format.fprintf f "%a@\n@[%a@]@\n"
      (header (unsafeop Ast.Expr.And) (unsafeop Ast.Expr.Or) array_init array_make ifm read_array write_array) prog.AstFun.options
      (print_list self#decl sep_nl)
      prog.AstFun.declarations

end

let haskellPrinter = new haskellPrinter

