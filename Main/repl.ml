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

(** Read Eval Print Loop
*
* @see <http://prologin.org> Prologin
* @author Prologin (info@prologin.org)
* @author Arthur Wendling (art.wendling@gmail.com)
*)

open Stdlib
open Ast

let read_line () =
	Printf.printf ">>> %!" ;
	Pervasives.read_line ()

let parse_expr line =
	let lexbuf = Lexing.from_string line in
	try Parser.toplvl_expr Lexer.token lexbuf
	with Parser.Error ->
    let curr = lexbuf.Lexing.lex_curr_p in
    let cnum = curr.Lexing.pos_cnum - curr.Lexing.pos_bol - 1 in
    let tok = Lexing.lexeme lexbuf in
    Format.printf "PARSE ERROR at char %d on token %s\n" cnum tok ;
		raise Parser.Error

let print_expr expr =
	OcamlPrinter.printer#expr Format.std_formatter expr ;
	Format.print_newline ()

let step () = try print_expr (parse_expr (read_line ())) with Parser.Error -> ()

let () =
	while true do step () done
