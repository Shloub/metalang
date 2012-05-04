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
TODO passer une passe de noPending sur a peu pres tout avant.
gérer les input
gérer les arrays
gérer while
Bref, c'est juste un proto...
*)

open Stdlib
open Ast
open Printer

class bashPrinter = object(self)
inherit printer as super

  method lang () = "bash"


  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for@ %a in `seq \"%a\" \"%a\"`; do@\n@]@[<v 2>  %a@]@\ndone;"
      self#binding_decl varname
      self#expr expr1
      self#expr expr2
      self#instructions li


  method if_ f e ifcase elsecase =
    match elsecase with
      | [] ->
	Format.fprintf f "@[<h>if@ %a ; then@]@\n@[<v 2>  %a@]@\nfi;"
	  self#expr e
	  self#bloc ifcase
      | _ ->
	Format.fprintf f "@[<h>if@ %a ; then@]@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a@]@\nfi;"
	  self#expr e
	  self#bloc ifcase
	  self#bloc elsecase


  method print_proto f (funname, t, li) =
    Format.fprintf f "%a(){@\n@[<v 2>  %a"
      self#funname funname
      (print_list_indexed
	 (fun f (n, t) i ->
	   Format.fprintf f "local %a=$%d;"
	     self#binding_decl n (i+1))
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)) li

  method return f e =
    Format.fprintf f "@[<h>_RET=%a;@]@\nreturn;" self#expr e

  method print_fun f funname t li instrs =
    Format.fprintf f "%a@\n%a@]@\n}"
      self#print_proto (funname, t, li)
      self#instructions instrs


  method binding_decl f i = Format.fprintf f "%s" i
  method binding f i = Format.fprintf f "$%s" i

  val mutable in_main = false
  method main f main =
    begin
      in_main <- true;
      super#main f main
    end

  method declaration f var t e =
    if in_main then
      Format.fprintf f "@[<h>%a=%a;@]"
	self#binding_decl var
	self#expr e
    else
      Format.fprintf f "@[<h>local %a=%a;@]"
	self#binding_decl var
	self#expr e

  method expr f e =
    match Expr.unfix e with
      | Expr.Binding _
      | Expr.Call _
      | Expr.Integer _ -> super#expr f e
      | _ ->
	Format.fprintf f
	  "$(expr %a)"
	  super#expr e

  method affect f mutable_ expr =
    Format.fprintf f "@[<h>%a=%a;@]"
      self#mutable_ mutable_ self#expr expr

  method mutable_ f m =
    match m with
      | Instr.Var binding -> self#binding_decl f binding
      | Instr.Array (binding, indexes) ->
	Format.fprintf f "%a[%a]"
	  self#mutable_ binding
	  (print_list
	     self#expr
	     (fun f f1 e1 f2 e2 ->
	       Format.fprintf f "%a][%a" f1 e1 f2 e2
	     ))
	  indexes



  method print f t expr =
    Format.fprintf f "@[echo@ %a;@]" self#expr expr

  method call (f:Format.formatter) (var:funname) (li:Expr.t list) : unit =
    match BindingMap.find_opt var macros with
      | Some ( (t, params, code) ) ->
	self#expand_macro_call f var t params code li
      | None ->
    Format.fprintf
      f
      "@[<h>%a %a;@]"
	  self#funname var
	  (print_list
	     self#expr
	     (fun t f1 e1 f2 e2 ->
	       Format.fprintf t "%a @ %a" f1 e1 f2 e2
	     )
	  ) li


  method apply (f:Format.formatter) (var:funname) (li:Expr.t list) : unit =
    match BindingMap.find_opt var macros with
      | Some ( (t, params, code) ) ->
	self#expand_macro_apply f var t params code li
      | None ->
    Format.fprintf
      f
      "$(%a %a; echo \"$_RET\")"
	  self#funname var
	  (print_list
	     self#expr
	     (fun t f1 e1 f2 e2 ->
	       Format.fprintf t "%a @ %a" f1 e1 f2 e2
	     )
	  ) li


end

let printer = new bashPrinter;;
