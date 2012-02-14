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

  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ %a@ =@ %a@]"
      self#binding var
      self#ptype t
      self#expr e

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
      | Type.Void ->  Format.fprintf f "void"

  method allocarray f binding type_ len =
      Format.fprintf f "@[<h>%a@ =@ new@ array@ of@ %a[%a];@]"
	self#binding binding
	self#ptype type_
	self#expr len

  method affectarray f binding e1 e2 =
    Format.fprintf f "@[<h>%a[%a]@ =@ %a;@]"
      self#binding binding
      self#expr e1
      self#expr e2

  method instr f t =
    match Instr.unfix t with
    | Instr.Declare (varname, type_, expr) -> self#declaration f varname type_ expr
    | Instr.Affect (varname, expr) -> self#affect f varname expr
    | Instr.Loop (varname, expr1, expr2, expr3, li) ->
	self#forloop f varname expr1 expr2 expr3 li
    | Instr.Comment str -> self#comment f str
    | Instr.Return e -> self#return f e
    | Instr.AllocArray (binding, type_, len) ->
	self#allocarray f binding type_ len
    | Instr.AffectArray (binding, e1, e2) ->
	self#affectarray f binding e1 e2

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

  method print_proto f (funname, t, li) =
    Format.fprintf f "function@ %a(%a)@ returns %a"
      self#funname funname
      (print_list
	 (fun f (n, t) ->
	   Format.fprintf f "%a@ (%a)"
	     self#binding n
	     self#ptype t)
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a,@ %a" f1 e1 f2 e2)) li
      self#ptype t

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>%a@]@\n@[<v 2>{@\n%a@]@\n}@\n"
      self#print_proto (funname, t, li)
      (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)) instrs

  method prog f t =
    match t with
    | Prog.DeclarFun (var, t, li, instrs) ->
	self#print_fun f var t li instrs

end

class cPrinter = object(self)
  inherit printer as super
  
  method binding f i = Format.fprintf f "%s" i
  
  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ %a@ =@ %a;@]"
      self#ptype t
      self#binding var
      self#expr e


  method allocarray f binding type_ len =
      Format.fprintf f "@[<h>%a@ *%a@ =@ malloc(@ (%a)@ *@ sizeof(%a));@]"
      self#ptype type_
      self#binding binding
      self#expr len
      self#ptype type_

  method forloop f varname expr1 expr2 expr3 li =
    Format.fprintf f "@[<h>for@ (%a@ =@ %a@ ;@ %a@ <@ %a;@ %a@ +=@ %a)@\n@]%a"
      self#binding varname
      self#expr expr1
      self#binding varname
      self#expr expr2
      self#binding varname
      self#expr expr3
      self#bloc li


  method bloc f li = Format.fprintf f "@[<v 2>{@\n%a@]@\n}"
      (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)) li


  method print_proto f (funname, t, li) =
    Format.fprintf f "%a %a(%a)"
      self#ptype t
      self#funname funname
      (print_list
	 (fun t (binding, type_) ->
	   Format.fprintf t "%a@ %a"
	     self#ptype type_
	     self#binding binding
	 )
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	     "%a,@ %a" f1 e1 f2 e2)
      ) li



end

class phpPrinter = object(self)
  inherit cPrinter as super


  method print_proto f (funname, t, li) =
    Format.fprintf f "function %a(%a)"
      self#funname funname
      (print_list
	 (fun t (a, b) -> self#binding t a)
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a,@ %a" f1 e1 f2 e2)) li


  method binding f i = Format.fprintf f "$%s" i

  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ =@ %a;@]"
      self#binding var
      self#expr e

  method allocarray f binding type_ len =
      Format.fprintf f "@[<h>%a@ =@ array()@]"
      self#binding binding
end


let printer = new cPrinter;;

let expr = printer#expr;;
let instr = printer#instr;;
let prog = printer#prog;;
