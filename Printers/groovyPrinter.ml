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
 *)

(** groovy Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast
open JavaPrinter

(** the main class : the ocaml printer *)
class groovyPrinter = object(self)
  inherit javaPrinter as super


  method lang () = "groovy"

  method main f main = self#instructions f main

  method formater_type t = "%s"

  method separator f () = ()
  method static f () = ()
  method char f c = Format.fprintf f "(char)%C" c

  method decl_field f (name, type_) = Format.fprintf f "%a %a" self#ptype type_ self#field name

  method typename f n = Format.fprintf f "%s" (String.capitalize n)

  method print f t expr = Format.fprintf f "@[<h>print(%a)@]" self#expr expr

  method binop f op a b =
    match op with
    | Expr.Div ->
        Format.fprintf f "(int)(%a %a@;%a)"
          (self#chf op Printer.Left) a
          self#print_op op
          (self#chf op Printer.Right) b
    | _ -> super#binop f op a b

  method multi_print f format exprs =
    match exprs with
    | [] -> Format.fprintf f "@[<h>System.out.print(\"%s\");@]" format
    | _ ->
      Format.fprintf f "@[<h>System.out.printf(\"%s\", %a);@]" format
        (print_list self#expr sep_c ) (List.map snd exprs)


  method print_scanner f () =
    Format.fprintf f "@[<h>@Field %aScanner scanner = new Scanner(System.in)%a@]"
      self#static ()
      self#separator ()

  method prog f prog =
    let reader = Tags.is_taged "use_readmacros" || prog.Prog.hasSkip || TypeSet.cardinal prog.Prog.reads <> 0 in
    let datareader = Tags.is_taged "use_java_readline" in
    Format.fprintf f
      "%aimport java.util.*@\n%a@\n%a@\n%a@\n%a@\n"
      (fun f () -> if reader || datareader then Format.fprintf f "import groovy.transform.Field@\n") ()
      (if datareader then self#print_datareader else fun f () -> ()) ()
      self#proglist prog.Prog.funs
      (if reader || datareader then self#print_scanner else fun f () -> ()) ()
      (print_option self#main) prog.Prog.main


end
