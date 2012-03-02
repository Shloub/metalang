open Stdlib
open Ast
open Printer
open CPrinter

class phpPrinter = object(self)
  inherit cPrinter as super

  method read f t binding =
    Format.fprintf f "@[list(%a) = fscanf(STDIN, \"%a\");@]"
      self#binding binding
      self#format_type t

  method main f main =
      self#instructions f main
      
  method prog f (funs, main) =
    Format.fprintf f "<?php@\n%a%a@\n?>@\n"
      self#proglist funs
      self#main main

   method print_proto f (funname, t, li) =
    Format.fprintf f "function %a(%a)"
      self#funname funname
      (print_list
	 (fun t (a, b) -> self#binding t a)
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a,@ %a" f1 e1 f2 e2)) li


  method binding f i = Format.fprintf f "$%s" i

  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ =@ %a;@]"
      self#binding var
      self#expr e

  method allocarray f binding type_ len =
    Format.fprintf f "@[<h>%a@ =@ array();@]"
      self#binding binding
end

let printer = new phpPrinter;;
