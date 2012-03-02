open Stdlib
open Ast


let () =
  (* TODO parser args *)
  let filename = "tests/prog/test01.metalang" in
  let progname = "test01" in
  let out ext printer prog =
    let chan = open_out (progname ^ "." ^ ext) in
    let buf = Format.formatter_of_out_channel chan in
    let () = Format.fprintf buf "%a@;" printer prog in
    let () = close_out chan in ()
  in
  let lexbuf = Lexing.from_channel (open_in filename) in
  try
    let prog = Parser.main Lexer.token lexbuf in
    let () = Fresh.fresh_init prog
    in let (funs, main) = prog
      |> Passes.WalkNopend.apply
      |> Passes.WalkExpandPrint.apply
       in let prog = (progname, funs, main)
    in begin
      out "java" JavaPrinter.printer#prog prog;
      out "c" CPrinter.printer#prog prog;
      out "cc" CppPrinter.printer#prog prog;
      out "ml" OcamlPrinter.printer#prog prog;
      out "php" PhpPrinter.printer#prog prog;
    end
  with Parsing.Parse_error ->
    let curr = lexbuf.Lexing.lex_curr_p in
    let line = curr.Lexing.pos_lnum in
    let cnum = curr.Lexing.pos_cnum - curr.Lexing.pos_bol in
    let tok = Lexing.lexeme lexbuf in
    Format.printf "error line %d char %d on token %s\n"
      line cnum
      tok
