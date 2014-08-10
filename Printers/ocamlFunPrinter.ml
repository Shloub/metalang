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
 *
 *)

open Stdlib

module E = AstFun.Expr
module Type = Ast.Type

class camlFunPrinter = object(self)

  method lang () = "ml"

  val mutable macros = Ast.BindingMap.empty

  val mutable typerEnv : Typer.env = Typer.empty
  method getTyperEnv () = typerEnv
  method setTyperEnv t = typerEnv <- t

  method binopstr = function
  | Ast.Expr.Add -> "+"
  | Ast.Expr.Sub -> "-"
  | Ast.Expr.Mul -> "*"
  | Ast.Expr.Div -> "/"
  | Ast.Expr.Mod -> "mod"
  | Ast.Expr.Or -> "||"
  | Ast.Expr.And -> "&&"
  | Ast.Expr.Lower -> "<"
  | Ast.Expr.LowerEq -> "<="
  | Ast.Expr.Higher -> ">"
  | Ast.Expr.HigherEq -> ">="
  | Ast.Expr.Eq -> "="
  | Ast.Expr.Diff -> "<>"

  method unopstr = function
  | Ast.Expr.Neg -> "-"
  | Ast.Expr.Not -> "not"

  method pbinop f op = Format.fprintf f "%s" (self#binopstr op)
  method punop f op = Format.fprintf f "%s" (self#unopstr op)

  method comment f s c = Format.fprintf f "(* %s *)@\n%a" s self#expr c
  method binop f a op b = Format.fprintf f "(%a %a %a)" self#expr a self#pbinop op self#expr b
  method unop f a op = Format.fprintf f "(%a %a)"self#punop op self#expr a
  method fun_ f params e =
    match params with
    | [] -> Format.fprintf f "(fun () -> %a)" self#expr e
    | _ -> Format.fprintf f "(fun@[ %a ->@\n%a@])"
      (Printer.print_list
         self#binding
         (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)) params
      self#expr e

  method letrecin f name params e1 e2 = match params with
  | [] -> Format.fprintf f "@[<v 2>let rec %a () =@\n%a in@\n%a@]"
    self#binding name
    self#expr e1
    self#expr e2
  | _ ->
    Format.fprintf f "@[<v 2>let rec %a %a =@\n%a in@\n%a@]"
      self#binding name
      (Printer.print_list
         self#binding
         (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)) params
      self#expr e1
      self#expr e2

  method funtuple f params e =
    match params with
    | [] -> Format.fprintf f "(fun () -> %a)" self#expr e
    | _ -> Format.fprintf f "(fun@[ (%a) ->@\n%a@])"
      (Printer.print_list
         self#binding
         (fun f pa a pb b -> Format.fprintf f "%a, %a" pa a pb b)) params
      self#expr e

  method ignore f e1 e2 = Format.fprintf f "%a;@\n%a" self#expr e1 self#expr e2

  method binding f s = Format.fprintf f "%s" s

  method print f e ty next =
    Format.fprintf f "(Printf.printf %S %a;@\n%a)"
      (Printer.format_type ty)
      self#expr e
      self#expr next

  method read f ty next =
    Format.fprintf f "Scanf.scanf %S %a"
      (Printer.format_type ty)
      self#expr next

  method lief f = function
  | E.Error -> Format.fprintf f "(assert false)"
  | E.Unit -> Format.fprintf f "()"
  | E.Char c -> Format.fprintf f "%C" c
  | E.String s -> Format.fprintf f "%S" s
  | E.Integer i -> Format.fprintf f "%i" i
  | E.Bool true -> Format.fprintf f "true"
  | E.Bool false -> Format.fprintf f "false"
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

  method apply f e li =
    let default () =
      match li with
      | [] -> Format.fprintf f "(%a ())" self#expr e
      | _ -> Format.fprintf f "(%a %a)"
	self#expr e
	(Printer.print_list
	   self#expr
	   (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)) li
    in
    match E.unfix e with
    | E.Lief ( E.Binding binding ) ->
      begin match Ast.BindingMap.find_opt binding macros with
      | None -> default ()
      | Some ((t, params, code)) -> self#expand_macro_call f binding t params code li
      end
    | _ -> default ()

  method tuple f li = Format.fprintf f "(%a)"
    (Printer.print_list self#expr
       (fun f pa a pb b -> Format.fprintf f "%a, %a" pa a pb b)) li

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
  | E.If (e1, e2, e3) ->
    Format.fprintf f "(@[if %a@\nthen %a@\nelse %a)@]"
      self#expr e1 self#expr e2 self#expr e3
  | E.Print (e, ty, next) ->
    self#print f e ty next
  | E.ReadIn (ty, next) -> self#read f ty next
  | E.SkipIn (e) ->
    Format.fprintf f "(Scanf.scanf \"%%[\\n \\010]\" (fun _ -> %a))" self#expr e
  | E.Block li ->
    Format.fprintf f "@[<v 2>begin@\n%a@\nend@]@\n"
      (Printer.print_list
         self#expr
         (fun f pa a pb b -> Format.fprintf f "%a;@\n%a" pa a pb b)) li
  | E.Record li -> Format.fprintf f "{%a}"
    (Printer.print_list
       (fun f (expr, field) -> Format.fprintf f "%s=%a" field self#expr expr)
       (fun f pa a pb b -> Format.fprintf f "%a;@\n%a" pa a pb b)) li
  | E.RecordAccess (record, field) -> Format.fprintf f "%a.%s" self#expr record field
  | E.RecordAffectIn (record, field, value, in_) ->
    Format.fprintf f "(%a.%s <- %a; %a)"
      self#expr record field
      self#expr value self#expr in_
  | E.ArrayMake (len, lambda) ->
    Format.fprintf f "(Array.init_withenv %a %a )" self#expr len self#expr lambda
  | E.ArrayAccess (tab, indexes) ->
    Format.fprintf f "%a.(%a)"
      self#expr tab
      (Printer.print_list self#expr
	 (fun f pa a pb b -> Format.fprintf f "%a).(%a" pa a pb b)) indexes
  | E.ArrayAffectIn (tab, indexes, v, in_) ->
    Format.fprintf f "(%a.(%a) <- %a; %a)"
      self#expr tab
      (Printer.print_list self#expr
	 (fun f pa a pb b -> Format.fprintf f "%a).(%a" pa a pb b)) indexes
    self#expr v
    self#expr in_

  (** show a type *)
  method ptype f (t : Type.t ) =
    match Type.Fixed.unfix t with
    | Type.Integer -> Format.fprintf f "int"
    | Type.String -> Format.fprintf f "string"
    | Type.Array a -> Format.fprintf f "%a array" self#ptype a
    | Type.Void ->  Format.fprintf f "void"
    | Type.Bool -> Format.fprintf f "bool"
    | Type.Char -> Format.fprintf f "char"
    | Type.Named n -> Format.fprintf f "%s" n
    | Type.Struct li ->
      Format.fprintf f "{%a}"
        (Printer.print_list
           (fun t (name, type_) ->
             Format.fprintf t "mutable %s : %a;" name self#ptype type_
           )
           (fun t fa a fb b -> Format.fprintf t "%a %a" fa a fb b)
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

  method decl f d = match d with
  | AstFun.Declaration (name, e) ->
    Format.fprintf f "@[<v 2>let rec %a =@\n%a@];;@\n" (* TODO is_rec ?*)
      self#binding name self#expr e
  | AstFun.DeclareType (name, ty) ->
    Format.fprintf f "@[<v 2>type %a = %a@];;@\n"
      self#binding name self#ptype ty
  | AstFun.Macro (name, t, params, code) ->
      macros <- Ast.BindingMap.add
        name (t, params, code)
        macros;
      ()

  method header f () = Format.fprintf f
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
    self#header f ();
    List.iter (self#decl f) prog

end

let camlFunPrinter = new camlFunPrinter

