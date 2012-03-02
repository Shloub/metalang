open Stdlib
open Ast
open Printer
open CPrinter

class cppPrinter = object(self)
inherit cPrinter as super
  method prog f (progname, funs, main) =
    Format.fprintf f
      "#include<cstdlib>@\n#include<iostream>@\n#include<vector>@\n%a@\n%a\n"
      self#proglist funs
      self#main main

  method length f tab =
    Format.fprintf f "%a.size()" self#binding tab

  method allocarray f binding type_ len =
       Format.fprintf f "@[<h>std::vector<%a> *%a; /*length : %a */@]"
	self#ptype type_
	self#binding binding
	self#expr len

  method access_array f arr index =
    Format.fprintf f "@[<h>%a.at(%a)@]"
      self#binding arr
      self#expr index

  method forloop f varname expr1 expr2 expr3 li =
    Format.fprintf f "@[<h>for@ (int %a@ =@ %a@ ;@ %a@ <@ %a;@ %a@ +=@ %a)@\n@]%a"
      self#binding varname
      self#expr expr1
      self#binding varname
      self#expr expr2
      self#binding varname
      self#expr expr3
      self#bloc li
end

let printer = new cppPrinter;;
