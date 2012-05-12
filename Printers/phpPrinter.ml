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
* @see http://prologin.org
* @author Prologin <info@prologin.org>
* @author Maxime Audouin <coucou747@gmail.com>
*
*)

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
function nextChar(){
  global $stdin;
  $out = $stdin[0];
  $stdin = substr($stdin, 1);
  return $out;
}
";

class phpPrinter = object(self)
  inherit cPrinter as super

  method lang () = "php"

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

  method read f t m =
    match Type.unfix t with
      | Type.Char ->
	Format.fprintf f "@[%a = nextChar();@]"
	  self#mutable_ m
      | _ ->
	Format.fprintf f "@[list(%a) = scan(\"%a\");@]"
	  self#mutable_ m
	  self#format_type t

  method main f main =
      Format.fprintf
	f "%s%a"
	header
	self#instructions main
      
  method prog f prog =
    Format.fprintf f "<?php@\n%a%a@\n?>"
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

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
