open Ast


let print_list func sep f li =
  let rec p t = function
    | [] -> ()
    | [hd] -> func t hd
    | hd::tl ->
	sep
	  t
	  func hd
	  p tl
  in p f li


class printer = object(self)

  method binding f i = Format.fprintf f "%%%s" i
  method funname f i = Format.fprintf f "%s" i
  method string f i = Format.fprintf f "%S" i (* TODO faire mieux *)
  method float f i = Format.fprintf f "%f" i (* TODO faire mieux *)

  method declaration f var =
    Format.fprintf f "@[var@ %a;@]" self#binding var
  method affect f var expr =
    Format.fprintf f "@[<h>%a@ =@ %a;@]" self#binding var self#expr expr

  method bloc f li = Format.fprintf f "@[<v 2>do@\n%a@]@\ndone"
      (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)) li

  method forloop f varname expr1 expr2 expr3 li =
    Format.fprintf f "@[<h>for@ %a=%a@ to@ %a@ step@ %a@\n@]%a"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#expr expr3
      self#bloc li


  method comment f str =
    Format.fprintf f "/*%s*/" str

  method return f e =
    Format.fprintf f "@[<h>return@ %a;@]" self#expr e

  method ptype f t =
      match Type.unfix t with
      | Type.Integer -> Format.fprintf f "int"
      | Type.String -> Format.fprintf f "string"
      | Type.Float -> Format.fprintf f "float"
      | Type.Array a -> Format.fprintf f "array(%a)" self#ptype a

  method allocarray f binding type_ len =
      Format.fprintf f "@[<h>%a@ =@ new@ array@ of@ %a[%a];@]@\n"
	self#binding binding
	self#ptype type_
	self#expr len

  method instr f t =
    match Instr.unfix t with
    | Instr.Declare varname -> self#declaration f varname
    | Instr.Affect (varname, expr) -> self#affect f varname expr
    | Instr.Loop (varname, expr1, expr2, expr3, li) ->
	self#forloop f varname expr1 expr2 expr3 li
    | Instr.Comment str -> self#comment f str
    | Instr.Return e -> self#return f e
    | Instr.AllocArray (binding, type_, len) ->
	self#allocarray f binding type_ len

  method expr f t =
    let printp f e =
      Format.fprintf f "@[<h 2>(%a)@]" self#expr e
    in
    let nop = function
      | Expr.Integer _ -> true
      | Expr.Float _ -> true
      | Expr.String _ -> true
      | Expr.Binding _ -> true
      | Expr.AccessArray (_, _) -> true
      | _ -> false
    in
    let binop op a b =
      let chf x = if nop (Expr.unfix x) then self#expr else printp
      in Format.fprintf f "%a@ %s@ %a" (chf a) a op (chf b) b
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
    | Expr.AccessArray (arr, index) ->
	self#access_array f arr index

  method access_array f arr index =
    Format.fprintf f "@[<h>%a[%a]@]"
      self#binding arr
      self#expr index

  method print_fun f funname li instrs =
    Format.fprintf f "@[<h>function %a(%a)@]@\n@[<v 2>{@\n%a@]@\n}@\n"
      self#funname funname
      (print_list self#binding (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a,@ %a" f1 e1 f2 e2)) li
      (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)) instrs

  method prog f t =
    match t with
    | Prog.DeclarFun (var, li, instrs) ->
	self#print_fun f var li instrs

end

class phpPrinter = object(self)
  inherit printer as super
  method binding f i = Format.fprintf f "$%s" i
  method declaration f var = Format.fprintf f "/*local var %a*/" self#binding var
  method bloc f li = Format.fprintf f "@[<v 2>{@\n%a@]@\n}"
      (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)) li

  method forloop f varname expr1 expr2 expr3 li =
    Format.fprintf f "@[<h>for@ (%a@ =@ %a@ ;@ %a@ <@ %a;@ %a@ +=@ %a)@\n@]%a"
      self#binding varname
      self#expr expr1
      self#binding varname
      self#expr expr2
      self#binding varname
      self#expr expr3
      self#bloc li

end


let printer = new phpPrinter;;

let expr = printer#expr;;
let instr = printer#instr;;
let prog = printer#prog;;
