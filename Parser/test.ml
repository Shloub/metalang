
let () =
  let lexbuf = Lexing.from_channel (stdin)
  in let (r:Expr.t) = Parser.main Lexer.token lexbuf
  in let _ = Format.fprintf
    Format.std_formatter
    "%a@\n%a\n"
    Printer.expr r
    Expr.Eval.print
    (Expr.Eval.eval r)
  in ()
