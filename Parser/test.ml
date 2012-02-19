
let () =
  let lexbuf = Lexing.from_channel (stdin)
  in let (r:Expr.t) = Parser.result Lexer.token lexbuf
  in let _ = Format.fprintf
    Format.std_formatter
    "%a@\n%a\n"
    Printer.phpexpr r
    Expr.Eval.print
    (Expr.Eval.eval r)
  in ()
