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

(** Main printer
    This printer write metalang code.
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)

open Ast
open Stdlib
open Printer

class ['lex] htmlPrinter = object(self)
  inherit ['lex] printer as super

  method lang () = "html"

  method binding f i = Format.fprintf f "<span class=\"binding\">%s</span>" i
  method funname f i = Format.fprintf f "<span class=\"funname\">%s</span>" i
  method string f i = Format.fprintf f "<span class=\"constant\">%S</span>" i
  method float f i = Format.fprintf f "<span class=\"constant\">%f</span>" i
  method integer f i = Format.fprintf f "<span class=\"constant\">%i</span>" i

  method declaration f var t e =
    Format.fprintf f "<span class=\"keyword\">def</span> %a@ %a@ =@ %a"
      self#ptype t
      self#binding var
      self#expr e

  method bloc f li = Format.fprintf f "<div class=\"metalang_bloc\"><span class=\"keyword\">do</span><div class=\"metalang_bloc_content\">@\n%a</div>@\n<span class=\"keyword\">end</span></div>@\n"
      (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)) li

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "<span class=\"keyword\">for</span>@ %a=%a@ <span class=\"keyword\">to</span>@ %a@\n%a"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#bloc li

  method whileloop f expr li =
    Format.fprintf f "<span class=\"keyword\">while</span> %a@\n%a"
      self#expr expr
      self#bloc li

  method comment f str = (* TODO *)
    Format.fprintf f "/*%s*/" str

  method return f e =
    Format.fprintf f "<span class=\"keyword\">return</span>@ %a" self#expr e

  method ptype f t = Format.fprintf f "<span class=\"type\">%a</span>" super#ptype t

  method allocarray_lambda f binding type_ len binding2 lambda =
      Format.fprintf f "@[<h><span class=\"keyword\">def</span> <span class=\"keyword\">array</span><%a>%a[%a] <span class=\"keyword\">with</span> %a <span class=\"keyword\">do</span>@\n@[<v 2>  <div class=\"metalang_bloc_content\">%a</div>@]@\n<span class=\"keyword\">end</span>@]"
	self#ptype type_
	self#binding binding
	self#expr len
	self#binding binding2
	self#instructions lambda

  method field f field =
    Format.fprintf f "<span class=\"metalang_field\">%s</span>" field

  method stdin_sep f =
    Format.fprintf f "<span class=\"keyword\">skip</span>"

  method allocrecord f name t el =
    Format.fprintf f "<span class=\"keyword\">def</span> %a %a = <span class=\"keyword\">with</span><div class=\"metalang_bloc_content\">%a</div><span class=\"keyword\">end</span>"
      self#ptype t
      self#binding name
      (self#def_fields name) el

  method read f t mutable_ =
    Format.fprintf f "<span class=\"keyword\">read</span> %a %a" self#ptype t self#mutable_ mutable_

  method read_decl f t v =
    Format.fprintf f "<span class=\"keyword\">def</span> <span class=\"keyword\">read</span> %a %a"
      self#ptype t
      self#binding v

  method print f t expr =
    Format.fprintf f "<span class=\"keyword\">print</span> %a %a" self#ptype t self#expr expr

  method if_ f e ifcase elsecase =
    match elsecase with
      | [] ->
	      Format.fprintf f "@[<h><span class=\"keyword\">if</span>@ %a@]@\n<span class=\"keyword\">then</span>@\n@[<v2>  <div class=\"metalang_bloc_content\">%a</div>@]@\n<span class=\"keyword\">end</span>"
	        self#expr e
	        self#instructions ifcase
      | [Instr.Fixed.F (_, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h><span class=\"keyword\">if</span>@ %a@] <span class=\"keyword\">then</span>@\n@[<v 2>  <div class=\"metalang_bloc_content\">%a</div>@]@\n<span class=\"keyword\">els</span>%a"
	      self#expr e
	      self#instructions ifcase
	      self#instr instr
      | _ ->
	Format.fprintf f "@[<h><span class=\"keyword\">if</span>@ %a@]@\n<span class=\"keyword\">then</span>@\n@[<v 2>  <div class=\"metalang_bloc_content\">%a</div>@]@\n<span class=\"keyword\">else</span>@\n@[<v 2>  <div class=\"metalang_bloc_content\">%a</div>@]@\n<span class=\"keyword\">end</span>"
	  self#expr e
	  self#instructions ifcase
	  self#instructions elsecase

  method instr f t = Format.fprintf f "<div class=\"instruction\">%a</div>@\n" super#instr t

  method bool f b = Format.fprintf f "<span class=\"constant\">%a</span>@\n" super#bool b
  method enum f e = Format.fprintf f "<span class=\"constant\">%a</span>@\n" super#enum e
  method char f e = Format.fprintf f "<span class=\"constant\">%a</span>@\n" super#char e

  method print_proto f (funname, t, li) =
    Format.fprintf f "<span class=\"keyword\">def</span>@ %a %a(%a)"
      self#ptype t
      self#funname funname
      (print_list
	 (fun f (n, t) ->
	   Format.fprintf f "%a@ %a"
	     self#ptype t
	     self#binding n)
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a,@ %a" f1 e1 f2 e2)) li

  method print_fun f funname t li instrs =
    Format.fprintf f "<div class==\"metalang_function\"><span class=\"proto\">%a</span>@\n<div class=\"metalang_bloc_content\">%a@]</div><span class=\"keyword\">end</span></div>"
      self#print_proto (funname, t, li)
      self#instructions instrs

  method decl_type f name t =
    Format.fprintf f "<span class=\"keyword\">type</span> %a = %a;" self#binding name self#ptype t

  method main f main = Format.fprintf f "<span class=\"keyword\">main</span><div class=\"metalang_bloc_content\">%a</div>@\n<span class=\"keyword\">end</span>@\n</div>" super#instructions main

end
