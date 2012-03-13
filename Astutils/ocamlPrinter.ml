open Stdlib
open Ast
open Printer
(*
TODO ajouter des conversions de types pour les entiers / float
virer plus de refs
virer plus de nopending : inliner un peu
*)
class camlPrinter = object(self)
  inherit printer as super

  val mutable refbindings = BindingSet.empty

  method stdin_sep f =
    Format.fprintf f
    "@[<h>Scanf.scanf \"%%[\\n \\010]\" (fun _ -> ())@]"

  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
	| Expr.Add -> "+"
	| Expr.Sub -> "-"
	| Expr.Mul -> "*"
	| Expr.Div -> "/"
	| Expr.Mod -> "mod"
	| Expr.Or -> "or"
	| Expr.And -> "&&"
	| Expr.Lower -> "<"
	| Expr.LowerEq -> "<="
	| Expr.Higher -> ">"
	| Expr.HigherEq -> ">="
	| Expr.Eq -> "="
	| Expr.Diff -> "<>"
	| Expr.BinOr -> "lor"
	| Expr.BinAnd -> "land"
	| Expr.RShift -> "lsl"
	| Expr.LShift -> "lsr"
      )


  method unop f op a =
    match op with
      | Expr.Neg -> Format.fprintf f "-(%a)" self#expr a
      | Expr.Not -> Format.fprintf f "not(%a)" self#expr a
      | Expr.BNot -> Format.fprintf f "lnot(%a)" self#expr a


  method length f tab =
    Format.fprintf f "(Array.length %a)" self#binding tab
  
  method main f main =
    let () = self#calc_refs main in
    Format.fprintf f "@[<v 2>@[<h>let () =@\n@[<v 2>begin@\n%a@]@\nend@\n"
      self#instructions main
      
  method prog f (progname, funs, main) =
    Format.fprintf f "%a%a"
      self#proglist funs
      self#main main

  method rec_ f b =
    if b then Format.fprintf f "rec@ "

  method print_rec_proto f triplet = self#print_proto_aux f true triplet
  method print_proto f triplet = self#print_proto_aux f false triplet

  method print_proto_aux f rec_ (funname, t, li) =
    match li with
      | [] -> Format.fprintf f "let@ %a%a@ () ="
	self#rec_ rec_
	self#funname funname
      | _ ->
	Format.fprintf f "let@ %a%a@ %a ="
	  self#rec_ rec_
	  self#funname funname
	  (print_list
	     (fun t (a, b) -> self#binding t a)
	     (fun t f1 e1 f2 e2 -> Format.fprintf t
	       "%a@ %a" f1 e1 f2 e2)) li



  method bloc f li = Format.fprintf f "@[<v 2>begin@\n%a@]@\nend"
      (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)) li

  method if_ f e ifcase elsecase =
    match elsecase with
      | [] ->
	Format.fprintf f "@[<h>if@ %a@ then@]@\n%a@\n"
	  self#expr e
	  self#bloc ifcase
      | [Instr.F ( Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>if@ %a@ then@]@\n%a@\nelse %a"
	self#expr e
	self#bloc ifcase
	self#instr instr
      | _ ->
      Format.fprintf f "@[<h>if@ %a@ then@]@\n%a@\nelse@\n%a"
	self#expr e
	self#bloc ifcase
	self#bloc elsecase

  method instructions f instrs =
    (print_list
       self#instr
       (fun t print1 item1 print2 item2 ->
	 Format.fprintf t "%a@\n%a"
	   (fun t i ->
	     match Instr.unfix i with
	       | Instr.AllocArray _ -> self#instr f i
	       | Instr.Declare _ -> self#instr f i
	       | Instr.Comment _ -> self#instr f i
	       | _ -> Format.fprintf f "%a;" self#instr i
	   )
	   item1 print2 item2
       )
      ) f instrs

  method bloc f b =
    match b with
      | [i] ->
	Format.fprintf f "@[<h>%a@]" self#instr i
      | _ ->
	Format.fprintf f "begin@[<v 2>@\n%a@]@\nend" self#instructions b
      
  method binding f i = Format.fprintf f "%s" i

  method affect f m expr =
    Format.fprintf f "@[<h>%a@ %s@ %a@]"
      self#mutable_ m
      (match m with
	| Instr.Var _ -> ":="
	| Instr.Array _ -> "<-")     
      self#expr expr

  method declaration f var t e =
    if BindingSet.mem var refbindings then
      Format.fprintf f "@[<h>let %a@ =@ ref(@ %a )@ in@]"
	self#binding var
	self#expr e
    else
      Format.fprintf f "@[<h>let %a@ =@ %a@ in@]"
	self#binding var
	self#expr e

  method read f t m =
    Format.fprintf f "@[Scanf.scanf \"%a\" (fun value -> %a %s value)@]"
      self#format_type t
      self#mutable_ m
      (match m with
	| Instr.Var _ -> ":="
	| Instr.Array _ -> "<-")

  method calc_refs instrs =
    refbindings <-
      List.fold_left
      (Instr.Writer.Deep.fold
	 (fun acc i ->
	   match Instr.unfix i with
	     | Instr.Read (_, Instr.Var varname) -> BindingSet.add varname acc
	     | Instr.Affect (Instr.Var varname, _) -> BindingSet.add varname acc
	     | _ -> acc
	 ))
      BindingSet.empty
      instrs


  method mutable_ f m =
    match m with
      | Instr.Var binding -> self#binding f binding
      | Instr.Array (binding, indexes) -> self#access_array f binding indexes

      
  method is_rec funname instrs =
    true (* TODO *)

  method print_fun f funname t li instrs =
    let () = self#calc_refs instrs in
    let is_rec = self#is_rec funname instrs in
    let proto = if is_rec then self#print_rec_proto else self#print_proto
    in
    match t with
      | Type.F Type.Void ->
	Format.fprintf f "@[<h>%a@]@\n  @[<v 2>%a@]@\n@\n"
	  proto (funname, t, li)
	  self#instructions instrs
      | _ ->
	Format.fprintf f "@[<h>%a@]@\n  @[<v 2>%a@]@\n@\n"
	  proto (funname, t, li)
	  self#instructions instrs

  method expr_binding f e =
    if BindingSet.mem e refbindings
    then
      Format.fprintf f "!%a" self#binding e
    else
      Format.fprintf f "%a" self#binding e
      
  method access_array f arr index =
    Format.fprintf f "@[<h>%a.(%a)@]"
      self#binding arr
      (print_list
	 self#expr
	 (fun f f1 e1 f2 e2 ->
	   Format.fprintf f "%a).(%a"
	     f1 e1
	     f2 e2
	 )) index


  method print f t expr = (* TODO virer les parentheses quand on peut *)
    Format.fprintf f "@[Printf.printf \"%a \" (%a)@]"
      self#format_type t
      self#expr expr

  method comment f str =
    Format.fprintf f "(*%s*)" str

  method return f e =
    Format.fprintf f "@[<h>%a@]" self#expr e

  method allocarray_lambda f binding type_ len binding2 lambda =
      Format.fprintf f "@[<h>let %a@ =@ Array.init@ %a@ (fun@ %a@ ->@\n@[<v 2>  %a@])@ in@]"
	self#binding binding
	self#expr len
	self#binding binding2
	self#instructions lambda

  method allocarray f binding type_ len =
    Format.fprintf f "@[<h>let@ %a@ =@ Array.make@ %a@ (Obj.magic@ 0)@ in@]"
      self#binding binding
      self#expr len

  method affectarray f binding indexes e2 =
    Format.fprintf f "@[<h>%a.(%a)@ <-@ %a@]"
      self#binding binding
      (print_list
      self#expr
      (fun f f1 e1 f2 e2 ->
	Format.fprintf f "%a).(%a" f1 e1 f2 e2
      )) indexes
      self#expr e2


  method nop = function
    | Expr.Integer _ -> true
    | Expr.Float _ -> true
    | Expr.String _ -> true
    | Expr.Binding _ -> true
    | Expr.AccessArray (_, _) -> true
    | Expr.Call (_, _) -> false
    | _ -> false

(* Todo virer les parentheses quand on peut*)
  method apply (f:Format.formatter) (var:funname) (li:Expr.t list) : unit =
    match li with
      | [] ->
	Format.fprintf f "@[<h>(%a ())@]"
	  self#funname var
      | _ ->    
	Format.fprintf
	  f
	  "@[<h>%a %a@]"
	  self#funname var
	  (print_list
	     (fun t e ->
	       if self#nop (Expr.unfix e) then self#expr f e
	       else Format.fprintf f "(%a)" self#expr e
	     )
	     (fun t f1 e1 f2 e2 ->
	       Format.fprintf t "%a@ %a" f1 e1 f2 e2
	     )
	  ) li

  method call (f:Format.formatter) (var:funname) (li:Expr.t list) : unit =
    self#apply f var li

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for@ %a@ =@ %a@ to@ %a@\n@]do@[<v 2>@\n%a@]@\ndone"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#instructions li

end

let printer = new camlPrinter;;
