open Ast

class printer = object(self)

  method binding f i = Format.fprintf f "%%%s" i
  method string f i = Format.fprintf f "%S" i (* TODO faire mieux *)
  method float f i = Format.fprintf f "%f" i (* TODO faire mieux *)

  method expr f t =
    let printp f e =
      Format.fprintf f "@[<h 2>(%a)@]" self#expr e
    in
    let binop op a b =
      match (a, b) with
      | Expr.F (Expr.Integer _), 
	Expr.F (Expr.Integer _) ->
	  Format.fprintf f "%a@ %s@ %a@]" self#expr a op self#expr b
      | _, 
	Expr.F (Expr.Integer _) ->
	  Format.fprintf f "%a@ %s@ %a@]" printp a op self#expr b
      | Expr.F (Expr.Integer _), _ ->
	  Format.fprintf f "%a@ %s@ %a@]" self#expr a op printp b
      | _ ->
	  Format.fprintf f "%a@ %s@ %a@]" printp a op printp b
    in
    let t = Expr.unfix t in
    match t with
    | Expr.Sub (a, b) -> binop "-" a b
    | Expr.Add (a, b) -> binop "+" a b
    | Expr.Mul (a, b) -> binop "*" a b
    | Expr.Div (a, b) -> binop "/" a b
    | Expr.Integer i -> Format.fprintf f "%i" i
    | Expr.Float i -> self#float f i
    | Expr.String i -> self#string f i
    | Expr.Binding b -> self#binding f b
end

let printer = new printer;;

let expr = printer#expr;;
