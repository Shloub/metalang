open Stdlib
open Ast
open Printer
open CPrinter

let header = "
$stdin='';
while (!feof(STDIN)) $stdin.=fgets(STDIN);
function scan($format){
	 global $stdin;
	 $out = sscanf($stdin, $format);
	 $stdin = substr($stdin, strlen($out[0]));
	 return $out;
}
function scantrim(){
	 global $stdin;
	 $stdin = trim($stdin);
}
";

class phpPrinter = object(self)
  inherit cPrinter as super


  method prototype f t =
    match Type.unfix t with
      | Type.Array _ ->
	Format.fprintf f "&"
      | _ -> ()

  method stdin_sep f =
    Format.fprintf f "@[scantrim();@]"


  method bool f = function
    | true -> Format.fprintf f "true"
    | false -> Format.fprintf f "false"

  method read f t binding =
    Format.fprintf f "@[list(%a) = scan(\"%a\");@]"
      self#binding binding
      self#format_type t

  method main f main =
      Format.fprintf
	f "%s%a"
	header
	self#instructions main
      
  method prog f (progname, funs, main) =
    Format.fprintf f "<?php@\n%a%a@\n?>@\n"
      self#proglist funs
      self#main main

   method print_proto f (funname, t, li) =
    Format.fprintf f "function %a(%a)"
      self#funname funname
      (print_list
	 (fun t (a, type_) ->
	   Format.fprintf t
	     "%a%a"
	     self#prototype type_
	     self#binding a)
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

  method forloop f varname expr1 expr2 li =
      self#forloop_content f (varname, expr1, expr2, li)

end

let printer = new phpPrinter;;
