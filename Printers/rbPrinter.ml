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


(** ruby Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)


open Stdlib
open Helper
open Ast
open Printer
open PyPrinter

class rbPrinter = object(self)
  inherit pyPrinter as super

  method lang () = "ruby"


  method char f c =
    let cs = Printf.sprintf "%C" c in
    if String.length cs == 6 then
      Format.fprintf f "\"\\u%04x\"" (int_of_char c)
    else
      Format.fprintf f "%S" (String.from_char c)

  method tuple f li = Format.fprintf f "[%a]" (print_list self#expr sep_c) li

  method header f prog = Format.fprintf f "require \"scanf.rb\"
%s"
    (if Tags.is_taged "__internal__mod" then
        "def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
" else "")

  method comment f str = Format.fprintf f "\n=begin\n%s\n=end\n" str


  method formater_type t = match Type.unfix t with
  | Type.Integer -> "%d"
  | Type.Char -> "%s"
  | Type.String ->  "%s"
  | Type.Bool -> "%b"
  | _ -> raise (Warner.Error (fun f -> Format.fprintf f "invalid type %s for format\n" (Type.type_t_to_string t)))

  method unop f op a =
    let pop g f a = match op with
      | Expr.Neg -> Format.fprintf f "-%a" g a
      | Expr.Not -> Format.fprintf f "not(%a)" self#expr a
    in if self#nop (Expr.unfix a) then pop self#expr f a
      else pop self#printp f a

  method print_proto f (funname, t, li) =
    Format.fprintf f "def %a( %a )"
      self#funname funname
      (print_list self#binding sep_c) (List.map fst li)

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>%a@]@\n@[<v 2>  %a@]@\nend@\n"
      self#print_proto (funname, t, li)
      self#bloc instrs

  method whileloop f expr li =
    Format.fprintf f "@[<h>while %a do@]@\n%a@\nend"
      self#expr expr
      self#bloc li

  method read f t mutable_ =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[%a=scanf(\"%%d\")[0]@]"
        self#mutable_set mutable_
    | Type.Char ->
      Format.fprintf f "@[%a=scanf(\"%%c\")[0]@]"
        self#mutable_set mutable_
    | _ -> assert false (* types non gérés *)

  method read_decl f t v =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[%a=scanf(\"%%d\")[0]@]"
        self#binding v
    | Type.Char ->
      Format.fprintf f "@[%a=scanf(\"%%c\")[0]@]"
        self#binding v
    | _ -> assert false (* types non gérés *)

  method stdin_sep f = Format.fprintf f "@[scanf(\"%%*\\n\")@]"

  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ =@ %a@]" self#binding var self#expr e

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
      )

  method bool f = function
  | true -> Format.fprintf f "true"
  | false -> Format.fprintf f "false"

  method selfAssoc f m e2 = function
  | Expr.Add -> Format.fprintf f "@[<h>%a += %a@]" self#mutable_set m self#expr e2
  | Expr.Sub -> Format.fprintf f "@[<h>%a -= %a@]" self#mutable_set m self#expr e2
  | Expr.Mul -> Format.fprintf f "@[<h>%a *= %a@]" self#mutable_set m self#expr e2
  | Expr.Div -> Format.fprintf f "@[<h>%a = (%a.to_f / %a).to_i@]" self#mutable_set m self#mutable_get m self#expr e2
  | Expr.Mod -> Format.fprintf f "@[<h>%a = mod(%a, %a)@]" self#mutable_set m self#mutable_get m self#expr e2
  | _ -> assert false

  method binop f op a b =
    match op with
    | Expr.Div ->
      if Typer.is_int (super#getTyperEnv ()) a
      then Format.fprintf f "(%a.to_f / %a).to_i"
        (self#chf op Left) a
        (self#chf op Right) b
      else super#sbinop f op a b
    | Expr.Mod ->
      Format.fprintf f "mod(%a, %a)"
        self#expr a
        self#expr b
    | _ -> super#sbinop f op a b

val mutable inlambda = false

  method allocarray_lambda f binding type_ len binding2 lambda _ =
    let exv = inlambda in
    inlambda <- true;
    Format.fprintf f "@[<v 2>%a = [*0..@[<h>%a@]].map { |%a|@\n%a@\n}@]"
      self#binding binding
      self#expr (Expr.binop Expr.Sub len (Expr.integer 1))
      self#binding binding2
      self#instructions lambda;
    inlambda <- exv;

  method forloop_content f (varname, expr1, expr2, li) =
    Format.fprintf f "@[<h>for@ %a@ in@ (%a .. @ %a) do@\n@]%a@\nend"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#bloc li

  method multi_print f format exprs =
    if exprs = [] then
      Format.fprintf f "@[<h>printf \"%s\"@]" format
    else
      Format.fprintf f "@[<h>printf \"%s\", %a@]" format
        (print_list self#expr sep_c) (List.map snd exprs)

  method print f t expr = match Expr.unfix expr with
  | Expr.Lief (Expr.String s) -> Format.fprintf f "@[print %s@]" ( self#noformat s )
  | _ -> Format.fprintf f "@[printf \"%a\", %a@]"
    self#format_type t
    self#expr expr

  method bloc f li = Format.fprintf f "@[<v 2>  %a@]" self#instructions li

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<h>if@ %a then@]@\n%a@\nend"
        self#expr e
        self#bloc ifcase
    | [Instr.Fixed.F (_, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>if@ %a then@]@\n%a@\nels%a"
        self#expr e
        self#bloc ifcase
        self#instr instr
    | _ ->
      Format.fprintf f "@[<h>if@ %a then@]@\n%a@\nelse@\n%a@\nend"
        self#expr e
        self#bloc ifcase
        self#bloc elsecase

  method allocarray f binding type_ len _ =
    Format.fprintf f "@[<h>%a@ =@ []@]" self#binding binding

  method return f e =
    if inlambda then Format.fprintf f "@[<h>next@ (%a)@]" self#expr e
    else Format.fprintf f "@[<h>return@ (%a)@]" self#expr e

  method field f field = Format.fprintf f "%S" field

  method allocrecord f name t el =
    Format.fprintf f "%a = {@[<v>%a@]}"
      self#binding name
      (self#def_fields name) el

  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
        Format.fprintf f "@[<h>%a => %a@]"
          self#field fieldname
          self#expr expr
      )
      (sep "%a,@\n%a") f li
end
