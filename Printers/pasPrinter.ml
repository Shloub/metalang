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

class ['lex] pasPrinter = object(self)
  inherit ['lex] printer as super

  method decl_type f name t = ()

  val mutable current_function = ""
  val mutable bindings = BindingSet.empty

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
      | Type.Bool -> Format.fprintf f "bool"
      | Type.Char -> Format.fprintf f "char"
      | Type.Named n -> Format.fprintf f "struct %s *" n
      | Type.Struct (li, p) -> Format.fprintf f "a struct"


  method print_proto f (funname, t, li) =
    Format.fprintf f "function %a(%a) : %a;"
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
    Format.fprintf f "@[<v 2>var@\n%a@]@\nbegin@\n@[<v 2>  %a@]@\nend"
      self#declarevars instrs
      self#instructions instrs

  method print_fun f funname t li instrs =
    let () = current_function <- funname in
    Format.fprintf f "@[<h>%a@]@\n%a;@\n"
      self#print_proto (funname, t, li)
      self#print_body instrs

  method declarevars f instrs =
    List.fold_left
      (Instr.Writer.Deep.fold
         (fun bindings i ->
           match Instr.Fixed.unfix i with
             | Instr.Loop (b, _, _, _) ->
               if BindingSet.mem b bindings
               then ()
               else Format.fprintf f "%a : integer;@\n" self#binding b;
               BindingSet.add b bindings
             | Instr.Declare (b, t, _) ->
               if BindingSet.mem b bindings
               then ()
               else Format.fprintf f "%a : %a;@\n"
                 self#binding b
                 self#ptype t;
               BindingSet.add b bindings
             | _ -> bindings
         )
      )
      BindingSet.empty
      instrs |> ignore

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
    Format.fprintf f "@[write(%a);@]" self#expr expr

end
