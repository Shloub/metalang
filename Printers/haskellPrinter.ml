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

module E = AstFun.Expr
module Type = Ast.Type

let hsapply f fun_ apply_side_effects args =
  match args with
  | [] -> Format.fprintf f "(%a ())" fun_ ()
  | [false, pr, x] when apply_side_effects -> Format.fprintf f "(%a >>= %a)" pr x fun_ ()
  | _ ->
      let count = if apply_side_effects then List.length args else 0 (* ne sera jamais atteind *) in
      let _, pure, p = List.fold_left
          (fun (c, pure, p) (isPure, parg, arg) ->
            match pure, isPure with
              (true, true) -> c+1, true, (fun f () -> Format.fprintf f "%a %a" p () parg arg)
            | (true, false) when c = count -> c+1, true, (fun f () -> Format.fprintf f "%a =<< %a" p () parg arg)
            | (true, false)  -> c+1, false, (fun f () -> Format.fprintf f "%a <$> %a" p () parg arg)
            | (false, false) -> c+1, false, (fun f () -> Format.fprintf f "%a <*> %a" p () parg arg)
            | (false, true) -> c+1, false, (fun f () -> Format.fprintf f "%a <*> return %a" p () parg arg)
          ) (1, true, fun_) args
      in
      if not pure && apply_side_effects then Format.fprintf f "(join $ %a)" p ()
      else Format.fprintf f "(%a)" p ()




class haskellPrinter = object(self)

  method lang () = "hs"

  val mutable macros = StringMap.empty
  val mutable side_effects = IntMap.empty
  val mutable typerEnv : Typer.env = Typer.empty
  method getTyperEnv () = typerEnv
  method setTyperEnv t = typerEnv <- t
  method typename_of_field field = Typer.typename_for_field field typerEnv

  method tname f name =
    Format.fprintf f "%s" (String.capitalize name)

  method binopstr = function
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

  method binopShortCut = function
    | Ast.Expr.And -> Some "<&&>"
    | Ast.Expr.Or -> Some "<||>"
    | _ -> None

  method binopf = function
    | Ast.Expr.Div
    | Ast.Expr.Mod -> true
    | _ -> false

  method pbinopf f op =
    if self#binopf op
    then Format.fprintf f "%s" (self#binopstr op)
    else Format.fprintf f "(%s)" (self#binopstr op)

  method pbinop f op =
    if self#binopf op
    then Format.fprintf f "`%s`" (self#binopstr op)
    else Format.fprintf f "%s" (self#binopstr op)

  method unopstr = function
    | Ast.Expr.Neg -> "-"
    | Ast.Expr.Not -> "not"

  method punop f op = Format.fprintf f "%s" (self#unopstr op)

  method binop f a op b =
    match self#isPure a, self#isPure b, self#binopShortCut op with
    | true, true, _ -> Format.fprintf f "(%a %a %a)" self#expr a self#pbinop op self#expr b
    | true, false, None -> Format.fprintf f "((%a %a) <$> %a)" self#pbinopf op self#expr a self#expr b
    | _, _, None -> Format.fprintf f "(%a <$> %a <*> %a)" self#pbinopf op self#eM a self#eM b
    | _, _, Some s -> Format.fprintf f "(%a %s %a)" self#eM a s self#eM b
  method unop f a op =
    if self#isPure a then
      Format.fprintf f "(%a %a)"self#punop op self#expr a
    else
      Format.fprintf f "(fmap (%a) %a)"self#punop op self#expr a

  method comment fe f str c = Format.fprintf f "@[<v>{-%s-}@\n%a@]" str fe c

  method fun_ f params e =
    let pparams, e = self#extract_fun_params (E.fun_ params e) (fun f () -> ()) in
    Format.fprintf f "@[<v 2>(\\%a ->@\n%a)@]" pparams () self#eM e

  method funtuple f params e =
    let pparams, e = self#extract_fun_params (E.funtuple params e) (fun f () -> ()) in
    Format.fprintf f "@[<v 2>(\\%a ->@\n%a)@]" pparams () self#eM e

  method letrecin f name params e1 e2 = match params with
  | [] -> Format.fprintf f "let %a @[<v>() =@\n%a in@\n%a@]"
        self#binding name
        self#expr e1
        self#expr e2
  | _ ->
      Format.fprintf f "let %a @[<v>%a =@\n%a in@\n%a@]"
        self#binding name
        (Printer.print_list
           self#binding
           Printer.sep_space) params
        self#expr e1
        self#expr e2

  method isSideEffect expr = IntMap.find (E.Fixed.annot expr) side_effects
  method isPure expr = not (self#isSideEffect expr)

  method eM f expr =
    match E.unfix expr with
    | E.Comment (s, c) -> self#comment self#eM f s c
    | E.Block _ -> self#expr f expr
    | E.LetIn (name, v, e) ->
        if self#isPure expr then self#letin f name v e self#eM
        else self#expr f expr
    | _ ->
        if self#isSideEffect expr then
          self#expr f expr
        else Format.fprintf f "return %a" self#expr expr

  method binding f s = Format.fprintf f "%s" s

  method format_type f t = Format.fprintf f "%S" (Printer.format_type t)

  method lief f = function
    | E.Error -> Format.fprintf f "(assert false)"
    | E.Unit -> Format.fprintf f "()"
    | E.Char c -> Format.fprintf f "%C" c
    | E.String s -> Format.fprintf f "%S" s
    | E.Integer i -> Format.fprintf f "%i" i
    | E.Bool true -> Format.fprintf f "True"
    | E.Bool false -> Format.fprintf f "False"
    | E.Enum s -> Format.fprintf f "%s" s
    | E.Binding s -> self#binding f s

  method expand_macro_call f name t params code li =
    let lang = self#lang () in
    let code_to_expand = List.fold_left
        (fun acc (clang, expantion) ->
          match acc with
          | Some _ -> acc
          | None ->
              if clang = "" || clang = lang then
                Some expantion
              else None
        ) None
        code
    in match code_to_expand with
    | None -> failwith ("no definition for macro "^name^" in language "^lang)
    | Some s ->
        let listr = List.map
            (fun e ->
              let b = Buffer.create 1 in
              let fb = Format.formatter_of_buffer b in
              Format.fprintf fb "@[<h>%a@]%!" self#eM e;
              Buffer.contents b
            ) li in
        let expanded = List.fold_left
            (fun s ((param, _type), string) ->
              String.replace ("$"^param) string s
            )
            s
            (List.combine params listr)
        in Format.fprintf f "(%s)" expanded

  method apply_nomacros f e li =
    let li = List.map (fun e -> self#isPure e, self#expr, e) li in
    hsapply f (fun f () -> self#expr f e) true li

  method apply f e li =
    let default () = self#apply_nomacros f e li in
    match E.unfix e with
    | E.Lief ( E.Binding binding ) ->
      begin match StringMap.find_opt binding macros with
      | None -> default ()
      | Some ((t, params, code)) -> self#expand_macro_call f binding t params code li
      end
    | _ -> default ()

  method tuple f li = Format.fprintf f "(%a)"
    (Printer.print_list self#expr
       (fun f pa a pb b -> Format.fprintf f "%a, %a" pa a pb b)) li

  method if_ f e1 e2 e3 =
    let p =	if self#isPure e2 && self#isPure e3 then self#expr else self#eM in
    if self#isPure e1 then
      Format.fprintf f "@[<v>(if %a@\nthen %a@\nelse %a)@]" self#expr e1 p e2 p e3
    else
      Format.fprintf f "@[<h>ifM @[<v>%a@\n(%a)@\n(%a)@]@]" self#eM e1 self#eM e2 self#eM e3
        
  method blockContent f li =
    Printer.print_list
      (fun f e ->
        match E.unfix e with
        | E.ReadIn( Type.Fixed.F(_, Type.Integer),
	      E.Fixed.F(_, E.Fun ( [name], next))
	     ) ->
	       Format.fprintf f "@[<h>%a <- read_int@]@\n%a" self#binding name
	         self#blockContent [next]
        | E.Block li -> self#blockContent f li
        | E.LetIn (s, v, e) ->
            let isfun, (pparams, a) = self#extract_fun_params' v (fun f () -> ()) in
            if self#isPure v then
	Format.fprintf f "@[<h>let %a%a = @[<v>%a@]@]@\n%a" self#binding s pparams ()
	  (if isfun then self#eM else self#expr) a
	  self#blockContent [e]
            else
	Format.fprintf f "@[<h>%a%a <-@[<v> %a@]@]@\n%a" self#binding s pparams () self#expr a
	  self#blockContent [e]
        | _ -> self#eM f e
      )
      (fun f pa a pb b -> Format.fprintf f "%a@\n%a" pa a pb b) f li
			
  method block f li = Format.fprintf f "do @[<v>%a@]"
      self#blockContent li
			
  method printf f () = Format.fprintf f "printf"

  method print f expr t =
		match E.unfix expr with
		| E.Lief (E.String s) -> Format.fprintf f "%a %S ::IO()" self#printf () s
		| _ ->
				if self#isPure expr then
					Format.fprintf f "@[%a %a (%a :: %a)::IO()@]"
						self#printf ()
						self#format_type t
						self#expr expr
						self#ptype t
				else
					Format.fprintf f "@[%a %a =<< (%a :: IO %a)@]"
						self#printf ()
						self#format_type t
						self#expr expr
						self#ptype t

  method expr f e = match E.unfix e with
  | E.LetRecIn (name, params, e1, e2) -> self#letrecin f name params e1 e2
  | E.BinOp (a, op, b) -> self#binop f a op b
  | E.UnOp (a, op) -> self#unop f a op
  | E.Fun (params, e) -> self#fun_ f params e
  | E.FunTuple (params, e) -> self#funtuple f params e
  | E.Apply (e, li) -> self#apply f e li
  | E.Tuple li -> self#tuple f li
  | E.Lief l -> self#lief f l
  | E.Comment (s, c) -> self#comment self#expr f s c
  | E.If (e1, e2, e3) -> self#if_ f e1 e2 e3
  | E.Print (e, ty) ->
    self#print f e ty
  | E.ReadIn (ty, next) -> self#read f ty next
  | E.Skip -> self#skip f
  | E.Block li -> self#block f li
  | E.Record li -> self#record f li
  | E.RecordAccess (record, field) -> self#recordaccess f record field
  | E.RecordAffect (record, field, value) -> self#recordaffect f record field value
  | E.ArrayMake (len, lambda, env) -> self#arraymake f len lambda env
  | E.ArrayAccess (tab, indexes) -> self#arrayindex f tab indexes
  | E.ArrayAffect (tab, indexes, v) -> self#arrayaffect f tab indexes v
  | E.LetIn (name, v, e') ->
			if self#isPure e then
				self#letin f name v e' self#expr
				else self#block f [e]

	method letin f name v e pexpr =
    let pparams, v = self#extract_fun_params v (fun f () -> ()) in
		Format.fprintf f "@[<h>let %a%a = @[<v>%a@\nin %a@]@]"
			self#binding name pparams () self#expr v pexpr e

  method recordaccess f record field  =
		hsapply f (fun f () -> Format.fprintf f "readIORef") true
			[self#isPure record, (fun f () ->
				hsapply f (fun f () -> Format.fprintf f "_%s" field) false
					[self#isPure record, self#expr, record]), ()]

  method recordaffect f record field value =
	  hsapply f (fun f () -> Format.fprintf f "writeIORef") true
	    [self#isPure record, (fun f () ->
				hsapply f (fun f () -> Format.fprintf f "_%s" field) false
					[self#isPure record, self#expr, record]), ();
			 self#isPure value, (fun f () -> self#expr f value), ()
		 ]

  method record f li = (* TODO trier les champs dans le bon ordre *)
    let t = Typer.typename_for_field (snd (List.hd li) ) typerEnv in
    Format.fprintf f "@[<v>(%a <$> %a)@]"
      self#tname t
      (Printer.print_list
         (fun f (expr, field) ->
           hsapply f (fun f () -> Format.fprintf f "newIORef") true
             [self#isPure expr, self#expr, expr])
         (fun f pa a pb b -> Format.fprintf f "%a <*> %a" pa a pb b)) li

  method skip f = Format.fprintf f "skip_whitespaces"

  method read f ty next =
    match Type.unfix ty, E.unfix next with
    | Type.Integer, E.Fun ( [name], next) ->
        Format.fprintf f "do @[<v>@[<h>%a <- read_int@]@\n%a@]" self#binding name
          self#blockContent [next]
    | Type.Integer, _ -> Format.fprintf f "@[<h>read_int >>=@[<v> (%a)@]@]" self#expr next
    | Type.Char, _ -> Format.fprintf f "@[<h>hGetChar stdin >>=@[<v> (%a)@]@]" self#expr next
    | _ -> assert false

  method arraymake f len lambda env =
    let f' e = self#isPure e, self#expr, e in    
    hsapply f (fun f () -> Format.fprintf f "array_init_withenv") true
      [f' len; f' lambda; f' env]

  method arrayindex f tab indexes =
    match List.rev indexes with
    | [] -> self#expr f tab
    | hd::tl -> let tl = List.rev tl in
      let array_pure = self#isPure tab && List.for_all self#isPure tl in
      hsapply f (fun f () -> Format.fprintf f "readIOA") true
        [array_pure, (fun f () -> self#arrayindex f tab tl), () ;
         self#isPure hd, (fun f () -> self#expr f hd), ();]

  method arrayaffect f tab indexes v =			
    match List.rev indexes with
    | [] -> assert false
    | hd::tl -> let tl = List.rev tl in
      let array_pure = self#isPure tab && List.for_all self#isPure tl in
      hsapply f (fun f () -> Format.fprintf f "writeIOA") true
      [array_pure, (fun f () -> self#arrayindex f tab tl), () ;
       self#isPure hd, (fun f () -> self#expr f hd), (); 
       self#isPure v, (fun f () -> self#expr f v), ()]

  (** show a type *)
  method ptype f (t : Type.t ) =
    match Type.Fixed.unfix t with
    | Type.Integer -> Format.fprintf f "Int"
    | Type.String -> Format.fprintf f "String"
    | Type.Array a -> Format.fprintf f "(IOArray Int %a)" self#ptype a
    | Type.Void ->  Format.fprintf f "()"
    | Type.Bool -> Format.fprintf f "Bool"
    | Type.Char -> Format.fprintf f "Char"
    | Type.Named n -> self#tname f n
    | Type.Struct li ->
      Format.fprintf f "{@[<v 2>@\n%a@\n}@]"
        (Printer.print_list
           (fun t (name, type_) ->
             Format.fprintf t "_%s :: IORef %a" name self#ptype type_
           )
           (fun f pa a pb b -> Format.fprintf f "%a,@\n%a" pa a pb b)
        ) li
    | Type.Enum li ->
      Format.fprintf f "%a"
        (Printer.print_list
           (fun t name ->
             Format.fprintf t "%s" name
           )
           (fun t fa a fb b -> Format.fprintf t "%a@\n| %a" fa a fb b)
        ) li
    | Type.Lexems -> assert false
    | Type.Auto -> assert false
    | Type.Tuple li ->
      Format.fprintf f "(%a)"
        (Printer.print_list self#ptype (fun t fa a fb b -> Format.fprintf t "%a, %a" fa a fb b)) li

  method extract_fun_params e acc = snd @$ self#extract_fun_params' e acc
  method extract_fun_params' e acc = match E.unfix e with
  | E.Fun ([], e) ->
    let acc f () = Format.fprintf f "%a ()" acc ()
    in true, self#extract_fun_params e acc
  | E.Fun (params, e) ->
    let acc f () = Format.fprintf f "%a %a" acc () (Printer.print_list self#binding (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)) params
    in true, self#extract_fun_params e acc
  | E.FunTuple (params, e) ->
    let acc f () = Format.fprintf f "%a (%a)" acc () (Printer.print_list self#binding (fun f pa a pb b -> Format.fprintf f "%a, %a" pa a pb b)) params
    in true, self#extract_fun_params e acc
  | _ -> false, (acc, e)

  method toplvl_declare f name e = 
    let pparams, e = self#extract_fun_params e (fun f () -> ()) in
    Format.fprintf f "@[<v 2>%a%a =@\n%a@]@\n"
      self#binding name pparams () self#eM e

  method toplvl_declarety f name ty = match Type.unfix ty with
  | Type.Struct _ ->
      Format.fprintf f "@[<v 2>data %a = %a %a@]@\n  deriving Eq@\n@\n"
        self#tname name
        self#tname name 
        self#ptype ty
  | Type.Enum _ ->
      Format.fprintf f "@[<v 2>data %a = %a@]@\n  deriving Eq@\n@\n"
        self#tname name 
        self#ptype ty
  | _ ->
      Format.fprintf f "@[<v 2>type %a = %a@]@\n@\n"
        self#tname name 
        self#ptype ty

  method decl f d = match d with
  | AstFun.Declaration (name, e) -> self#toplvl_declare f name e
  | AstFun.DeclareType (name, ty) -> self#toplvl_declarety f name ty
  | AstFun.Macro (name, t, params, code) ->
      macros <- StringMap.add
        name (t, params, code)
        macros;
      ()

  method header binand binor ifm f opts =
    let need_stdinsep = opts.AstFun.hasSkip in
    let need_readint = Ast.TypeSet.mem (Type.integer) opts.AstFun.reads in
    let need_readchar = Ast.TypeSet.mem (Type.char) opts.AstFun.reads in
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
    Format.fprintf f "@[%a@]
%a%a%a
main :: IO ()

@[%a@]@[%a@]@[%a@]
"
          (Printer.print_list (fun f s -> Format.fprintf f "import %s" s)
             (fun f pa a pb b -> Format.fprintf f "%a@\n%a" pa a pb b))
          imports
(fun f () -> if binand then Format.fprintf f "
(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False
") ()
(fun f () -> if binor then Format.fprintf f "
(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b
") ()
(fun f () -> if ifm then Format.fprintf f "
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_
") ()


          (fun f () -> if need_stdinsep then
            Format.fprintf f "
skip_whitespaces :: IO ()
skip_whitespaces =
  ifM (hIsEOF stdin)
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\\n' || c == '\\t' || c == '\\r' then
           do hGetChar stdin
              skip_whitespaces
           else return ())@\n"
          ) ()
          (fun f () -> if need_readint then
            Format.fprintf f "
read_int_a :: Int -> IO Int
read_int_a b =
  ifM (hIsEOF stdin)
      (return b)
      (do c <- hLookAhead stdin
          if c >= '0' && c <= '9' then
           do hGetChar stdin
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\\x -> -1::Int) $ hGetChar stdin
                 else return 1
      num <- read_int_a 0
      return (num * sign)@\n"
) ()
(fun f () ->
    if Tags.is_taged "__internal__allocArray" then
      Format.fprintf f "
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

array_init_withenv :: Int -> ( Int -> env -> IO(env, tabcontent)) -> env -> IO(env, IOArray Int tabcontent)
array_init_withenv len f env =
  do (env, li) <- g 0 env
     o <- newListArray (0, len - 1) li
     return (env, o)
  where g i env =
           if i == len
           then return (env, [])
           else do (env', item) <- f i env
                   (env'', li) <- g (i+1) env'
                   return (env'', item:li)@\n") ()

  method prog (f:Format.formatter) (prog:AstFun.prog) =
    side_effects <- prog.AstFun.side_effects;
    let unsafeop op = AstFun.existsExpr (fun e ->
      match E.unfix e with
      | E.BinOp (a, op, b) ->
          IntMap.find (E.Fixed.annot a) prog.AstFun.side_effects ||
          IntMap.find (E.Fixed.annot b) prog.AstFun.side_effects
        | _ -> false
      ) prog.AstFun.declarations
    in
    let need_readint = Ast.TypeSet.mem (Type.integer) prog.AstFun.options.AstFun.reads in
    let ifm = prog.AstFun.options.AstFun.hasSkip || need_readint || AstFun.existsExpr (fun e ->
      match E.unfix e with
      | E.If (a, b, c) ->
          IntMap.find (E.Fixed.annot a) prog.AstFun.side_effects ||
          IntMap.find (E.Fixed.annot b) prog.AstFun.side_effects ||
          IntMap.find (E.Fixed.annot c) prog.AstFun.side_effects
        | _ -> false
      ) prog.AstFun.declarations in
    Format.fprintf f "%a@\n@[%a@]@\n"
    (self#header (unsafeop Ast.Expr.And) (unsafeop Ast.Expr.Or) ifm) prog.AstFun.options
    (Printer.print_list self#decl
       (fun f pa a pb b -> Format.fprintf f "%a@\n%a" pa a pb b))
prog.AstFun.declarations




end

let haskellPrinter = new haskellPrinter

