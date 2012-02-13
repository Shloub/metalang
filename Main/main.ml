open Stdlib
open Ast

let myprog =
  Expr.add

    ( Expr.add
	(
	   Expr.add

    ( Expr.add (Expr.integer 1)
	(Expr.sub
	   (Expr.add (Expr.integer 2) (Expr.integer 4))
	   (Expr.add (Expr.integer 3) (Expr.integer 5))
	)) 
    ( Expr.add (Expr.integer 2)
	(
  Expr.add

    ( Expr.add (Expr.integer 1)
	(Expr.sub
	   (Expr.add (Expr.integer 2) (Expr.integer 4))
	   (Expr.add (Expr.integer 3) (Expr.integer 5))
	)) 
    ( Expr.add (Expr.integer 2) (Expr.integer 3))
	))
	)
	(Expr.sub
	   (Expr.add (Expr.integer 2) (Expr.integer 4))
	   (Expr.add (Expr.integer 3) (Expr.integer 5))
	)) 
    ( Expr.add (Expr.integer 2) (Expr.integer 3))
|> Expr.mul (Expr.integer 2)
;;


let () = Format.fprintf Format.std_formatter "%a\n= %a\n"
    Printer.expr myprog
    Expr.Eval.print
    (Expr.Eval.eval myprog);;

let myprog2 = Expr.string "ma petite chaine\"\n lalala";;

let () = Format.fprintf Format.std_formatter "%a\n"
    Printer.expr myprog2;;
