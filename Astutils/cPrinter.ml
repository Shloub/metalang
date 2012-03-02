open Ast
open Stdlib
open Printer

class cPrinter = object(self)
  inherit printer as super
  
  method binding f i = Format.fprintf f "%s" i
  
  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ %a@ =@ %a;@]"
      self#ptype t
      self#binding var
      self#expr e

  method allocarray f binding type_ len =
      Format.fprintf f "@[<h>%a@ *%a@ =@ malloc(@ (%a)@ *@ sizeof(%a) + sizeof(int));@]@\n((int*)%a)[0]=%a;@\n((int*)%a)++;"
	self#ptype type_
	self#binding binding
	self#expr len
	self#ptype type_
	self#binding binding
	self#expr len
	self#binding binding
  
  method forloop f varname expr1 expr2 expr3 li =
    Format.fprintf f "int %a;@\n%a"
      self#binding varname
      self#forloop_content (varname, expr1, expr2, expr3, li)
  method forloop_content f (varname, expr1, expr2, expr3, li) =
    Format.fprintf f "@[<h>for@ (%a@ =@ %a@ ;@ %a@ <@ %a;@ %a@ +=@ %a)@\n@]%a"
      self#binding varname
      self#expr expr1
      self#binding varname
      self#expr expr2
      self#binding varname
      self#expr expr3
      self#bloc li

  method main f main =
    Format.fprintf f "@[<v 2>int main(void){@\n%a@\nreturn 0;@]@\n}"
      self#instructions main
      
  method bloc f li = Format.fprintf f "@[<v 2>{@\n%a@]@\n}"
     self#instructions li

  method print_proto f (funname, t, li) =
    Format.fprintf f "%a %a(%a)"
      self#ptype t
      self#funname funname
      (print_list
	 (fun t (binding, type_) ->
	   Format.fprintf t "%a@ %a"
	     self#ptype type_
	     self#binding binding
	 )
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	     "%a,@ %a" f1 e1 f2 e2)
      ) li

  method read f t binding =
    Format.fprintf f "@[scanf(\"%a\", &%a);@]"
      self#format_type t
      self#binding binding

  method print f t expr =
    Format.fprintf f "@[printf(\"%a \", %a);@]" self#format_type t self#expr expr

  method prog f (funs, main) =
    Format.fprintf f "#include<stdio.h>@\n#include<stdlib.h>@\n@\n@[<h>int@ count(void*@ a){@ return@ ((int*)a)[-1];@ }@]@\n@\n%a%a@\n@\n"
      self#proglist funs
      self#main main

end

let printer = new cPrinter;;
