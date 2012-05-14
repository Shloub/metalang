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

open Stdlib
open Ast
open Printer
open CPrinter

class cppPrinter = object(self)
inherit cPrinter as super

  method lang () = "cpp"

  method ptype f t =
      match Type.unfix t with
      | Type.Integer -> Format.fprintf f "int"
      | Type.String -> Format.fprintf f "std::string"
      | Type.Float -> Format.fprintf f "float"
      | Type.Array a -> Format.fprintf f "std::vector<%a >" self#ptype a
      | Type.Void ->  Format.fprintf f "void"
      | Type.Bool -> Format.fprintf f "bool"
      | Type.Char -> Format.fprintf f "char"
      | Type.Named n -> Format.fprintf f "%s *" n
      | Type.Struct (li, p) -> Format.fprintf f "a struct"

  method bool f = function
    | true -> Format.fprintf f "true"
    | false -> Format.fprintf f "false"

  method prog f prog =
    Format.fprintf f
      "#include <cstdlib>@\n#include <cstdio>@\n#include <iostream>@\n#include <vector>@\n%a@\n%a\n"
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method length f tab =
    Format.fprintf f "%a.size()" self#binding tab

  method allocarray f binding type_ len =
       Format.fprintf f "@[<h>std::vector<%a > %a( %a );@]"
	self#ptype type_
	self#binding binding
	self#expr len

  method allocrecord f name t el =
    match Type.unfix t with
      | Type.Named typename ->
	Format.fprintf f "%a %a = new %s();@\n%a"
	  self#ptype t
	  self#binding name
	  typename
	  (self#def_fields name) el
      | _ -> assert false

  method mutable_ f m =
    match Mutable.unfix m with
      | Mutable.Dot (m, field) ->
	Format.fprintf f "%a->%s"
	  self#mutable_ m
	  field
      | Mutable.Var b ->
	self#binding f b
      | Mutable.Array (m, index) ->
	  Format.fprintf f "@[<h>%a.at(%a)@]"
	    self#mutable_ m
	    (print_list
	       self#expr
	       (fun f f1 e1 f2 e2 ->
		 Format.fprintf f "%a).at(%a"
		   f1 e1
		   f2 e2
	       )) index

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for@ (int %a@ =@ %a@ ;@ %a@ <=@ %a;@ %a@ ++)@\n@]%a"
      self#binding varname
      self#expr expr1
      self#binding varname
      self#expr expr2
      self#binding varname
      self#bloc li

  method prototype f t =
    match Type.unfix t with
      | Type.Array _ ->
	Format.fprintf f "%a&" self#ptype t
      | _ -> self#ptype f t
end

let printer = new cppPrinter;;
