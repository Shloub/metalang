(*
* Copyright (c) 2012, Prologin
* All rights reserved.
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*
* THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

(** Ocaml Printer
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Printer

let contains_return li =
  List.exists (Instr.Writer.Deep.fold (fun acc i -> match Instr.unfix i with
    | Instr.Return _ -> true
    | _ -> acc) false) li

let rec contains_sad_return instrs =
  let rec f tra acc i = match Instr.unfix i with
    | Instr.Loop(_, _, _, li) -> acc || ( contains_return li)
    | Instr.While (_, li) -> acc || (contains_return li)
    | Instr.If (_, li1, li2) ->
      acc ||
	(contains_sad_return li1) || (contains_sad_return li2) ||
	(( contains_return li1) && not( contains_return li2)) ||
	(( contains_return li2) && not( contains_return li1))
    | _ -> tra acc i
  in List.fold_left (f (Instr.Writer.Traverse.fold f)) false instrs

(*
TODO ajouter des conversions de types pour les entiers / float
virer plus de refs
virer plus de nopending : inliner un peu
*)
class ['lex] camlPrinter = object(self)
  inherit ['lex] printer as super

  val mutable refbindings = BindingSet.empty
  val mutable sad_returns = false
  val mutable printed_exn = 0
  val mutable in_expr = false

  method lang () = "ml"


  method ptype f t =
      match Type.Fixed.unfix t with
      | Type.Integer -> Format.fprintf f "int"
      | Type.String -> Format.fprintf f "string"
      | Type.Float -> Format.fprintf f "float"
      | Type.Array a -> Format.fprintf f "%a array" self#ptype a
      | Type.Void ->  Format.fprintf f "void"
      | Type.Bool -> Format.fprintf f "bool"
      | Type.Char -> Format.fprintf f "char"
      | Type.Named n -> Format.fprintf f "%s" n
      | Type.Struct (li, p) ->
	Format.fprintf f "record{%a}"
	  (print_list
	     (fun t (name, type_) ->
	       Format.fprintf t "%a : %a;" self#binding name self#ptype type_
	     )
	     (fun t fa a fb b -> Format.fprintf t "%a%a" fa a fb b)
	  ) li

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
    let pop f () = match op with
      | Expr.Neg -> Format.fprintf f "-"
      | Expr.Not -> Format.fprintf f "not "
      | Expr.BNot -> Format.fprintf f "lnot "
    in if self#nop (Expr.unfix a) then
        Format.fprintf f "%a%a" pop () self#expr a
      else
        Format.fprintf f "%a(%a)" pop () self#expr a

  method length f tab =
    Format.fprintf f "(Array.length %a)" self#mutable_ tab

  method main f main =
    let () = sad_returns <- contains_sad_return main in
    let () = self#calc_refs main in
    Format.fprintf f "@[<v 2>@[<h>let () =@\nbegin@\n@[<v 2>  %a@]@\nend@\n"
      self#instructions main

  method prog f prog =
    Format.fprintf f "%a%a"
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

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

  method if_ f e ifcase elsecase =
    match elsecase with
      | [] ->
	Format.fprintf f "@[<h>if@ %a@ then@]@\n@[<v 2>  %a@]"
	  self#expr e
	  self#bloc ifcase
      | [Instr.Fixed.F (_, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>if@ %a@ then@]@\n@[<v 2>  %a@]@\nelse %a"
	self#expr e
	self#bloc ifcase
	self#instr instr
      | _ ->
      Format.fprintf f "@[<h>if@ %a@ then@]@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a@]"
	self#expr e
	self#bloc ifcase
	self#bloc elsecase

  method instructions f instrs =
    Format.fprintf f "%a%s"
      (print_list
	 self#instr
	 (fun t print1 item1 print2 item2 ->
	   Format.fprintf t "%a@\n%a"
	     (fun t i ->
	       match Instr.unfix i with
		 | Instr.AllocRecord _ -> self#instr f i (* letin -> pas de ; *)
		 | Instr.AllocArray _ -> self#instr f i (* letin -> pas de ; *)
		 | Instr.Declare _ -> self#instr f i (* letin -> pas de ; *)
		 | Instr.DeclRead _ -> self#instr f i
		 | Instr.Comment _ -> self#instr f i
		 | Instr.Return _ -> self#instr f i
		 | _ ->
		   if (* Si on a que des commentaires ensuite, alors on ne met pas de ; *)
		     (List.for_all
			(function
			  | (Instr.Fixed.F (_, Instr.Comment _) ) -> true
			  | _ -> false
			)
			item2
		     )
		   then
		       self#instr f i
		   else
		     Format.fprintf f "%a;" self#instr i
	     )
	     item1 print2 item2
	 )
      ) instrs
      (self#need_unit instrs)

  method need_unit instrs =
    match List.rev
      (List.filter
	 (function
	   | (Instr.Fixed.F (_, Instr.Comment _) ) -> false
	   | _ -> true
	 )
	 instrs
      )
    with
      | (Instr.Fixed.F (_, Instr.AllocArray _) ) :: _
      | (Instr.Fixed.F (_, Instr.Declare _) ) :: _
      | (Instr.Fixed.F (_, Instr.DeclRead _)) :: _
      | [] -> " ()"
      | _ -> ""

  method bloc f b =
    if List.forall
      (function
	      | Instr.Fixed.F (_, Instr.Comment _) -> true
	| _ -> false
      )
      b
    then
	Format.fprintf f "begin@\n@[<v 2>  %a@]@\nend" self#instructions b
    else
      match b with
	| [i] ->
	  Format.fprintf f "@[<h>%a%s@]" self#instr i
	    (self#need_unit b)
	| _ ->
	  Format.fprintf f "begin@\n@[<v 2>  %a@]@\nend" self#instructions b

  method binding f i = Format.fprintf f "%s" i

  method affect f m expr =
    Format.fprintf f "@[<h>%a@ %s@ %a@]"
      self#mutable_ m
      (match m |> Mutable.Fixed.unfix with
	| Mutable.Var _ -> ":="
	| Mutable.Array _ -> "<-"
	| Mutable.Dot _ -> "<-"
      )
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
      (match m |> Mutable.Fixed.unfix with
	| Mutable.Var _ -> ":="
	| Mutable.Array _ -> "<-"
	| Mutable.Dot _ -> "<-"
      )


  method read_decl f t v =
    Format.fprintf f "@[let %a = Scanf.scanf \"%a\" (fun x -> x) in@]"
      self#binding v
      self#format_type t


  method calc_refs instrs =
    refbindings <-
      List.fold_left
      (Instr.Writer.Deep.fold
	 (fun acc i ->
	   match Instr.unfix i with
	     | Instr.Read (_, Mutable.Fixed.F (_, Mutable.Var varname)) -> BindingSet.add varname acc
	     | Instr.Affect (Mutable.Fixed.F (_, Mutable.Var varname), _) -> BindingSet.add varname acc
	     | _ -> acc
	 ))
      BindingSet.empty
      instrs

  method expr f e =
    begin
      in_expr <- true;
      super#expr f e;
      in_expr <- false;
    end

  method mutable_ f m =
    match m |> Mutable.Fixed.unfix with
      | Mutable.Var binding ->
	  if in_expr && BindingSet.mem binding refbindings
	then
	  Format.fprintf f "(!%a)" self#binding binding
	else
	self#binding f binding
      | _ -> self#mutable_rec f m

  method mutable_rec f m =
    match m |> Mutable.unfix with
      | Mutable.Var binding ->
	if BindingSet.mem binding refbindings
	then
	  Format.fprintf f "(!%a)" self#binding binding
	else
	self#binding f binding
      | Mutable.Dot (mutable_, field) ->
	Format.fprintf f "@[<h>%a.%a@]"
	  self#mutable_rec mutable_
	  self#field field
      | Mutable.Array (mut, indexes) ->
	Format.fprintf f "@[<h>%a.(%a)@]"
	  self#mutable_rec mut
	  (print_list
	     self#expr
	     (fun f f1 e1 f2 e2 ->
	       Format.fprintf f "%a).(%a"
		 f1 e1
		 f2 e2
	     )) indexes

  method is_rec funname instrs =
    true (* TODO *)

  method print_fun f funname t li instrs =
    let () = self#calc_refs instrs in
    let is_rec = self#is_rec funname instrs in
    let proto = if is_rec then self#print_rec_proto else self#print_proto in
    let () = sad_returns <- contains_sad_return instrs in
    match t with
      | Type.Fixed.F (_, Type.Void) ->
	if sad_returns then failwith("return in a void function : "^funname)
	else
	  Format.fprintf f "@[<h>%a@]@\n@[<v 2>  %a%a@]@\n@\n"
	    proto (funname, t, li)
	    self#ref_alias li
	    self#instructions instrs
      | _ ->
	if not(sad_returns) then
	  Format.fprintf f "@[<h>%a@]@\n@[<v 2>  %a%a@]@\n@\n"
	    proto (funname, t, li)
	    self#ref_alias li
	    self#instructions instrs
	else
	  let () =
	    Warner.warn funname (fun t () -> Format.fprintf t "The returns will make a dirty ocaml code")
	  in
	  let () = printed_exn <- printed_exn + 1 in
	  Format.fprintf f "exception Found_%d of %a;;@\n@[<h>%a@]@\n@[<v 2>  %atry@\n%a@\nwith Found_%d(out) -> out@]@\n@\n"
	    printed_exn
	    self#ptype t
	    proto (funname, t, li)
	    self#ref_alias li
      self#instructions instrs
	    printed_exn

  method ref_alias f li = match li with
    | [] -> ()
    | (name, _) :: tl ->
      let b = BindingSet.mem name refbindings in
      if b then
        Format.fprintf f "let %a = ref %a in@\n%a"
          self#binding name
          self#binding name
          self#ref_alias tl
      else
        self#ref_alias f tl

  method expr_binding f e =
    if BindingSet.mem e refbindings
    then
      Format.fprintf f "!%a" self#binding e
    else
      Format.fprintf f "%a" self#binding e

  method print f t expr = (* TODO virer les parentheses quand on peut *)
    Format.fprintf f "@[Printf.printf \"%a\" (%a)@]"
      self#format_type t
      self#expr expr

  method comment f str =
    Format.fprintf f "(*%s*)" str

  method return f e =
    if sad_returns then
      Format.fprintf f "@[<h>raise (Found_%d(%a))@]" printed_exn self#expr e
    else
      Format.fprintf f "@[<h>%a@]" self#expr e

  method allocarray_lambda f binding type_ len binding2 lambda =
    let b = BindingSet.mem binding refbindings in
      Format.fprintf f "@[<h>let %a@ =@ %aArray.init@ (%a)@ (fun@ %a@ ->@\n@[<v 2>  %a@])%a@ in@]"
	self#binding binding
	(fun t () ->
	  if b then
	    Format.fprintf t "ref(@ "
	) ()
	self#expr len
	self#binding binding2
	self#instructions lambda
      (fun t () ->
	if b then
	  Format.fprintf t ")"
      ) ()

  method allocarray f binding type_ len =
    let b = BindingSet.mem binding refbindings in
    Format.fprintf f "@[<h>let@ %a@ %a=@ Array.make@ %a@ (Obj.magic@ 0)%a@ in@]"
      self#binding binding
      (fun t () ->
	  if b then
	    Format.fprintf t "ref(@ "
	) ()
      self#expr len
      (fun t () ->
	if b then
	  Format.fprintf t ")"
      ) ()

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
    | Expr.Access _ -> true
    | Expr.Call (_, _) -> false
    | _ -> false

(* Todo virer les parentheses quand on peut*)
  method apply f var li =
    match BindingMap.find_opt var macros with
      | Some ( (t, params, code) ) ->
	self#expand_macro_call f var t params code li
      | None ->
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

  method call f var li =
    self#apply f var li


  method whileloop f expr li =
    Format.fprintf f "@[<h>while %a@]@\ndo@[<v 2>@\n%a@]@\ndone"
      self#expr expr
      self#instructions li

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for@ %a@ =@ %a@ to@ %a@\n@]do@\n@[<v 2>  %a@]@\ndone"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#instructions li


  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
	Format.fprintf f "@[<h>%a=%a;@]"
	  self#field fieldname
	  self#expr expr
      )
      (fun t f1 e1 f2 e2 ->
	Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)
      f
      li

  method allocrecord f name t el =
    let b = BindingSet.mem name refbindings in
    Format.fprintf f "let %a = %a{@\n@[<v 2>  %a@]@\n}%a in"
      self#binding name
      (fun t () ->
	  if b then
	    Format.fprintf t "ref(@ "
	) ()
      (self#def_fields name) el
      (fun t () ->
	if b then
	  Format.fprintf t ")"
      ) ()

  method decl_type f name t =
    match (Type.unfix t) with
	Type.Struct (li, _) ->
	Format.fprintf f "type %a = {@\n@[<v 2>  %a@]@\n};;@\n"
	  self#binding name
	  (print_list
	     (fun t (name, type_) ->
	       Format.fprintf t "@[<h>mutable %a : %a;@]"
		 self#binding name
		 self#ptype type_
	     )
	     (fun t fa a fb b -> Format.fprintf t "%a@\n%a" fa a fb b)
	  ) li
      | _ ->
	Format.fprintf f "type %a = %a;;"
	  super#binding name
	  super#ptype t

end
