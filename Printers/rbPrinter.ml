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


(** ruby Printer
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)


open Stdlib
open Ast
open Printer
open PyPrinter

let header = "
require \"scanf.rb\"

"

class rbPrinter = object(self)
inherit pyPrinter as super

  method lang () = "ruby"

  method header f () =
    Format.fprintf f "%s" header

   method print_proto f (funname, t, li) =
    Format.fprintf f "def %a( %a )"
      self#funname funname
      (print_list
	 (fun t (a, type_) ->
	     self#binding t a)
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a,@ %a" f1 e1 f2 e2)) li

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>%a@]@\n@[<v 2>  %a@]@\nend@\n"
      self#print_proto (funname, t, li)
      self#bloc instrs


  method whileloop f expr li =
    Format.fprintf f "@[<h>while %a do@]@\n%a@\nend"
      self#expr expr
      self#bloc li


  method read f t mutable_ =
match Type.unfix t with
  | Type.Integer ->
    Format.fprintf f "@[%a=scanf(\"%%d\")[0];@]"
      self#mutable_ mutable_
  | Type.Char ->
    Format.fprintf f "@[%a=scanf(\"%%c\")[0];@]"
      self#mutable_ mutable_

  method stdin_sep f =
    Format.fprintf f "@[scanf(\"%%*\\n\");@]"

  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ =@ %a@]"
      self#binding var
      self#expr e


  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
	| Expr.Add -> "+"
	| Expr.Sub -> "-"
	| Expr.Mul -> "*"
	| Expr.Div -> "/"
	| Expr.Mod -> "%"
	| Expr.Or -> "or"
	| Expr.And -> "and"
	| Expr.Lower -> "<"
	| Expr.LowerEq -> "<="
	| Expr.Higher -> ">"
	| Expr.HigherEq -> ">="
	| Expr.Eq -> "=="
	| Expr.Diff -> "!="
	| Expr.BinOr -> "lor"
	| Expr.BinAnd -> "land"
	| Expr.RShift -> "lsl"
	| Expr.LShift -> "lsr"
      )

  method bool f = function
    | true -> Format.fprintf f "true"
    | false -> Format.fprintf f "false"

  method forloop_content f (varname, expr1, expr2, li) =
    Format.fprintf f "@[<h>for@ %a@ in@ (%a .. @ %a) do@\n@]%a@\nend"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#bloc li

  method print f t expr =
    Format.fprintf f "@[printf \"%a\", %a@]"
      self#format_type t
      self#expr expr

  method bloc f li =
	  Format.fprintf f "@[<v 2>  %a@]" self#instructions li

  method if_ f e ifcase elsecase =
    match elsecase with
      | [] ->
	Format.fprintf f "@[<h>if@ %a then@]@\n%a@\nend"
	  self#expr e
	  self#bloc ifcase
      | [Instr.F ( Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>if@ %a then@]@\n%a@\nels%a"
	self#expr e
	self#bloc ifcase
	self#instr instr
      | _ ->
	Format.fprintf f "@[<h>if@ %a then@]@\n%a@\nelse@\n%a@\nend"
	  self#expr e
	  self#bloc ifcase
	  self#bloc elsecase

  method allocarray f binding type_ len =
      Format.fprintf f "@[<h>%a@ =@ [];@]"
	      self#binding binding

  method length f tab =
    Format.fprintf f "%a.length" self#binding tab

  method return f e =
    Format.fprintf f "@[<h>return@ (%a);@]" self#expr e

  method field f field =
    Format.fprintf f "%S" field

  method allocrecord f name t el =
    Format.fprintf f "%a = {@[<v>%a@]};"
      self#binding name
      (self#def_fields name) el

  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
	Format.fprintf f "%a => %a"
	  self#field fieldname
	  self#expr expr
      )
      (fun t f1 e1 f2 e2 ->
	Format.fprintf t
	  "%a,@\n%a" f1 e1 f2 e2)
      f
      li


end

let printer = new rbPrinter;;
