open Stdlib
open Ast


let () =
  (* TODO parser args *)
  let filename = "tests/prog/test01.metalang" in
  let progname = "test01" in
  let out ext =
    open_out (progname ^ "." ^ ext) |> Format.formatter_of_out_channel
  in
  let lexbuf = Lexing.from_channel (open_in filename) in
  try
    let prog = Parser.main Lexer.token lexbuf in
    let () = Fresh.fresh_init prog
    in let prog = prog
      |> Passes.WalkNopend.apply
      |> Passes.WalkExpandPrint.apply
    in begin
      JavaPrinter.printer#prog (out "java") prog;
      CPrinter.printer#prog (out "c") prog;
      CppPrinter.printer#prog (out "cc") prog;
      OcamlPrinter.printer#prog (out "ml") prog;
      PhpPrinter.printer#prog (out "php") prog;
    end
  with Parsing.Parse_error ->
    let curr = lexbuf.Lexing.lex_curr_p in
    let line = curr.Lexing.pos_lnum in
    let cnum = curr.Lexing.pos_cnum - curr.Lexing.pos_bol in
    let tok = Lexing.lexeme lexbuf in
    Format.printf "error line %d char %d on token %s\n"
      line cnum
      tok
