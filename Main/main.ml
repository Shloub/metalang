open Stdlib
open Ast

let () =
  let lexbuf = Lexing.from_channel (stdin) in
  try
    let funs, main = Parser.main Lexer.token lexbuf
    in let () =
      Format.fprintf Format.std_formatter "%a\n"
	(Printer.print_list
	   Printer.phpprog
	   (fun t print1 item1 print2 item2 ->
	     Format.fprintf t "%a%a" print1 item1 print2 item2
	   )
	) funs
    in ()
  with Parsing.Parse_error ->
    let curr = lexbuf.Lexing.lex_curr_p in
    let line = curr.Lexing.pos_lnum in
    let cnum = curr.Lexing.pos_cnum - curr.Lexing.pos_bol in
    let tok = Lexing.lexeme lexbuf in
    Format.printf "error line %d char %d on token %s\n"
      line cnum
      tok
