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
*     * Neither the name of the University of California, Berkeley nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
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

let default_passes prog =
     prog
     |> Passes.WalkCheckNaming.apply
     |> Passes.WalkRename.apply
     |> Passes.WalkNopend.apply
     |> Passes.WalkExpandPrint.apply

let tex_passes prog = prog

let ocaml_passes prog =
  prog |> default_passes |> Passes.WalkIfMerge.apply

let clike_passes prog =
    prog |> default_passes |> Passes.WalkAllocArrayExpend.apply

let () =
  let stdlib_file = "Stdlib/stdlib.metalang" in
  let filename = Sys.argv.(1) in
  let progname = Filename.basename filename |> Filename.chop_extension in
  let () = begin
    Passes.Rename.add "out"; (* noms à renommer automatiquement *)
    Passes.Rename.add "exp";
    Passes.Rename.add "min";
    Passes.Rename.add "max";
    Passes.Rename.add progname;
  end in
  let out ext printer prog passes =
    let filename = progname ^ "." ^ ext in
    Printf.printf "Generating %s\n%!" filename;
    Fresh.fresh_init prog; (* var names generation init *)
    let prog = passes prog in
    let chan = open_out filename in
    let buf = Format.formatter_of_out_channel chan in
    let () = Format.fprintf buf "%a@;%!" printer prog in
    let () = close_out chan in ()
  in
  let lexbuf = Lexing.from_channel (open_in filename) in
  let stdlib_buf = Lexing.from_channel (open_in stdlib_file) in
  try
    let (funs, main) = Parser.main Lexer.token lexbuf in
    let stdlib_functions = Parser.functions Lexer.token stdlib_buf in
    let prog = (progname, funs, main) in    
    let used_functions = Passes.WalkCollectCalls.fold prog in
(*    let funs_add = List.filter (* sélection des fonctions de la stdlib *)
		  (function
		    | Prog.DeclarFun (v, _,_, _)
		    | Prog.Macro (v, _, _, _) -> BindingSet.mem v used_functions
		    | _ -> failwith ("bad stdlib")
		  )
		  stdlib_functions
    in *)
    let funs_add, _ = List.fold_right
      (fun f (li, used_functions) -> match f with
	| Prog.DeclarFun (v, _,_, _)
	| Prog.Macro (v, _, _, _) ->
	  if BindingSet.mem v used_functions
	  then (f::li, (Passes.WalkCollectCalls.fold_fun used_functions f) )
	  else (li, used_functions)
	| _ -> failwith ("bad stdlib")
      )
      stdlib_functions
      ([], used_functions)

    in let funs = funs_add @ funs in
    let prog = (progname, funs, main) in
    begin
      out "java" JavaPrinter.printer#prog prog clike_passes;
      out "c" CPrinter.printer#prog prog clike_passes;
      out "cc" CppPrinter.printer#prog prog clike_passes;
      out "ml" OcamlPrinter.printer#prog prog ocaml_passes;
      out "php" PhpPrinter.printer#prog prog clike_passes;
      out "cs" CsharpPrinter.printer#prog prog clike_passes;
      out "tex" TexPrinter.printer#prog prog tex_passes;
      (* out "sch" SchemePrinter.printer#prog prog clike_passes; *)
      (* out "sh" BashPrinter.printer#prog prog clike_passes; *)
    end
  with Parsing.Parse_error ->
    let curr = lexbuf.Lexing.lex_curr_p in
    let line = curr.Lexing.pos_lnum in
    let cnum = curr.Lexing.pos_cnum - curr.Lexing.pos_bol - 1 in
    let tok = Lexing.lexeme lexbuf in
    let () = Format.printf "error line %d char %d on token %s\n"
      line cnum
      tok
    in exit 1;;
