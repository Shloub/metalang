open Stdlib
open Ast

let () =
  let lexbuf = Lexing.from_channel (stdin) in
  try
    let prog = Parser.main Lexer.token lexbuf in
    let () = Fresh.fresh_init prog
    in let prog = prog
      |> Passes.WalkNopend.apply
      |> Passes.WalkExpandPrint.apply
    in let () =
      Printer.camlprinter#prog Format.std_formatter prog
    in ()
  with Parsing.Parse_error ->
    let curr = lexbuf.Lexing.lex_curr_p in
    let line = curr.Lexing.pos_lnum in
    let cnum = curr.Lexing.pos_cnum - curr.Lexing.pos_bol in
    let tok = Lexing.lexeme lexbuf in
    Format.printf "error line %d char %d on token %s\n"
      line cnum
      tok
