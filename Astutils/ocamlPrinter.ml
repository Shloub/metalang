open Stdlib
open Ast
open Printer

class camlPrinter = object(self)
  inherit printer as super

  method length f tab =
    Format.fprintf f "(Array.length %a)" self#binding tab
  
  method main f main =
    Format.fprintf f "@[<v 2>@[<h>let () =@\n@[<v 2>begin@\n%a@]@\nend@\n"
      self#instructions main
      
  method prog f (funs, main) =
    Format.fprintf f "%a%a"
      self#proglist funs
      self#main main

  method print_proto f (funname, t, li) =
    Format.fprintf f "let@ %a@ %a ="
      self#funname funname
      (print_list
	 (fun t (a, b) -> self#binding t a)
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a@ %a" f1 e1 f2 e2)) li

  method bloc f li = Format.fprintf f "@[<v 2>begin@\n%a@]@\nend"
      (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)) li

  method if_ f e ifcase elsecase =
    Format.fprintf f "@[<h>if@ %a@ then@]@\n%a@\nelse@\n%a"
      self#expr e
      self#bloc ifcase
	  self#bloc elsecase

  method bloc f b =
    match b with
      | [Instr.F (Instr.Return b)] ->
	Format.fprintf f "@[<h>%a@]" self#expr b
      | _ -> super#bloc f b

  method binding f i = Format.fprintf f "%s" i

  method affect f var expr =
    Format.fprintf f "@[<h>%a@ :=@ %a;@]" self#binding var self#expr expr

  method declaration f var t e =
    Format.fprintf f "@[<h>let %a@ =@ ref(@ %a )@ in@]"
      self#binding var
      self#expr e

  method read f t binding =
    Format.fprintf f "@[Scanf.scanf \"%a\" (fun value -> %a := value);@]"
      self#format_type t
      self#binding binding

  val mutable params = BindingSet.empty

  method print_fun f funname t li instrs =
    let ex = params in
    let () = params <- List.fold_left
      (fun acc (v, _) -> BindingSet.add v acc) params li in
    let out =
      match t with
	| Type.F Type.Void ->
	  Format.fprintf f "@[<h>%a@]@\n  @[<v 2>%a@] ()@\n@\n"
	    self#print_proto (funname, t, li)
	    self#instructions instrs
	| _ ->
	  Format.fprintf f "@[<h>%a@]@\n  @[<v 2>%a@]@\n@\n"
	    self#print_proto (funname, t, li)
	    self#instructions instrs
    in let () = params <- ex
    in out

  method expr_binding f e =
    if BindingSet.mem e params
    then
      Format.fprintf f "%a" self#binding e
    else
      Format.fprintf f "!%a" self#binding e
      
  method access_array f arr index =
    Format.fprintf f "@[<h>%a.(%a)@]"
      self#binding arr
      self#expr index


  method print f t expr = (* TODO virer les parentheses quand on peut *)
    Format.fprintf f "@[Printf.printf \"%a \" (%a);@]"
      self#format_type t
      self#expr expr

  method comment f str =
    Format.fprintf f "(*%s*)" str

  method return f e =
    Format.fprintf f "@[<h>%a;@]" self#expr e

  method allocarray f binding type_ len =
    Format.fprintf f "@[<h>let@ %a@ =@ Array.make@ %a@ (Obj.magic@ 0)@ in@]"
      self#binding binding
      self#expr len

  method affectarray f binding e1 e2 =
    Format.fprintf f "@[<h>%a.(%a)@ <-@ %a;@]"
      self#binding binding
      self#expr e1
      self#expr e2

(* Todo virer les parentheses quand on peut*)
  method call (f:Format.formatter) (var:funname) (li:Expr.t list) : unit =
    Format.fprintf
      f
      "@[<h>%a %a;@]"
	  self#funname var
	  (print_list
	     self#expr
	     (fun t f1 e1 f2 e2 ->
	       Format.fprintf t "%a@ (%a)" f1 e1 f2 e2
	     )
	  ) li

  method forloop f varname expr1 expr2 expr3 li =
    let ex = params in
    let () = params <- BindingSet.add varname params in
    let out =
      match expr3 with
	| Expr.F (_, (Expr.Integer 1)) ->
	  Format.fprintf f "@[<h>for@ %a@ =@ %a@ to@ %a - 1@\n@]do@[<v 2>@\n%a@]@\ndone;"
	    self#binding varname
	    self#expr expr1
	    self#expr expr2
 	    self#instructions li
	| _ ->
	  Format.fprintf f "@[<h>for@ %a@ =@ %a@ to@ %a - 1@ (*TODO step@ %a*) @\n@]do@[<v 2>@\n%a@]@\ndone;"
	    self#binding varname
	    self#expr expr1
	    self#expr expr2
	    self#expr expr3
 	    self#instructions li
    in let () = params <- ex
    in out

end

let printer = new camlPrinter;;
