open Stdlib
open Ast
open Printer
open CppPrinter

class javaPrinter = object(self) (* TODO scanf et printf*)
  inherit cppPrinter as super
  method prog f (progname, funs, main) =
    Format.fprintf f
      "import java.util.*;@\n@\npublic class %s@\n@[<v 2>{@\n%a@\n%a@]@\n}@\n"
      (*(String.capitalize *) progname (*)*)
      self#proglist funs
      self#main main

  method allocarray f binding type_ len =
       Format.fprintf f "@[<h>%a %a[] = new %a[%a];@]"
	 self#ptype type_
	 self#binding binding
	 self#ptype type_
	 self#expr len

  method main f main =
    Format.fprintf f "public static void main(String args[])@\n@[<v 2>{@\n%a@\n%a@]@\n}@\n"
      self#print_scanner main
      self#instructions main

  method length f tab =
    Format.fprintf f "%a.length" self#binding tab

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>%a@]@\n@[<v 2>{@\n%a@\n%a@]@\n}@\n"
      self#print_proto (funname, t, li)
      self#print_scanner instrs
      self#instructions instrs

  method print_proto f triplet =
    Format.fprintf f "public static %a"
      super#print_proto triplet

  method print_scanner f _ = (* TODO if read node... *)
    Format.fprintf f "@[<h>Scanner scanner = new Scanner(System.in);@]"

  method read f t binding =
    match Type.unfix t with
      | Type.Integer ->
	Format.fprintf f "@[<h>%a = scanner.nextInt();@]"
	  self#binding binding

  method print f t expr =
    Format.fprintf f "@[System.out.printf(\"%a \", %a);@]" self#format_type t self#expr expr


  method access_array f arr index =
    Format.fprintf f "@[<h>%a[%a]@]"
      self#binding arr
      self#expr index


end

let printer = new javaPrinter;;
