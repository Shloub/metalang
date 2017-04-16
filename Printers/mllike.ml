(*
 * Copyright (c) 2016, Prologin
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

(** Ocaml Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper

let ptype ty f () =
  let open Ast.Type in
  let open Format in
  match ty with
  | Integer -> fprintf f "int"
  | String -> fprintf f "string"
  | Array a -> fprintf f "%a array" a ()
  | Void ->  fprintf f "unit"
  | Option a -> fprintf f "%a option" a ()
  | Bool -> fprintf f "bool"
  | Char -> fprintf f "char"
  | Named n -> fprintf f "%s" n
  | Struct li -> fprintf f "{%a}"
                   (print_list
                      (fun t (name, type_) ->
                         fprintf t "mutable %s : %a;" name type_ ()
                      )
                      sep_space
                   ) li
  | Enum li ->
    fprintf f "%a"
      (print_list
         (fun t name ->
            fprintf t "%s" name
         )
         (sep "%a@\n| %a")
      ) li
  | Lexems -> assert false
  | Auto -> assert false
  | Tuple li -> fprintf f "(%a)" (print_list (fun f p -> p f ()) (sep "%a * %a")) li

let ptype f t = Ast.Type.Fixed.Deep.fold ptype t f ()

let print_lief f l =
  let open Ast.Expr in let open Format in match l with
  | Char c -> fprintf f "%C" c
  | String s -> fprintf f "%S" s
  | Integer i -> fprintf f "%i" i
  | Bool true -> fprintf f "true"
  | Bool false -> fprintf f "false"
  | Enum s -> fprintf f "%s" s

let prio_arg = -105
let prio_tuple = -103
let prio_apply = -101

let pcall macros f prio_parent func li =
  match StringMap.find_opt func macros with
  | Some ( (t, params, code) ) ->
    pmacros f "(%s)" t params code li nop
  | None ->
    if li = [] then parens prio_parent prio_apply f "%s ()" func
    else parens prio_parent prio_apply f "%s %a" func (print_list (fun f x -> x f prio_arg) sep_space) li
