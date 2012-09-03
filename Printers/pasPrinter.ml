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

(** Pascal Printer
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Printer

class ['lex] pasPrinter = object(self)
  inherit ['lex] printer as super

  method decl_type f name t = ()

  val mutable current_function = ""
  val mutable bindings = BindingSet.empty


  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
       | Expr.Add -> "+"
       | Expr.Sub -> "-"
       | Expr.Mul -> "*"
       | Expr.Div -> "/"
       | Expr.Mod -> "%"
       | Expr.Or -> "or"
       | Expr.And -> "and"
       | Expr.Lower -> "<"
       | Expr.LowerEq -> "<="
       | Expr.Higher -> ">"
       | Expr.HigherEq -> ">="
       | Expr.Eq -> "="
       | Expr.Diff -> "<>"
       | Expr.BinOr -> "|"
       | Expr.BinAnd -> "&"
       | Expr.RShift -> ">>"
       | Expr.LShift -> "<<"
      )

  method unop f op a =
    let pop f () = match op with
      | Expr.Neg -> Format.fprintf f "-"
      | Expr.Not -> Format.fprintf f "not "
      | Expr.BNot -> Format.fprintf f "~"
    in if self#nop (Expr.unfix a) then
        Format.fprintf f "%a%a" pop () self#expr a
      else
        Format.fprintf f "%a(%a)" pop () self#expr a


  method string f i = Format.fprintf f "'%s'" (String.escaped i) (* TODO faire mieux *)

  method whileloop f expr li =
    Format.fprintf f "@[<h>while %a@] do@\n%a;"
      self#expr expr
      self#bloc li

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for@ %a@ :=@ %a@ to @ %a do@\n@]%a;"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#bloc li


  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ :=@ %a;@]"
      self#binding var
      self#expr e

  method ptype f t =
      match Type.unfix t with
      | Type.Integer -> Format.fprintf f "integer"
      | Type.String -> Format.fprintf f "char*"
      | Type.Float -> Format.fprintf f "float"
      | Type.Array a -> Format.fprintf f "array of %a" self#ptype a
      | Type.Void ->  Format.fprintf f "void"
      | Type.Bool -> Format.fprintf f "boolean"
      | Type.Char -> Format.fprintf f "char"
      | Type.Named n -> Format.fprintf f "%s" n
      | Type.Struct (li, p) -> Format.fprintf f "a struct"


  method print_proto f (funname, t, li) =
    match Type.unfix t with
      | Type.Void ->
        Format.fprintf f "@[<h>procedure %a(%a);@]"
          self#funname funname
          (print_list
             (fun t (binding, type_) ->
               Format.fprintf t "%a : %a"
                 self#binding binding
                 self#ptype type_
             )
             (fun t f1 e1 f2 e2 -> Format.fprintf t
               "%a;@ %a" f1 e1 f2 e2)
          ) li
      | _ ->
        Format.fprintf f "@[<h>function %a(%a) : %a;@]"
          self#funname funname
          (print_list
             (fun t (binding, type_) ->
               Format.fprintf t "%a : %a"
                 self#binding binding
                 self#ptype type_
             )
             (fun t f1 e1 f2 e2 -> Format.fprintf t
               "%a;@ %a" f1 e1 f2 e2)
          ) li
          self#ptype t

  method print_body f instrs =
    Format.fprintf f "%a@\nbegin@\n@[<v 2>  %a@]@\nend"
      self#declarevars instrs
      self#instructions instrs

  method print_fun f funname t li instrs =
    let () = current_function <- funname in
    Format.fprintf f "%a%a;@\n"
      self#print_proto (funname, t, li)
      self#print_body instrs

  method if_ f e ifcase elsecase =
    match elsecase with
      | [] ->
	      Format.fprintf f "@[<h>if@ %a@]@\nthen@\n@[<v2>  %a;@]"
	        self#expr e
	        self#bloc ifcase
      | [Instr.Fixed.F (_, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>if@ %a@] then@\n@[<v 2>  %a@]@\nelse %a;"
	      self#expr e
	      self#bloc ifcase
	      self#instr instr
      | _ ->
	Format.fprintf f "@[<h>if@ %a@]@\nthen@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a;@]"
	  self#expr e
	  self#bloc ifcase
	  self#bloc elsecase


  method declarevars f instrs =
    let bindings = self#declaredvars BindingMap.empty instrs
    in
    if bindings = BindingMap.empty then ()
    else
      Format.fprintf f "@\n@[<v 2>var%a@]"
        (BindingMap.fold
           (fun key value next f () ->
             Format.fprintf f "%a@\n%a : %a;"
               next ()
               self#binding key
               self#ptype value
           )
           bindings
           (fun f () -> ())
        )
        ()

  method declaredvars bindings instrs =
    List.fold_left
      (Instr.Writer.Deep.fold
         (fun bindings i ->
           match Instr.Fixed.unfix i with
             | Instr.Loop (b, _, _, _) ->
               BindingMap.add b Type.integer bindings
             | Instr.Declare (b, t, _) ->
               BindingMap.add b t bindings
             | Instr.AllocArray (b, t, _, _) ->
               BindingMap.add b (Type.array t) bindings
             | Instr.AllocRecord (b, t, _) ->
               BindingMap.add b t bindings
             | _ -> bindings
         )
      )
      bindings
      instrs


  method allocrecord f name t el =
    Format.fprintf f "new(%a);@\n%a"
      self#binding name
      (self#def_fields name) el


  method mutable_ f m =
    match Mutable.unfix m with
      | Mutable.Dot (m, field) ->
	Format.fprintf f "%a^.%a"
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


  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
	Format.fprintf f "%a^.%a := %a;"
	  self#binding name
	  self#field fieldname
	  self#expr expr
      )
      (fun t f1 e1 f2 e2 ->
	Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)
      f
      li

  method stdin_sep f = () (* TODO *)

  method read f t m = (* TODO *)
    Format.fprintf f "@[<h>Read(%a);@]"
      self#mutable_ m

  method print f t expr =
    Format.fprintf f "@[<h>Write(%a);@]" self#expr expr

  method allocarray f binding type_ len =
      Format.fprintf f "@[<h>SetLength(%a, %a);@]"
        self#binding binding
        self#expr len

  method prog f prog =
    Format.fprintf f "program %s;@\n%a%a.@\n@\n"
      prog.Prog.progname
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main


  method main f main =
    self#print_body f main

  method affect f mutable_ (expr : 'lex Expr.t) =
    Format.fprintf f "@[<h>%a@ :=@ %a;@]" self#mutable_ mutable_ self#expr expr


  method bloc f li = Format.fprintf f "@[<v 2>begin@\n%a@]@\nend"
      (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)) li

  method return f e =
    Format.fprintf f "@[<h>%a@ :=@ %a;@]"
      self#binding current_function
      self#expr e

  method print f t expr =
    Format.fprintf f "@[<h>write(%a);@]" self#expr expr


  method decl_type f name t =
    match (Type.unfix t) with
        Type.Struct (li, _) ->
          Format.fprintf f "type %a_r = record@\n@[<v 2>  %a@]@\nend;@\ntype %a=^%a_r;@\n"
            self#binding name
            (print_list
               (fun t (name, type_) ->
                 Format.fprintf t "%a : %a;" self#binding name self#ptype type_
               )
               (fun t fa a fb b -> Format.fprintf t "%a@\n%a" fa a fb b)
            ) li
    super#binding name
    super#binding name
      | _ ->
        Format.fprintf f "type %a = %a;"
    super#ptype t
    super#binding name


end
