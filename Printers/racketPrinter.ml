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

class racketPrinter = object(self)
  inherit OcamlFunPrinter.camlFunPrinter as super
  method lang () = "rkt"

  method binopstr = function
  | Ast.Expr.Add -> "+"
  | Ast.Expr.Sub -> "-"
  | Ast.Expr.Mul -> "*"
  | Ast.Expr.Div -> "/"
  | Ast.Expr.Mod -> "remainder"
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

  method lief f = function
  | E.Error -> Format.fprintf f "(assert false)"
  | E.Unit -> Format.fprintf f "'()"
  | E.Char c -> Format.fprintf f "%C" c
  | E.String s -> Format.fprintf f "%S" s
  | E.Integer i -> Format.fprintf f "%i" i
  | E.Bool true -> Format.fprintf f "#t"
  | E.Bool false -> Format.fprintf f "#f"
  | E.Enum s -> Format.fprintf f "'%s" s
  | E.Binding s -> self#binding f s

  method comment f s c = Format.fprintf f ";%s@\n%a"
    (String.replace "\n" "\n;" s) self#expr c

  method binop f a op b = Format.fprintf f "(%a %a %a)" self#pbinop op self#expr a self#expr b

  method fun_ f params e =
    Format.fprintf f "@[<v 2>(lambda (%a) @\n%a@])@]"
      (Printer.print_list self#binding
      (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b))
      params
      self#expr e

  method header f () = Format.fprintf f "#lang racket
(require racket/block)

(define array_init_withenv (lambda (len f env)
  (build-vector len (lambda (i)
    (let ([o (f i env)])
      (block
        (set! env (car o))
        (cdr o)
      )
    )))))
"

  method toplvl_declare f name e = Format.fprintf f "@[<v 2>(define %a %a@])@\n" self#binding name self#expr e

  method print f e ty =
    Format.fprintf f "(display %a)"
      self#expr e

  method if_ f e1 e2 e3 = Format.fprintf f "@[<v 2>(if %a@\n%a@\n%a)@]" self#expr e1 self#expr e2 self#expr e3

  method letin f params b  = Format.fprintf f "@[<v 2>(let (%a)@\n%a@])"
    (Printer.print_list
       (fun f (s, a) ->
	 Format.fprintf f "[%a %a]"
	   self#binding s self#expr a
       )
       (fun f pa a pb b -> Format.fprintf f "%a@\n%a" pa a pb b))
    params
    self#expr b

  method block f li = Format.fprintf f "@[<v 2>(block@\n%a@\n)@]"
    (Printer.print_list
       self#expr
       (fun f pa a pb b -> Format.fprintf f "%a@\n%a" pa a pb b)) li

  method tuple f li =
    match List.rev li with
    | [] -> assert false
    | hd::tl ->
      let tl = List.rev tl in
      Format.fprintf f "'(%a . %a)"
	(Printer.print_list self#expr
	   (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)) tl
	self#expr hd

  method apply_nomacros f e li =
    Format.fprintf f "(%a %a)"
      self#expr e
      (Printer.print_list self#expr (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)) li
      

  method letrecin f name params e1 e2 = (* TODO *)
    let e1 = E.fun_ params e1 in
    Format.fprintf f "@[<v 2>(letrec ([%a %a])@\n%a)@]"
      self#binding name
      self#expr e1
      self#expr e2

  method arraymake f len lambda env = Format.fprintf f "(array_init_withenv %a %a %a)" self#expr len self#expr lambda self#expr env

  method arrayindex f tab indexes =
    match List.rev indexes with
    | [] -> self#expr f tab
    | [expr] ->
      Format.fprintf f "(vector-ref %a %a)"
	self#expr tab
	self#expr expr
    | hd::tl -> Format.fprintf f "(vector-ref %a %a)"
      (fun f tl -> self#arrayindex f tab tl) tl
      self#expr hd

  method arrayaffectin f tab indexes v in_ =
    match List.rev indexes with
    | [] -> assert false
    | hd::tl ->
      let tl = List.rev tl in
      Format.fprintf f "(block (vector-set! %a %a %a) %a)"
	(fun f () -> self#arrayindex f tab tl) ()
	self#expr hd
	self#expr v
	self#expr in_
end

let racketPrinter = new racketPrinter

