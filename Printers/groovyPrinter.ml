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

let print_expr tyenv macros e f p =
  let open Format in
  let open Expr in
  let print_lief prio f l = match l with
  | Char c -> let cs = Printf.sprintf "%C" c in
    if String.length cs == 6 then fprintf f "(char)%d" (int_of_char c)
    else fprintf f "(char)%s" cs
  | String s -> string_nodolar f s
  | Enum e ->
      let t = Typer.typename_for_enum e tyenv in
      fprintf f "%s.%s" (String.capitalize t) e
  | x -> JavaPrinter.print_lief tyenv prio f x in
  let print_expr0 config e f prio_parent = match e with
  | BinOp (a, (Div as op), b) -> fprintf f "%a.intdiv(%a)" a 0 b nop
  | _ -> print_expr0 config e f prio_parent in
  let print_mut conf prio f m = Mutable.Fixed.Deep.fold
      (print_mut0 "%a%a" "[%a]" "%a.%s" conf) m f prio in
  let config = {
    prio_binop;
    prio_unop;
    print_varname;
    print_lief;
    print_op;
    print_unop;
    print_mut;
    macros
  } in Fixed.Deep.fold (print_expr0 config) e f p


(** the main class : the ocaml printer *)
class groovyPrinter = object(self)
  inherit JavaPrinter.javaPrinter as super

  method expr f e = print_expr (self#getTyperEnv ())
      (StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros) e f nop

  method limit_nprint () = 254

  method lang () = "groovy"

  method main f main = self#instructions f main

  method formater_type t = "%s"

  method separator f () = ()
  method static f () = ()
  
  method decl_field f (name, type_) = Format.fprintf f "%a %a" self#ptype type_ self#field name

  method typename f n = Format.fprintf f "%s" (String.capitalize n)

  method print f t expr = Format.fprintf f "@[<h>print(%a)@]" self#expr expr

  method multi_print f li =
    let limit = 100 in
    if List.length li > limit then
      let lili = List.pack limit li in
      print_list self#multi_print sep_nl f lili
    else
    let format, exprs = self#extract_multi_print li in
    match exprs with
    | [] -> Format.fprintf f "@[<h>System.out.print(\"%s\");@]" format
    | _ ->
      Format.fprintf f "@[<h>System.out.printf(\"%s\", %a);@]" format
        (print_list self#expr sep_c ) (List.map snd exprs)

  method print_scanner f () =
    Format.fprintf f "@[<h>@@Field %aScanner scanner = new Scanner(System.in)%a@]"
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
