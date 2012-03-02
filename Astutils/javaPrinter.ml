open Stdlib
open Ast
open Printer
open CppPrinter

class javaPrinter = object(self) (* TODO scanf et printf*)
  inherit cppPrinter as super
  method prog f (progname, funs, main) =
    Format.fprintf f
      "public class %s@\n@[<v 2>{@\n%a@\n%a@]@\n}@\n"
      progname
      self#proglist funs
      self#main main

  method allocarray f binding type_ len =
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

  method print_proto f triplet =
    Format.fprintf f "public static %a"
      super#print_proto triplet
end

let printer = new javaPrinter;;
