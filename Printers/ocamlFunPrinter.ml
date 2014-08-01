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

module E = AstFun.Expr

class camlFunPrinter = object(self)

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

  method comment f s c = Format.fprintf f "(* %s *) %a" s self#expr c
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

  method ignore f e1 e2 = Format.fprintf f "%a;@\n%a" self#expr e1 self#expr e2

  method binding f s = Format.fprintf f "%s" s

  method print f e ty next =
    Format.fprintf f "Printf.printf %S %a;@\n%a"
      (Printer.format_type ty)
      self#expr e
      self#expr next

  method read f ty next =
    Format.fprintf f "Scanf.Scanf %S %a"
      (Printer.format_type ty)
      self#expr next

  method lief f = function
  | E.Unit ->  Format.fprintf f "()"
  | E.Char c -> Format.fprintf f "%C" c
  | E.String s -> Format.fprintf f "%S" s
  | E.Integer i -> Format.fprintf f "%i" i
  | E.Bool true -> Format.fprintf f "true"
  | E.Bool false -> Format.fprintf f "false"
  | E.Enum s -> Format.fprintf f "%s" s
  | E.Binding s -> self#binding f s

  method apply f e li = match li with
  | [] -> Format.fprintf f "(%a ())" self#expr e
  | _ -> Format.fprintf f "(%a %a)"
    self#expr e
    (Printer.print_list
       self#expr
       (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)) li

  method expr f e = match E.unfix e with
  | E.BinOp (a, op, b) -> self#binop f a op b
  | E.UnOp (a, op) -> self#unop f a op
  | E.Fun (params, e) -> self#fun_ f params e
  | E.Apply (e, li) -> self#apply f e li
  | E.Lief l -> self#lief f l
  | E.Comment (s, c) -> self#comment f s c
  | E.Ignore (e1, e2) -> self#ignore f e1 e2
  | E.If (e1, e2, e3) ->
    Format.fprintf f "(@[if %a@\nthen %a@\nelse %a)@]"
      self#expr e1 self#expr e2 self#expr e3
  | E.Print (e, ty, next) ->
    self#print f e ty next
  | E.ReadIn (ty, next) ->
    self#read f ty next

  method decl f (name, e) =
    Format.fprintf f "let %a = @[<h>%a@];;@\n"
      self#binding name self#expr e

  method prog (f:Format.formatter) (prog:AstFun.prog) =
    List.iter (self#decl f) prog

end

let camlFunPrinter = new camlFunPrinter

