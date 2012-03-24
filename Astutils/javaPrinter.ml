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
*     * Neither the name of the University of California, Berkeley nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
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
open CppPrinter

class javaPrinter = object(self) (* TODO scanf et printf*)
  inherit cppPrinter as super

  method lang () = "java"

  method prototype f t = self#ptype f t

  method stdin_sep f =
Format.fprintf f "@[<v>scanner.skip(\"\\\\r*\\\\n*\\\\s*\");@]"

  method ptype f t =
      match Type.unfix t with
      | Type.Integer -> Format.fprintf f "int"
      | Type.String -> Format.fprintf f "String"
      | Type.Float -> Format.fprintf f "float"
      | Type.Array a -> Format.fprintf f "%a[]" self#ptype a
      | Type.Void ->  Format.fprintf f "void"
      | Type.Bool -> Format.fprintf f "boolean"
      | Type.Char -> Format.fprintf f "char"

  method prog f (progname, funs, main) =
    Format.fprintf f
      "import java.util.*;@\n@\npublic class %s@\n@[<v 2>{@\n%a@\n%a@\n%a@]@\n}@\n"
      (*(String.capitalize *) progname (*)*)
      self#print_scanner main
      self#proglist funs
      self#main main


  method prefix_type f t =
    match Type.unfix t with
      | Type.Array t2 -> self#prefix_type f t2
      | t2 -> self#ptype f t

  method suffix_type f t =
    match Type.unfix t with
      | Type.Array t2 ->
	Format.fprintf f "[]%a" self#suffix_type t2
      | _ -> Format.fprintf f ""

  method allocarray f binding type_ len =
    match Type.unfix type_ with
      | Type.Array t2 ->
	Format.fprintf f "@[<h>%a %a[]%a = new %a[%a]%a;@]"
	  self#prefix_type type_
	  self#binding binding
	  self#suffix_type type_

	  self#prefix_type t2
	  self#expr len
	  self#suffix_type type_
      | _ ->
	Format.fprintf f "@[<h>%a %a[] = new %a[%a];@]"
	  self#ptype type_
	  self#binding binding
	  self#ptype type_
	  self#expr len

  method main f main =
    Format.fprintf f "public static void main(String args[])@\n@[<v 2>{@\n%a@]@\n}@\n"
      self#instructions main

  method length f tab =
    Format.fprintf f "%a.length" self#binding tab

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>%a@]@\n@[<v 2>{@\n%a@]@\n}@\n"
      self#print_proto (funname, t, li)
      self#instructions instrs

  method print_proto f triplet =
    Format.fprintf f "public static %a"
      super#print_proto triplet

  method print_scanner f _ = (* TODO if read node... *)
    Format.fprintf f "@[<h>static Scanner scanner = new Scanner(System.in);@]"

  method read f t m =
    match Type.unfix t with
      | Type.Integer ->
	Format.fprintf f "@[<h>scanner.useDelimiter(\"\\\\s\");@]@\n@[<h>%a = scanner.nextInt();@]"
	  self#mutable_ m
      | Type.String -> (* TODO configure Scanner, read int and do it*)
	Format.fprintf f "TODO" (* TODO *)
      | Type.Char -> Format.fprintf f "@[<h>scanner.useDelimiter(\".\");@]@\n@[<h>%a = scanner.findInLine(\".\").charAt(0);@]"
	self#mutable_ m

  method print f t expr =
    Format.fprintf f "@[System.out.printf(\"%a \", %a);@]" self#format_type t self#expr expr

  method access_array f arr index =
    Format.fprintf f "@[<h>%a[%a]@]"
      self#binding arr
      (print_list
	 self#expr
	 (fun f f1 e1 f2 e2 ->
	   Format.fprintf f "%a][%a"
	     f1 e1
	     f2 e2
	 )) index


end

let printer = new javaPrinter;;
