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
* @see http://prologin.org
* @author Prologin <info@prologin.org>
* @author Maxime Audouin <coucou747@gmail.com>
*
*)

(*
TODO
les inputs et outputs
les boucles for
les returns
les tableaux
*)
open Stdlib
open Ast
open Printer

class schemePrinter = object(self)
inherit printer as super

  method lang () = "scheme"

  val mutable nlet = 0


  method binding f i = Format.fprintf f "%s" i

  method print_proto f (funname, t, li) =
    Format.fprintf f "(%a %a)"
      self#funname funname
      (print_list
	 (fun f (n, t) ->
	     self#binding f n)
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a@ %a" f1 e1 f2 e2)) li

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>(define@ %a@\n%a)@]@\n"
      self#print_proto (funname, t, li)
      self#bloc instrs


  method if_ f e ifcase elsecase =
    match elsecase with
      | [] ->
	Format.fprintf f "@[<v 2>(if@\n%a@\n%a)@]"
	  self#expr e
	  self#bloc ifcase
      | _ ->
	Format.fprintf f "@[<v 2>(if@\n%a@\n%a@\n%a)@]"
	  self#expr e
	  self#bloc ifcase
	  self#bloc elsecase


  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<v 2>(do@\n@[<h>((%a %a (+ 1 %a)))@]@\n@[<h>((> %a@ %a))@]@\n%a@]@\n)"
      self#binding varname
      self#expr expr1
      self#binding varname
      self#binding varname
      self#expr expr2
      self#bloc li


  method expr f t =
    let binop op a b = Format.fprintf f "(%a@ %a@ %a)" self#print_op op self#expr a self#expr b
    in
    let t = Expr.unfix t in
    match t with
    | Expr.Bool b -> self#bool f b
    | Expr.UnOp (a, op) -> self#unop f op a
    | Expr.BinOp (a, op, b) -> binop op a b
    | Expr.Integer i -> Format.fprintf f "%i" i
    | Expr.Float i -> self#float f i
    | Expr.String i -> self#string f i
    | Expr.Binding b -> self#expr_binding f b
    | Expr.AccessArray (arr, index) ->
	self#access_array f arr index
    | Expr.Call (funname, li) -> self#apply f funname li
    | Expr.Length (tab) ->
      self#length f tab
    | Expr.Char (c) -> self#char f c


  method apply (f:Format.formatter) (var:funname) (li:Expr.t list) : unit =
    match BindingMap.find_opt var macros with
      | Some ( (t, params, code) ) ->
	self#expand_macro_apply f var t params code li
      | None ->
    Format.fprintf
      f
      "(%a %a)"
	  self#funname var
	  (print_list
	     self#expr
	     (fun t f1 e1 f2 e2 ->
	       Format.fprintf t "%a@ %a" f1 e1 f2 e2
	     )
	  ) li

  method call (f:Format.formatter) (var:funname) (li:Expr.t list) : unit =
    self#apply f var li

  method print f t expr =
    Format.fprintf f "@[(display@ %a)@]" self#expr expr

  method declaration f var t e =
    let () = nlet <- nlet + 1 in
    Format.fprintf f "@[<v2>(let @[<h>((%a@ %a))@]"
      self#binding var
      self#expr e

  method affect f mutable_ expr =
    Format.fprintf f "@[<h>(set!@ %a@ %a)@]"
      self#mutable_ mutable_ self#expr expr

  method return f e =
    Format.fprintf f "@[<h>%a@]" self#expr e

  method bloc f li =
    let exnlet = nlet in
    begin
      nlet <- 0;
      Format.fprintf f "@[<v 2>(begin@\n%a@]@\n)"
	(print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)) li;
      for i = 1 to nlet do
	Format.fprintf f ")@]";
      done;
      nlet <- exnlet;
    end


  method main f main =
    self#bloc f main
  

end

let printer = new schemePrinter;;
