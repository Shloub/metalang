open Stdlib
open Ast

let default_passes prog =
     prog
     |> Passes.WalkNopend.apply
     |> Passes.WalkExpandPrint.apply

let ocaml_passes prog =
  prog |> default_passes |> Passes.WalkIfMerge.apply

let clike_passes prog =
    prog |> default_passes |> Passes.WalkAllocArrayExpend.apply

let () =
  let filename = Sys.argv.(1) in
  let progname = Filename.basename filename |> Filename.chop_extension in
  let out ext printer prog passes =
    let () = Fresh.fresh_init prog in (* var names generation init *)
    let prog = passes prog in
    let chan = open_out (progname ^ "." ^ ext) in
    let buf = Format.formatter_of_out_channel chan in
    let () = Format.fprintf buf "%a@;" printer prog in
    let () = close_out chan in ()
  in
  let lexbuf = Lexing.from_channel (open_in filename) in
  try
    let (funs, main) = Parser.main Lexer.token lexbuf in
    let prog = (progname, funs, main)
    in begin
      out "java" JavaPrinter.printer#prog prog clike_passes;
      out "c" CPrinter.printer#prog prog clike_passes;
      out "cc" CppPrinter.printer#prog prog clike_passes;
      out "ml" OcamlPrinter.printer#prog prog ocaml_passes;
      out "php" PhpPrinter.printer#prog prog clike_passes;
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
