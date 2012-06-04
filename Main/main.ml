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

(** Main
    *
    * @see <http://prologin.org> Prologin
    * @author Prologin (info@prologin.org)
    * @author Maxime Audouin (coucou747@gmail.com)
    * @author Arthur Wendling (art.wendling@gmail.com)
*)


open Stdlib
open Ast
open Arg

(** {2 Languages definition } *)

let default_passes (prog : Prog.t) : Prog.t =
  prog
  |> Passes.WalkCheckNaming.apply
  |> Passes.WalkRename.apply
  |> Passes.WalkNopend.apply
  |> Passes.WalkExpandPrint.apply

let clike_passes prog =
  prog |> default_passes
  |> Passes.WalkAllocArrayExpend.apply
  |> Passes.WalkExpandReadDecl.apply

let ocaml_passes prog =
  prog |> default_passes
  |> Passes.WalkIfMerge.apply

let no_passes prog = prog

module L = MakeMap (String)
let languages, printers =
  let ( => ) pa pr out prog = pr out (pa prog) in
  let ls = [
    "metalang", no_passes => Printer.printer#prog ;
    "c",    clike_passes => CPrinter.printer#prog ;
    "cc",   clike_passes => CppPrinter.printer#prog ;
    "cs",   clike_passes => CsharpPrinter.printer#prog ;
    "java", clike_passes => JavaPrinter.printer#prog ;
    "ml",   ocaml_passes => OcamlPrinter.printer#prog ;
    "php",  clike_passes => PhpPrinter.printer#prog ;
    "rb",   clike_passes => RbPrinter.printer#prog ;
    "py",   clike_passes => PyPrinter.printer#prog ;
    "tex",  no_passes   =>  TexPrinter.printer#prog ;
    "sch",  ocaml_passes   =>  SchemePrinter.printer#prog ;
  ] in
  List.map fst ls, L.from_list ls

let remove_unknown_languages =
  let go lang =
    L.mem lang printers
    || (Printf.fprintf stderr "unknown language %s\n" lang ; false)
  in List.filter go

let stdlib_file = "Stdlib/stdlib.metalang"

(** {2 Command Line Arguments} *)

type config = {
  mutable languages : string list ;
  mutable output_dir : string ;
  mutable filenames : string list ;
  mutable quiet : bool;
  mutable stdlib : bool;
}

let default_config () = {
  languages = languages ;
  output_dir = "." ;
  filenames = [] ;
  quiet = false ;
  stdlib = true;
}

let config () =
  let c = default_config () in
  let all = String.concat "," languages in
  let split ls = remove_unknown_languages $ Str.split (Str.regexp ",") ls in
  let descr = "metalang [-lang " ^ all ^ "] [-o directory] A.metalang B.metalang ..." in
  let spec = [
    "-lang", String (fun ls -> c.languages <- split ls),
    "List of target languages separated by commas"
    ^ " [default is " ^ all ^ "]" ;

    "-o", String (fun o -> c.output_dir <- o),
    "Output directory [default is .]" ;

    "-quiet", Unit (fun () -> c.quiet <- true),
    "Display error and warnings only";

     "-nostdlib", Unit (fun () -> c.stdlib <- false),
    "Don't use the standard library";
 ] in
  Arg.parse spec (fun f -> c.filenames <- f :: c.filenames) descr ;
  c

(** {2 Process} *)

let parse_file parse filename =
  let lexbuf = Lexing.from_channel (open_in filename) in
  try parse Lexer.token lexbuf
  with Parser.Error ->
    let curr = lexbuf.Lexing.lex_curr_p in
    let line = curr.Lexing.pos_lnum in
    let cnum = curr.Lexing.pos_cnum - curr.Lexing.pos_bol - 1 in
    let tok = Lexing.lexeme lexbuf in
    Format.printf "%s: error line %d char %d on token %s\n"
      filename line cnum tok ;
    exit 1

let make_prog stdlib filename =
  let progname = Filename.chop_extension $ Filename.basename filename in
  let funs, main = parse_file Parser.prog filename in
  let stdlib = if stdlib then parse_file Parser.toplvls stdlib_file else [] in
  let prog = {
    Prog.progname = progname ;
    Prog.funs = funs ;
    Prog.main = main ;
  } in
  let used_functions = Passes.WalkCollectCalls.fold prog in
  let go f (li, used_functions) = match f with
    | Prog.DeclarFun (v, _,_, _)
    | Prog.Macro (v, _, _, _) ->
      if BindingSet.mem v used_functions
      then (f::li, (Passes.WalkCollectCalls.fold_fun used_functions f) )
      else (li, used_functions)
    | _ -> failwith ("bad stdlib") in
  let funs_add, _ = List.fold_right go stdlib ([], used_functions) in
  let funs = funs_add @ funs in
  { prog with Prog.funs = funs }

let process c filename =
  let prog = make_prog c.stdlib filename in
  let go lang =
    let printer = L.find lang printers in
    let output = c.output_dir ^ "/" ^ prog.Prog.progname ^ "." ^ lang in
    if not c.quiet then Printf.printf "Generating %s\n%!" output ;
    Fresh.fresh_init prog ;
    let chan = open_out output in
    let buf = Format.formatter_of_out_channel chan in
    Format.fprintf buf "%a@;%!" printer prog ;
    close_out chan in
  begin  (* noms à renommer automatiquement *)
    Passes.Rename.clear ();
    Passes.Rename.add prog.Prog.progname ;
    Passes.Rename.add "out" ;
    Passes.Rename.add "exp" ;
    Passes.Rename.add "min" ;
    Passes.Rename.add "max" ;
    List.iter go c.languages
  end

let process_config c =
  List.iter (process c) c.filenames

let () =
  process_config $ config ()
