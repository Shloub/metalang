open Stdlib
open Ast
open Printer
open CppPrinter

class javaPrinter = object(self) (* TODO scanf et printf*)
  inherit cppPrinter as super


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

  method read f t binding =
    match Type.unfix t with
      | Type.Integer ->
	Format.fprintf f "@[<h>scanner.useDelimiter(\"\\\\s\");@]@\n@[<h>%a = scanner.nextInt();@]"
	  self#binding binding
      | Type.String -> (* TODO configure Scanner, read int and do it*)
	Format.fprintf f "TODO" (* TODO *)
      | Type.Char -> Format.fprintf f "@[<h>scanner.useDelimiter(\".\");@]@\n@[<h>%a = scanner.findInLine(\".\").charAt(0);@]"
	self#binding binding

  method print f t expr =
    Format.fprintf f "@[System.out.printf(\"%a \", %a);@]" self#format_type t self#expr expr


  method access_array f arr index =
    Format.fprintf f "@[<h>%a[%a]@]"
      self#binding arr
      self#expr index


end

let printer = new javaPrinter;;
