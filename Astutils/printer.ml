open Ast


let print_list
    (func : Format.formatter -> 'a -> unit)
    (sep :
       Format.formatter ->
	 (Format.formatter -> 'a -> unit) -> 'a ->
	   (Format.formatter -> 'a list -> unit) -> 'a list ->
	     unit
    )
    (f : Format.formatter)
    (li : 'a list)
    : unit
    =
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

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for@ %a=%a@ to@ %a@\n@]%a"
      self#binding varname
      self#expr expr1
      self#expr expr2
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
      | Type.Bool -> Format.fprintf f "bool"
      | Type.Char -> Format.fprintf f "char"

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

  method call (f:Format.formatter) (var:funname) (li:Expr.t list) : unit =
    Format.fprintf
      f
      "@[<h>%a(%a);@]"
	  self#funname var
	  (print_list
	     self#expr
	     (fun t f1 e1 f2 e2 ->
	       Format.fprintf t "%a,@ %a" f1 e1 f2 e2
	     )
	  ) li

  method apply (f:Format.formatter) (var:funname) (li:Expr.t list) : unit =
    Format.fprintf
      f
      "%a(%a)"
	  self#funname var
	  (print_list
	     self#expr
	     (fun t f1 e1 f2 e2 ->
	       Format.fprintf t "%a,@ %a" f1 e1 f2 e2
	     )
	  ) li

  method stdin_sep f =
    Format.fprintf f "@[read_blank(STDIN);@]"


  method instr f t =
    match Instr.unfix t with
      | Instr.StdinSep -> self#stdin_sep f
    | Instr.Declare (varname, type_, expr) -> self#declaration f varname type_ expr
    | Instr.Affect (varname, expr) -> self#affect f varname expr
    | Instr.Loop (varname, expr1, expr2, li) ->
	self#forloop f varname expr1 expr2 li
    | Instr.Comment str -> self#comment f str
    | Instr.Return e -> self#return f e
    | Instr.AllocArray (binding, type_, len) ->
	self#allocarray f binding type_ len
    | Instr.AffectArray (binding, e1, e2) ->
	self#affectarray f binding e1 e2
    | Instr.If (e, ifcase, elsecase) ->
	self#if_ f e ifcase elsecase
    | Instr.Call (var, li) -> self#call f var li

    | Instr.Read (t, binding) -> self#read f t binding
    | Instr.Print (t, expr) -> self#print f t expr

  method format_type f t = match Type.unfix t with
    | Type.Integer -> Format.fprintf f "%%d"
    | Type.Float -> Format.fprintf f "%%.2f"
    | Type.Char -> Format.fprintf f "%%c"
    | _ -> Format.fprintf f "TODO"

  method read f t binding =
    Format.fprintf f "@[read<%a>(%a);@]" self#ptype t self#binding binding

  method print f t expr =
    Format.fprintf f "@[print<%a>(%a);@]" self#ptype t self#expr expr

  method if_ f e ifcase elsecase =
    match elsecase with
      | [] ->
	Format.fprintf f "@[<h>if@ (%a)@]@\n%a"
	  self#expr e
	  self#bloc ifcase
      | _ ->
	Format.fprintf f "@[<h>if@ (%a)@]@\n%a@\nelse@\n%a"
	  self#expr e
	  self#bloc ifcase
	  self#bloc elsecase

  method bool f = function
    | true -> Format.fprintf f "true"
    | false -> Format.fprintf f "false"

  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
       | Expr.Add -> "+"
       | Expr.Sub -> "-"
       | Expr.Mul -> "*"
       | Expr.Div -> "/"
       | Expr.Mod -> "%"
       | Expr.Or -> "||"
       | Expr.And -> "&&"
       | Expr.Lower -> "<"
       | Expr.LowerEq -> "<="
       | Expr.Higher -> ">"
       | Expr.HigherEq -> ">="
       | Expr.Eq -> "=="
       | Expr.Diff -> "!="
       | Expr.BinOr -> "|"
       | Expr.BinAnd -> "&"
       | Expr.RShift -> ">>"
       | Expr.LShift -> "<<"
      )
    
  method unop f op a =
    match op with
      | Expr.Neg -> Format.fprintf f "-(%a)" self#expr a
      | Expr.Not -> Format.fprintf f "!(%a)" self#expr a
      | Expr.BNot -> Format.fprintf f "~(%a)" self#expr a

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
      | Expr.Call (_, _) -> true
      | _ -> false
    in
    let binop op a b =
      let chf x = if nop (Expr.unfix x) then self#expr else printp
      in Format.fprintf f "%a@ %a@ %a" (chf a) a self#print_op op (chf b) b
    in
    let t = Expr.unfix t in
    match t with
    | Expr.Bool b -> self#bool f b
    | Expr.UnOp (a, op) -> self#unop f op a
    | Expr.BinOp (a, op, b) -> binop op a b
    | Expr.Integer i -> Format.fprintf f "%i" i
    | Expr.Float i -> self#float f i
    | Expr.String i -> self#string f i
    | Expr.Binding b -> self#expr_binding f b
    | Expr.AccessArray (arr, index) ->
	self#access_array f arr index
    | Expr.Call (funname, li) -> self#apply f funname li
    | Expr.Length (tab) ->
      self#length f tab
    | Expr.Char (c) -> self#char f c

  method char f c = Format.fprintf f "'%c'" c (* TODO *)

  method expr_binding f e = self#binding f e

  method length f tab =
    Format.fprintf f "count(%a)" self#binding tab

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
      self#instructions instrs

  method prog_item f t =
    match t with
    | Prog.DeclarFun (var, t, li, instrs) ->
	self#print_fun f var t li instrs


  method prog f ((progname, funs, main):Prog.t) =
    Format.fprintf f "%a%a@\n"
      self#proglist funs
      self#main main

  method instructions f instrs =
    (print_list
       self#instr
       (fun t print1 item1 print2 item2 ->
	 Format.fprintf t "%a@\n%a" print1 item1 print2 item2
       )
      ) f instrs

  method proglist f funs =
    Format.fprintf f "%a@\n"
    (print_list
       self#prog_item
       (fun t print1 item1 print2 item2 ->
	 Format.fprintf t "%a@\n%a" print1 item1 print2 item2
       )
    ) funs

  method main f main =
    Format.fprintf f "%a"
     self#instructions main
end

class pythonPrinter = object(self)
    inherit printer as super
  method bool f = function
    | true -> Format.fprintf f "True"
    | false -> Format.fprintf f "False"
end
