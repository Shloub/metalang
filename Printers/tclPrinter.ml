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
 *
 *)

(** Tcl Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ast
open Stdlib
open Helper
open Printer

class tclPrinter = object(self)
  inherit printer as base

  method lang () = "tcl"

  method print f t expr = Format.fprintf f "@[puts -nonewline %a@]" self#exprbloc expr

  method main f main = self#instructions f main

  method bool f b = Format.fprintf f (if b then "1" else "0")

  method comment f s =
    let lic = String.split s '\n' in
    Format.fprintf f "@\n%a"
      (print_list (fun f s -> Format.fprintf f "#%s@\n" s) nosep)
      lic

  method print_proto f (funname, t, li) = 
    Format.fprintf f "proc@ %a { %a } {"
      self#funname funname
      (print_list self#binding sep_space) (List.map fst li)

  method print_upvars f (b1, b2) = Format.fprintf f "upvar $%a %a@\n" self#binding b2 self#binding b1

  method print_fun f funname t li instrs =
    let liup, li = List.fold_left_map (fun acc (v, t) ->
      match Type.unfix t with
      | Type.Integer | Type.Char | Type.String | Type.Bool -> acc, (v, t)
      | _ -> let v2 = UserName (Fresh.fresh_user ()) in (v, v2) :: acc, (v2, t)
                                      ) [] li
    in Format.fprintf f "@[<hov>%a@]@\n@[<v 2>  %a%a@]@\n}@\n"
      self#print_proto (funname, t, li)
      (print_list self#print_upvars nosep) liup
      self#instructions instrs

  method exprbloc f e = match Expr.unfix e with
  | Expr.Call _
  | Expr.Lief _ -> self#expr f e
  | _ -> Format.fprintf f "[expr %a]" self#expr e

  method affect f mutable_ (expr : 'lex Expr.t) =
    Format.fprintf f "@[<hov>set %a %a@]" self#mutable_set mutable_ self#exprbloc expr
  method declaration f var t e =
    Format.fprintf f "@[<hov>set %a %a@]" self#binding var self#exprbloc e

  method m_variable_get f v =
    Format.fprintf f "$%a" self#binding v

  method mutable_get f m = 
    match Mutable.unfix m with
    | Mutable.Dot (m, field) -> self#m_field_get f m field
    | Mutable.Var binding ->
        begin match Type.unfix (Typer.get_type_a (self#getTyperEnv ()) (Mutable.Fixed.annot m)) with
        | Type.Array _ -> self#m_variable_set f binding
        | _ -> self#m_variable_get f binding
        end
    | Mutable.Array (m, indexes) -> self#m_array_get f m indexes

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<v2>@[<h>if { %a } {@]@\n%a@]@\n}"
        self#expr e
        self#instructions ifcase
    | _ ->
      Format.fprintf f "@[<v2>@[<h>if { %a } {@]@\n%a@]@\n@[<v 2>} {@\n%a@]@\n}"
        self#expr e
        self#instructions ifcase
        self#instructions elsecase

  method whileloop f expr li =
    Format.fprintf f "@[<v 2>@[<h>while { %a } {@]@\n%a@]@\n}"
      self#expr expr
      self#bloc li

  method apply f var li = 
    match StringMap.find_opt var macros with
    | Some ( (t, params, code) ) ->
      self#expand_macro_call f var t params code li
    | None ->
      Format.fprintf
        f
        "@[<hov>[%a %a]@]"
        self#funname var
        (print_list self#expr sep_space) li

  method hasSelfAffect _ = false

  method call f var li = 
    match StringMap.find_opt var macros with
    | Some ( (t, params, code) ) ->
      self#expand_macro_call f var t params code li
    | None ->
      Format.fprintf
        f
        "@[<hov>%a %a@]"
        self#funname var
        (print_list self#exprbloc sep_space) li

  method allocarray f binding type_ len useless =
    Format.fprintf f "@[<hov>array set %a {}@]"
      self#binding binding

  method m_array_set f m indexes = Format.fprintf f "%a(%a)" self#mutable_set m (print_list self#exprbloc (sep "%a)(%a")) indexes
  method m_array_get f m indexes = Format.fprintf f "%a(%a)" self#mutable_get m (print_list self#exprbloc (sep "%a)(%a")) indexes

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<v 2>@[<h>for {set %a %a} {$%a <= %a} {incr %a} {@]@\n%a@]@\n}"
      self#binding varname
      self#expr expr1
      self#binding varname
      self#expr expr2
      self#binding varname
      self#bloc li

  method bloc f li = print_list self#instr sep_nl f li

end
