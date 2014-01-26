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


(** java Printer
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Printer
open CppPrinter

class javaPrinter = object(self) (* TODO scanf et printf*)
  inherit cppPrinter as cppprinter

  method lang () = "java"

  method prototype f t = self#ptype f t

  method stdin_sep f =
Format.fprintf f "@[<v>scanner.findWithinHorizon(\"[\\n\\r ]*\", 1);@]"

  method ptype f t =
      match Type.unfix t with
      | Type.Integer -> Format.fprintf f "int"
      | Type.String -> Format.fprintf f "String"
      | Type.Float -> Format.fprintf f "float"
      | Type.Array a -> Format.fprintf f "%a[]" self#ptype a
      | Type.Void ->  Format.fprintf f "void"
      | Type.Bool -> Format.fprintf f "boolean"
      | Type.Char -> Format.fprintf f "char"
      | Type.Named n -> Format.fprintf f "%s" n
      | Type.Enum _ -> Format.fprintf f "an enum"
      | Type.Struct (li, p) -> Format.fprintf f "a struct"
      | Type.Auto -> assert false

  method decl_type f name t =
    match (Type.unfix t) with
	Type.Struct (li, _) ->
	Format.fprintf f "static class %a {%a}"
	  self#binding name
	  (print_list
	     (fun t (name, type_) ->
	       Format.fprintf t "public %a %a;" self#ptype type_ self#binding name
	     )
	     (fun t fa a fb b -> Format.fprintf t "%a%a" fa a fb b)
	  ) li
      | Type.Enum li ->
        Format.fprintf f "enum %a { @\n@[<v2>  %a@]}@\n"
          self#binding name
          (print_list
	           (fun t name ->
               self#binding t name
	           )
	           (fun t fa a fb b -> Format.fprintf t "%a,@\n %a" fa a fb b)
	        ) li
      | _ -> cppprinter#decl_type f name t

  method enum f e =
    let t = Typer.typename_for_enum e (cppprinter#getTyperEnv ()) in
    Format.fprintf f "%s.%s" t e

  method prog f prog =
    Format.fprintf f
      "import java.util.*;@\n@\npublic class %s@\n@[<v 2>{@\n%a@\n%a@\n%a@]@\n}@\n"
      prog.Prog.progname
      self#print_scanner ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main


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
	Format.fprintf f "@[<h>%a[] %a = new %a[%a]%a;@]"
	  self#ptype type_
	  self#binding binding

	  self#prefix_type t2
	  self#expr len
	  self#suffix_type type_
      | _ ->
	Format.fprintf f "@[<h>%a[] %a = new %a[%a];@]"
	  self#ptype type_
	  self#binding binding
	  self#ptype type_
	  self#expr len

  method main f main =
    Format.fprintf f "public static void main(String args[])@\n@[<v 2>{@\n%a@]@\n}@\n"
      self#instructions main

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>%a@]@\n@[<v 2>{@\n%a@]@\n}@\n"
      self#print_proto (funname, t, li)
      self#instructions instrs

  method print_proto f triplet =
    Format.fprintf f "public static %a"
      cppprinter#print_proto triplet

  method print_scanner f () =
    Format.fprintf f "@[<h>static Scanner scanner = new Scanner(System.in);@]"

  method read f t m =
    match Type.unfix t with
      | Type.Integer ->
	Format.fprintf f "@[<h>if (scanner.hasNext(\"^-\")){@]@\n@[<h>scanner.next(\"^-\"); %a = -scanner.nextInt();@]@\n@[<h>}else{@]@\n@[<h>%a = scanner.nextInt();}@]"
	  self#mutable_ m
	  self#mutable_ m
      | Type.String -> (* TODO configure Scanner, read int and do it*)
	Format.fprintf f "TODO" (* TODO *)
      | Type.Char -> Format.fprintf f "@[<h>scanner.useDelimiter(\"\\\\n\");%a = scanner.findWithinHorizon(\".\", 1).charAt(0);@]"
	self#mutable_ m
      | _ -> failwith("unsuported read")

  method multi_print f format exprs =
    Format.fprintf f "@[<h>System.out.printf(\"%s\", %a);@]" format
      (print_list
	 (fun f (t, e) -> self#expr f e)
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a,@ %a" f1 e1 f2 e2)) exprs

  method print f t expr = match Expr.unfix expr with
  | Expr.String s -> Format.fprintf f "@[System.out.print(%S);@]" s
  | _ ->
    Format.fprintf f "@[System.out.printf(\"%a\", %a);@]" self#format_type t self#expr expr

  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
	Format.fprintf f "@[<h>%a.%a = %a;@]"
	  self#binding name
	  self#field fieldname
	  self#expr expr
      )
      (fun t f1 e1 f2 e2 ->
	Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)
      f
      li


  method allocrecord f name t el =
    Format.fprintf f "%a %a = new %a();@\n%a"
      self#ptype t
      self#binding name
      self#ptype t
      (self#def_fields name) el


  method mutable_ f m =
    match Mutable.unfix m with
      | Mutable.Dot (m, field) ->
	Format.fprintf f "%a.%s"
	  self#mutable_ m
	  field
      | Mutable.Var b ->
	self#binding f b
      | Mutable.Array (m, index) ->
	  Format.fprintf f "@[<h>%a[%a]@]"
	    self#mutable_ m
	    (print_list
	       self#expr
	       (fun f f1 e1 f2 e2 ->
		 Format.fprintf f "%a][%a"
		   f1 e1
		   f2 e2
	       )) index

end
