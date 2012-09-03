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

(** Javascript Printer
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Printer
open CPrinter

class ['lex] jsPrinter = object(self)
  inherit ['lex] cPrinter as super

  method decl_type f name t = ()


  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for@ (var %a@ =@ %a@ ;@ %a@ <=@ %a;@ %a++)@\n@]%a"
      self#binding varname
      self#expr expr1
      self#binding varname
      self#expr expr2
      self#binding varname
      self#bloc li


  method declaration f var t e =
    Format.fprintf f "@[<h>var %a@ =@ %a;@]"
      self#binding var
      self#expr e

  method print_proto f (funname, t, li) =
    Format.fprintf f "function %a(%a)"
      self#funname funname
      (print_list
         (fun t (binding, type_) ->
           Format.fprintf t "%a"
             self#binding binding
         )
         (fun t f1 e1 f2 e2 -> Format.fprintf t
           "%a,@ %a" f1 e1 f2 e2)
      ) li


  method prog f prog =
    Format.fprintf f "%a%a@\n@\n"
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main


  method main f main =
    self#instructions f main


  method print f t expr =
    Format.fprintf f "@[print(%a);@]" self#expr expr



  method allocrecord f name t el =
    Format.fprintf f "@[<h>%a@ =@ {@[<v2>@\n%a@]@\n};@]"
      self#binding name
      (self#def_fields name) el

  method allocarray f binding type_ len =
      Format.fprintf f "@[<h>%a@ =@ new Array(%a);@]"
        self#binding binding
        self#expr len

  method mutable_ f m =
    match Mutable.unfix m with
      | Mutable.Dot (m, field) ->
	Format.fprintf f "%a.%a"
	  self#mutable_ m
	  self#field field
      | Mutable.Var binding -> self#binding f binding
      | Mutable.Array (m, indexes) ->
	Format.fprintf f "%a[%a]"
	  self#mutable_ m
	  (print_list
	     self#expr
	     (fun f f1 e1 f2 e2 ->
	       Format.fprintf f "%a][%a" f1 e1 f2 e2
	     ))
	  indexes


  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
	Format.fprintf f "%a : %a"
	  self#field fieldname
	  self#expr expr
      )
      (fun t f1 e1 f2 e2 ->
	Format.fprintf t
	  "%a,@\n%a" f1 e1 f2 e2)
      f
      li


end
