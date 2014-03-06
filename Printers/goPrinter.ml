
open Ast
open Stdlib
open Printer
open CPrinter

class goPrinter = object(self)
  inherit cPrinter as super

  method lang () = "go"

	method binding f s = Format.fprintf f "%s" s

  method print_fun f funname t li instrs =
    self#calc_used_variables instrs;
    Format.fprintf f "@[<h>%a@]{@\n@[<v 2>  %a@]@\n}@\n"
      self#print_proto (funname, t, li)
			self#instructions_unused instrs
			

  method prog f prog =
    Format.fprintf f
      "package main@\nimport \"fmt\"@\n%a%a"
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method main f main =
    self#calc_used_variables main;
    (if reader then
    Format.fprintf f "func main() {@\n  reader = bufio.NewReader(os.Stdin)@\n  @[<v>%a@]@\n}@\n"
    else
    Format.fprintf f "func main() {@\n@[<v>%a@]@\n}@\n")
      self#instructions main

  method declaration f var t e =
    Format.fprintf f "@[<h>var %a %a = %a@]%a"
      self#binding var self#ptype t self#expr e
      self#test_unused var

	method printf f () = Format.fprintf f "fmt.Printf"

	method test_unused f var =
	  if not (BindingSet.mem var used_variables) then
	    Format.fprintf f "@\n@[<h>_ = %a@]"
	      self#binding var

  method print_proto f (funname, t, li) =
    Format.fprintf f "func %a(%a) %a"
      self#funname funname
      (print_list
	 (fun t (binding, type_) ->
	   Format.fprintf t "%a@ %a"
	     self#binding binding
	     self#prototype type_
	 )
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	     "%a,@ %a" f1 e1 f2 e2)
      ) li
      self#ptype t

  method allocrecord f name t el =
    Format.fprintf f "var %a %a = new (%a)@\n%a"
      self#binding name
      self#ptype t
      self#ptypename t
      (self#def_fields name) el


  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
	Format.fprintf f "(*%a).%a=%a;"
	  self#binding name
	  self#field fieldname
	  self#expr expr
      )
      (fun t f1 e1 f2 e2 ->
	Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)
      f
      li

  method mutable_ f m =
    match Mutable.unfix m with
      | Mutable.Dot (m, field) ->
	Format.fprintf f "(*%a).%a"
	  self#mutable_ m
	  self#field field
      | Mutable.Var binding -> self#binding f binding
      | Mutable.Array (m, indexes) ->
	Format.fprintf f "%a[%a]"
	  self#mutable_ m
	  (print_list
	     self#expr
	     (fun f f1 e1 f2 e2 ->
	       Format.fprintf f "%a][%a" f1 e1 f2 e2
	     ))
	  indexes

  method ptype f t = match Type.unfix t with
	| Type.Array a -> Format.fprintf f "[]%a" self#ptype a
  | Type.String -> Format.fprintf f "string"
  | Type.Char -> Format.fprintf f "byte"
	| Type.Bool -> Format.fprintf f "bool"
	| Type.Void -> Format.fprintf f ""
	| Type.Named n -> Format.fprintf f "* %s" n
	| _ -> super#ptype f t

  method ptypename f t = match Type.unfix t with
	| Type.Named n -> Format.fprintf f "%s" n
	| _ -> assert false

  method bool f = function
    | true -> Format.fprintf f "true"
    | false -> Format.fprintf f "false"

  method forloop f varname expr1 expr2 li =
      Format.fprintf f "@[<h>for@ %a@ :=@ %a@ ;@ %a@ <=@ %a;@ %a++@]%a"
        self#binding varname
        self#expr expr1
        self#binding varname
        self#expr expr2
        self#binding varname
        self#bloc li

  method bloc f li = Format.fprintf f "@[<v 2>{@\n%a@]@\n}"
        self#instructions li

  method allocarray f binding type_ len =
    Format.fprintf f "@[<h>var %a@ []%a@ = make([]%a, %a)@]"
			self#binding binding
			self#ptype type_
			self#ptype type_
	    (fun f a ->
        if self#nop (Expr.unfix a) then self#expr f a
        else self#printp f a) len

  method stdin_sep f =
    Format.fprintf f "@[fmt.Scanf(\"%%*[ \\t\\r\\n]c\");@]"

  method read f t m =
    Format.fprintf f "@[fmt.Scanf(\"%a\", &%a);@]"
      self#format_type t
      self#mutable_ m

  method if_ f e ifcase elsecase =
    match elsecase with
      | [] ->
	Format.fprintf f "@[<h>if@ %a@ @]{@[<v 2>  %a@]}"
	  self#expr e
	  self#instructions ifcase
      | [Instr.Fixed.F (_, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>if@ %a@ @]{@\n@[<v 2>  %a@]@\n} else %a "
	self#expr e
	self#instructions ifcase
	self#instr instr
      | _ ->
      Format.fprintf f "@[<h>if@ %a@ @]{@\n@[<v 2>  %a@]@\n} else {@\n@[<v 2>  %a@]}"
	self#expr e
	self#instructions ifcase
	self#instructions elsecase


  method whileloop f expr li =
    Format.fprintf f "@[<h>for %a@]%a"
      self#expr expr
      self#bloc li


  method decl_type f name t =
    match (Type.unfix t) with
	Type.Struct (li, _) ->
	Format.fprintf f "@\ntype %a struct {@\n@[<v 2>  %a@]@\n}@\n"
	  self#binding name
	  (print_list
	     (fun t (name, type_) ->
	       Format.fprintf t "%a %a;" self#binding name self#ptype type_ 
	     )
	     (fun t fa a fb b -> Format.fprintf t "%a@\n%a" fa a fb b)
	  ) li
      | Type.Enum li ->
        Format.fprintf f "typedef enum %a {@\n@[<v2>  %a@]@\n} %a;"
          self#binding name
          (print_list
	           (fun t name ->
               self#binding t name
	           )
	           (fun t fa a fb b -> Format.fprintf t "%a,@\n%a" fa a fb b)
	        ) li
          self#binding name
      | _ -> Format.fprintf f "typedef %a %a;"
				self#ptype t
				self#binding name


end 

