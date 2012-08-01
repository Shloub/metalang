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

(** C Printer
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)

open Ast
open Stdlib
open Printer

class ['lex] cPrinter = object(self)
  inherit ['lex] printer as super

  method lang () = "c"


  method binding f i = Format.fprintf f "%s" i

  method bool f = function
    | true -> Format.fprintf f "1"
    | false -> Format.fprintf f "0"

  method ptype f t =
      match Type.unfix t with
      | Type.Integer -> Format.fprintf f "int"
      | Type.String -> Format.fprintf f "char*"
      | Type.Float -> Format.fprintf f "float"
      | Type.Array a -> Format.fprintf f "%a*" self#ptype a
      | Type.Void ->  Format.fprintf f "void"
      | Type.Bool -> Format.fprintf f "int"
      | Type.Char -> Format.fprintf f "char"
      | Type.Named n -> Format.fprintf f "struct %s *" n
      | Type.Struct (li, p) -> Format.fprintf f "a struct"

  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ %a@ =@ %a;@]"
      self#ptype t
      self#binding var
      self#expr e

  method allocrecord f name t el =
    Format.fprintf f "%a %a = malloc (sizeof(%a) );@\n%a"
      self#ptype t
      self#binding name
      self#binding name
      (self#def_fields name) el


  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
	Format.fprintf f "%a->%a=%a;"
	  self#binding name
	  self#field fieldname
	  self#expr expr
      )
      (fun t f1 e1 f2 e2 ->
	Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)
      f
      li


  method allocarray f binding type_ len =
      Format.fprintf f "@[<h>%a@ *%a@ =@ malloc(@ (%a)@ *@ sizeof(%a) + sizeof(int));@]@\n((int*)%a)[0]=%a;@\n%a=(%a*)( ((int*)%a)+1);"
	self#ptype type_
	self#binding binding
	self#expr len
	self#ptype type_
	self#binding binding
	self#expr len
	self#binding binding
	self#ptype type_
	self#binding binding

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "{@\n@[<v 2>  int %a;@\n%a@]@\n}"
      self#binding varname
      self#forloop_content (varname, expr1, expr2, li)
  method forloop_content f (varname, expr1, expr2, li) =
    Format.fprintf f "@[<h>for@ (%a@ =@ %a@ ;@ %a@ <=@ %a;@ %a++)@\n@]%a"
      self#binding varname
      self#expr expr1
      self#binding varname
      self#expr expr2
      self#binding varname
      self#bloc li

  method main f main =
    Format.fprintf f "@[<v 2>int main(void){@\n%a@\nreturn 0;@]@\n}"
      self#instructions main

(* on ne peut pas faire ça a cause des boucles for qu'on étend*)
  method bloc f li = (*match li with
    | [i] ->
      Format.fprintf f "  %a"
	self#instr i
    | _ -> *) Format.fprintf f "@[<v 2>{@\n%a@]@\n}"
     self#instructions li

  method prototype f t = self#ptype f t

  method print_proto f (funname, t, li) =
    Format.fprintf f "%a %a(%a)"
      self#ptype t
      self#funname funname
      (print_list
	 (fun t (binding, type_) ->
	   Format.fprintf t "%a@ %a"
	     self#prototype type_
	     self#binding binding
	 )
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	     "%a,@ %a" f1 e1 f2 e2)
      ) li

  method stdin_sep f =
    Format.fprintf f "@[scanf(\"%%*[ \\t\\r\\n]c\", 0);@]"


  method mutable_ f m =
    match Mutable.unfix m with
      | Mutable.Dot (m, field) ->
	Format.fprintf f "%a->%a"
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

  method read f t m =
    Format.fprintf f "@[scanf(\"%a\", &%a);@]"
      self#format_type t
      self#mutable_ m

  method print f t expr =
    Format.fprintf f "@[printf(\"%a\", %a);@]" self#format_type t self#expr expr

  method prog f prog =
    Format.fprintf f "#include<stdio.h>@\n#include<stdlib.h>@\n@\n@[<h>int@ count(void*@ a){@ return@ ((int*)a)[-1];@ }@]@\n@\n%a%a@\n@\n"
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main


  method decl_type f name t =
    match (Type.unfix t) with
	Type.Struct (li, _) ->
	Format.fprintf f "struct %a;@\ntypedef struct %a {@\n@[<v 2>  %a@]@\n} %a;@\n"
	  self#binding name
	  self#binding name
	  (print_list
	     (fun t (name, type_) ->
	       Format.fprintf t "%a %a;" self#ptype type_ self#binding name
	     )
	     (fun t fa a fb b -> Format.fprintf t "%a@\n%a" fa a fb b)
	  ) li
	  self#binding name
      | _ ->
	Format.fprintf f "typedef %a %a;"
	super#ptype t
	  super#binding name


  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>%a@]{@\n@[<v 2>  %a@]@\n}@\n"
      self#print_proto (funname, t, li)
      self#instructions instrs

  method return f e =
    Format.fprintf f "@[<h>return@ %a;@]" self#expr e

  method whileloop f expr li =
    Format.fprintf f "@[<h>while (%a)@]@\n%a"
      self#expr expr
      self#bloc li

  method if_ f e ifcase elsecase =
    match elsecase with
      | [] ->
	      Format.fprintf f "@[<h>if@ (%a)@]@\n%a"
 	      self#expr e
	        self#bloc ifcase
      | [Instr.Fixed.F ( _, Instr.If (condition, instrs1, instrs2) ) as instr] ->
        Format.fprintf f "@[<h>if@ (%a)@]@\n%a@\nelse %a"
 	      self#expr e
        	self#bloc ifcase
 	      self#instr instr
      | _ ->
        Format.fprintf f "@[<h>if@ (%a)@]@\n%a@\nelse@\n%a"
 	      self#expr e
        	self#bloc ifcase
        	self#bloc elsecase
end
