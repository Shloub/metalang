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

class haskellPrinter = object(self)

  method lang () = "hs"

  val mutable macros = StringMap.empty
  val mutable side_effects = IntMap.empty
  val mutable typerEnv : Typer.env = Typer.empty
  method getTyperEnv () = typerEnv
  method setTyperEnv t = typerEnv <- t
  method typename_of_field field = Typer.typename_for_field field typerEnv

  method binopstr = function
  | Ast.Expr.Add -> "+"
  | Ast.Expr.Sub -> "-"
  | Ast.Expr.Mul -> "*"
  | Ast.Expr.Div -> "`div`"
  | Ast.Expr.Mod -> "`rem`"
  | Ast.Expr.Or -> "||"
  | Ast.Expr.And -> "&&"
  | Ast.Expr.Lower -> "<"
  | Ast.Expr.LowerEq -> "<="
  | Ast.Expr.Higher -> ">"
  | Ast.Expr.HigherEq -> ">="
  | Ast.Expr.Eq -> "=="
  | Ast.Expr.Diff -> "/="

  method unopstr = function
  | Ast.Expr.Neg -> "-"
  | Ast.Expr.Not -> "not"

  method pbinop f op = Format.fprintf f "%s" (self#binopstr op)
  method punop f op = Format.fprintf f "%s" (self#unopstr op)

  method binop f a op b = Format.fprintf f "(%a %a %a)" self#expr a self#pbinop op self#expr b
  method unop f a op = Format.fprintf f "(%a %a)"self#punop op self#expr a

  method comment f str c = Format.fprintf f "{-%s-}@\n%a" str self#expr c

  method fun_ f params e =
    let pparams, e = self#extract_fun_params (E.fun_ params e) (fun f () -> ()) in
    Format.fprintf f "(\\%a -> %a)" pparams () self#expr e

  method funtuple f params e =
    let pparams, e = self#extract_fun_params (E.funtuple params e) (fun f () -> ()) in
    Format.fprintf f "(\\%a -> %a)" pparams () self#expr e

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
    if self#isSideEffect expr then
      self#expr f expr
    else Format.fprintf f "return %a" self#expr expr

  method ignore f e1 e2 = Format.fprintf f "do %a@\n%a" self#eM e1 self#eM e2

  method binding f s = Format.fprintf f "%s" s

  method format_type f t = Format.fprintf f "%S" (Printer.format_type t)


  method read f ty next =
    Format.fprintf f "Scanf.scanf %a@\n%a"
      self#format_type ty
      self#expr next

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
          if clang = "" or clang = lang then
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
          Format.fprintf fb "@[<h>%a@]%!" self#expr e;
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
    match li with
    | [] -> Format.fprintf f "(%a ())" self#expr e
    | _ ->
      let count = List.length li in
      let _, pure, p = List.fold_left
        (fun (c, pure, p) arg ->
          let c1 = c + 1 in
          if c = count then
            match pure, self#isPure arg with
              (true, true) -> (c1, true, (fun f () -> Format.fprintf f "%a %a" p () self#expr arg))
            | (true, false) -> (c1, false, (fun f () -> Format.fprintf f "%a =<< %a" p () self#expr arg))
            | (false, false) -> (c1, false, (fun f () -> Format.fprintf f "join (%a <*> %a)" p () self#expr arg))
            | (false, true) -> (c1, false, (fun f () -> Format.fprintf f "join (%a <*> (return %a))" p () self#expr arg))
          else
            match pure, self#isPure arg with
              (true, true) -> (c1, true, (fun f () -> Format.fprintf f "%a %a" p () self#expr arg))
            | (true, false) -> (c1, false, (fun f () -> Format.fprintf f "%a <$> %a" p () self#expr arg))
            | (false, false) -> (c1, false, (fun f () -> Format.fprintf f "%a <*> %a" p () self#expr arg))
            | (false, true) -> (c1, false, (fun f () -> Format.fprintf f "%a <*> (return %a)" p () self#expr arg))
        ) (1, true, (fun f () -> self#expr f e)) li
      in Format.fprintf f " (%a)" p ()

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

  method if_ f e1 e2 e3 = Format.fprintf f "(@[if %a@\nthen %a@\nelse %a)@]" self#expr e1 self#expr e2 self#expr e3

  method block f li = Format.fprintf f "@[<v 2>do {@\n%a@\n}@]@\n"
    (Printer.print_list
       self#eM
       (fun f pa a pb b -> Format.fprintf f "%a;@\n%a" pa a pb b)) li


  method printf f () = Format.fprintf f "printf"

  method print f expr t =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[(%a %a (%a :: %a))::IO()@]"
        self#printf ()
        self#format_type t
        self#expr expr
        self#ptype t
    | _ -> 
      Format.fprintf f "@[(%a %a %a)::IO()@]"
        self#printf ()
        self#format_type t
        self#expr expr

  method expr f e = match E.unfix e with
  | E.LetRecIn (name, params, e1, e2) -> self#letrecin f name params e1 e2
  | E.BinOp (a, op, b) -> self#binop f a op b
  | E.UnOp (a, op) -> self#unop f a op
  | E.Fun (params, e) -> self#fun_ f params e
  | E.FunTuple (params, e) -> self#funtuple f params e
  | E.Apply (e, li) -> self#apply f e li
  | E.Tuple li -> self#tuple f li
  | E.Lief l -> self#lief f l
  | E.Comment (s, c) -> self#comment f s c
  | E.Ignore (e1, e2) -> self#ignore f e1 e2
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
  | E.LetIn (params, b) -> self#letin f params b

  method recordaccess f record field  =
    Format.fprintf f "%a.%s" self#expr record field

  method recordaffect f record field value =
    Format.fprintf f "%a.%s <- %a"
      self#expr record field
      self#expr value

  method record f li =
    Format.fprintf f "{%a}"
      (Printer.print_list
	 (fun f (expr, field) -> Format.fprintf f "%s=%a" field self#expr expr)
	 (fun f pa a pb b -> Format.fprintf f "%a;@\n%a" pa a pb b)) li

  method skip f = Format.fprintf f "(Scanf.scanf \"%%[\\n \\010]\" (fun _ -> ()))"

  method arraymake f len lambda env = Format.fprintf f "(Array.init_withenv %a %a %a)" self#expr len self#expr lambda self#expr env

  method arrayindex f tab indexes =
    Format.fprintf f "%a.(%a)"
      self#expr tab
      (Printer.print_list self#expr
	 (fun f pa a pb b -> Format.fprintf f "%a).(%a" pa a pb b)) indexes

  method arrayaffect f tab indexes v =
    Format.fprintf f "%a.(%a) <- %a"
      self#expr tab
      (Printer.print_list self#expr
	 (fun f pa a pb b -> Format.fprintf f "%a).(%a" pa a pb b)) indexes
      self#expr v

  method letin f params b  = Format.fprintf f "let %a in@\n%a"
    (Printer.print_list
       (fun f (s, a) ->
	 let pparams, a = self#extract_fun_params a (fun f () -> ()) in
	 Format.fprintf f "%a%a =@[<v> %a@]"
	   self#binding s pparams () self#expr a
       )
       (fun f pa a pb b -> Format.fprintf f "%a@\nand %a" pa a pb b))
    params
    self#expr b

  (** show a type *)
  method ptype f (t : Type.t ) =
    match Type.Fixed.unfix t with
    | Type.Integer -> Format.fprintf f "Int"
    | Type.String -> Format.fprintf f "String"
    | Type.Array a -> Format.fprintf f "%a array" self#ptype a
    | Type.Void ->  Format.fprintf f "()"
    | Type.Bool -> Format.fprintf f "Bool"
    | Type.Char -> Format.fprintf f "Char"
    | Type.Named n -> Format.fprintf f "%s" n
    | Type.Struct li ->
      Format.fprintf f "{%a}"
        (Printer.print_list
           (fun t (name, type_) ->
             Format.fprintf t "mutable %s : %a;" name self#ptype type_
           )
           Printer.sep_space
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

  method is_rec name e =
    E.Writer.Deep.fold (fun acc e -> acc || match E.unfix e with
    | E.Lief (E.Binding n) -> n = name
    | _ -> false) false e

  method extract_fun_params e acc = match E.unfix e with
  | E.Fun ([], e) ->
    let acc f () = Format.fprintf f "%a ()" acc ()
    in self#extract_fun_params e acc
  | E.Fun (params, e) ->
    let acc f () = Format.fprintf f "%a %a" acc () (Printer.print_list self#binding (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)) params
    in self#extract_fun_params e acc
  | E.FunTuple (params, e) ->
    let acc f () = Format.fprintf f "%a (%a)" acc () (Printer.print_list self#binding (fun f pa a pb b -> Format.fprintf f "%a, %a" pa a pb b)) params
    in self#extract_fun_params e acc
  | _ -> acc, e

  method toplvl_declare f name e = 
    let pparams, e = self#extract_fun_params e (fun f () -> ()) in
    Format.fprintf f "@[<v 2>%s%a%a = %a@]@\n" (if self#is_rec name e then "rec " else "")
      self#binding name pparams () self#expr e

  method toplvl_declarety f name ty = Format.fprintf f "@[<v 2>type %a = %a@]@\n"
    self#binding name self#ptype ty

  method decl f d = match d with
  | AstFun.Declaration (name, e) -> self#toplvl_declare f name e
  | AstFun.DeclareType (name, ty) -> self#toplvl_declarety f name ty
  | AstFun.Macro (name, t, params, code) ->
      macros <- StringMap.add
        name (t, params, code)
        macros;
      ()

  method header f opts =
    Format.fprintf f "import Text.Printf@\nimport Control.Applicative@\nimport Control.Monad@\n";
    if Tags.is_taged "__internal__allocArray" then
      Format.fprintf f
	"module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    )
end
"

  method prog (f:Format.formatter) (prog:AstFun.prog) =
    side_effects <- prog.AstFun.side_effects;
    self#header f prog.AstFun.options;
    List.iter (self#decl f) prog.AstFun.declarations




end

let haskellPrinter = new haskellPrinter

