open Stdlib
open Ast
open Printer
open CPrinter

class cppPrinter = object(self)
inherit cPrinter as super

  method ptype f t =
      match Type.unfix t with
      | Type.Integer -> Format.fprintf f "int"
      | Type.String -> Format.fprintf f "std::string"
      | Type.Float -> Format.fprintf f "float"
      | Type.Array a -> Format.fprintf f "std::vector<%a >" self#ptype a
      | Type.Void ->  Format.fprintf f "void"
      | Type.Bool -> Format.fprintf f "bool"
      | Type.Char -> Format.fprintf f "char"

  method bool f = function
    | true -> Format.fprintf f "true"
    | false -> Format.fprintf f "false"

  method prog f (progname, funs, main) =
    Format.fprintf f
      "#include <cstdlib>@\n#include <cstdio>@\n#include <iostream>@\n#include <vector>@\n%a@\n%a\n"
      self#proglist funs
      self#main main

  method length f tab =
    Format.fprintf f "%a.size()" self#binding tab

  method allocarray f binding type_ len =
       Format.fprintf f "@[<h>std::vector<%a > %a( %a );@]"
	self#ptype type_
	self#binding binding
	self#expr len


  method access_array f arr index =
    Format.fprintf f "@[<h>%a.at(%a)@]"
      self#binding arr
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
