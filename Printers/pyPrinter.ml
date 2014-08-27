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

(** python Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Printer
open CPrinter

class pyPrinter = object(self)
  inherit cPrinter as super


  method tuple f li =
    Format.fprintf f "@[<h>(%a)@]"
      (print_list self#expr
         (fun t fa a fb b -> Format.fprintf t "%a,@ %a" fa a fb b)
      ) li

  method record f li =
    Format.fprintf f "{@\n  @[<v>%a@]}"
      (self#def_fields "") li

  method selfAssoc f m e2 = function
  | Expr.Add -> Format.fprintf f "@[<h>%a += %a@]" self#mutable_ m self#expr e2
  | Expr.Sub -> Format.fprintf f "@[<h>%a -= %a@]" self#mutable_ m self#expr e2
  | Expr.Mul -> Format.fprintf f "@[<h>%a *= %a@]" self#mutable_ m self#expr e2
  | Expr.Div -> Format.fprintf f "@[<h>%a = math.trunc(%a / %a)@]" self#mutable_ m self#mutable_ m self#expr e2
  | Expr.Mod -> Format.fprintf f "@[<h>%a = mod(%a, %a)@]" self#mutable_ m self#mutable_ m self#expr e2
  | _ -> assert false

  method lang () = "py"

  method enum f e = Format.fprintf f "\"%s\"" e

  method unop f op a = match op with
  | Expr.Neg -> Format.fprintf f "-(%a)" self#expr a
  | Expr.Not -> Format.fprintf f "not (%a)" self#expr a

  method binop f op a b =
    match op with
    | Expr.Div ->
      if Typer.is_int (super#getTyperEnv ()) a
      then Format.fprintf f "math.trunc(%a / %a)"
        (self#chf op Left) a
        (self#chf op Right) b
      else super#binop f op a b
    | Expr.Mod ->
      Format.fprintf f "mod(%a, %a)"
        self#expr a
        self#expr b
    | _ -> super#binop f op a b

  method sbinop f op a b = super#binop f op a b

  method print_op f op = Format.fprintf f "%s"
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
    | Expr.Eq -> "=="
    | Expr.Diff -> "!="
    )

  method bool f = function
  | true -> Format.fprintf f "True"
  | false -> Format.fprintf f "False"

  method read f t mutable_ =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[%a=readint()@]"
        self#mutable_ mutable_
    | Type.Char ->
      Format.fprintf f "@[%a=readchar()@]"
        self#mutable_ mutable_
    | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot print type %s"
      (Type.type_t_to_string t)
    ))

  method read_decl f t v =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[%a=readint()@]"
        self#binding v
    | Type.Char ->
      Format.fprintf f "@[%a=readchar()@]"
        self#binding v
    | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot print type %s"
      (Type.type_t_to_string t)
    ))

  method stdin_sep f = Format.fprintf f "@[stdinsep()@]"

  method main f main = self#instructions f main

  method header f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "%s%s%s%s%s%s"
      (if Tags.is_taged "__internal__div" ||
          Tags.is_taged "__internal__mod" ||
          Tags.is_taged "use_math"
       then
          "import math
" else "")
      (if need then "import sys
char=None
def readchar_():
  global char
  if char == None:
    char = sys.stdin.read(1)
  return char

def skipchar():
  global char
  char = None
  return
" else "" )
      (if need_readchar then
          "def readchar():
  out = readchar_()
  skipchar()
  return out
" else "")
      (if need_stdinsep then
          "def stdinsep():
  while True:
    c = readchar_()
    if c == '\\n' or c == '\\t' or c == '\\r' or c == ' ':
      skipchar()
    else:
      return
" else "")
      (if need_readint then
          "def readint():
  c = readchar_()
  if c == '-':
    sign = -1
    skipchar()
  else:
    sign = 1
  out = 0
  while True:
    c = readchar_()
    if c <= '9' and c >= '0' :
      out = out * 10 + int(c)
      skipchar()
    else:
      return out * sign
" else "")
      (if Tags.is_taged "__internal__mod" then
          "def mod(x, y):
  return x - y * math.trunc(x / y)
"
       else "")

  method prog f prog =
    Format.fprintf f "%a%a%a@\n"
      self#header prog
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main


  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ =@ %a;@]" self#binding var self#expr e

  method bloc f li =
    match li with
    | [] -> Format.fprintf f "@[<h>  pass@]"
    | _ -> Format.fprintf f "@[<v 2>  %a@]" self#instructions li

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<h>if@ %a:@]@\n%a"
        self#expr e
        self#bloc ifcase
    | [Instr.Fixed.F (_, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>if@ %a:@]@\n%a@\nel%a"
        self#expr e
        self#bloc ifcase
        self#instr instr
    | _ ->
      Format.fprintf f "@[<h>if@ %a:@]@\n%a@\nelse:@\n%a"
        self#expr e
        self#bloc ifcase
        self#bloc elsecase

  method comment f str = Format.fprintf f "\"\"\"%s\"\"\"" str

  method whileloop f expr li =
    Format.fprintf f "@[<h>while (%a):@]@\n%a" self#expr expr self#bloc li

  method allocarray f binding type_ len =
    Format.fprintf f "@[<h>%a@ =@ [None] * %a@]"
      self#binding binding
      (fun f a ->
        if self#nop (Expr.unfix a) then
          self#expr f a
        else self#printp f a
      ) len

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>%a@]@\n@[<v 2>  %a@]@\n"
      self#print_proto (funname, t, li)
      self#bloc instrs

  method decl_type f name t = ()

  method forloop f varname expr1 expr2 li = self#forloop_content f (varname, expr1, expr2, li)

  method forloop_content f (varname, expr1, expr2, li) =
    let default () =
      Format.fprintf f "@[<h>for@ %a@ in@ range(%a,@ 1 + %a):@\n@]%a"
        self#binding varname
        self#expr expr1
        self#expr expr2
        self#bloc li
    in match Expr.unfix expr2 with
    | Expr.BinOp (expr3, Expr.Sub, Expr.Fixed.F (_, Expr.Lief (Expr.Integer 1))) ->
      Format.fprintf f "@[<h>for@ %a@ in@ range(%a,@ %a):@\n@]%a"
        self#binding varname
        self#expr expr1
        self#expr expr3
        self#bloc li
    | _ -> default ()

  method print_proto f (funname, t, li) =
    Format.fprintf f "def %a( %a ):"
      self#funname funname
      (print_list
         (fun t (a, type_) ->
           self#binding t a)
         (fun t f1 e1 f2 e2 -> Format.fprintf t
           "%a,@ %a" f1 e1 f2 e2)) li

  method print_args =
    print_list
      (fun f (t, expr) ->
        (if self#nop (Expr.unfix expr) then
            self#expr
         else self#printp) f expr)
      (fun t f1 e1 f2 e2 -> Format.fprintf t
        "%a,@ %a" f1 e1 f2 e2)

  method multi_print f format exprs =
    if exprs = [] then
      if String.ends_with format "\n" then
        let l = String.length format in
        Format.fprintf f "@[<h>print(\"%s\")@]"  (String.sub format 0 (l - 1) )
      else Format.fprintf f "@[<h>print(\"%s\", end='')@]" format
    else
      if String.ends_with format "\n" then
        let l = String.length format in
        Format.fprintf f "@[<h>print(\"%s\" %% ( %a ))@]" (String.sub format 0 (l - 1) )
          self#print_args exprs
      else
        Format.fprintf f "@[<h>print(\"%s\" %% ( %a ), end='')@]" format self#print_args exprs

  method print f t expr =
    match Expr.unfix expr with
    | Expr.Lief (Expr.String s) ->
      if String.ends_with s "\n" then
        let l = String.length s in
        Format.fprintf f "@[print(%S)@]" (String.sub s 0 (l - 1) )
      else Format.fprintf f "@[print( %S, end='')@]" s
    | _ ->
      Format.fprintf f "@[print(\"%a\" %% %a, end='')@]" self#format_type t
        (fun f expr ->
          if self#nop (Expr.unfix expr) then
              self#expr f expr
           else self#printp f expr) expr

  method field f field = Format.fprintf f "%S" field

  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
        Format.fprintf f "@[<h>%a:%a@]"
          self#field fieldname
          self#expr expr
      )
      (fun t f1 e1 f2 e2 ->
        Format.fprintf t
          "%a,@ %a" f1 e1 f2 e2)
      f
      li

  method allocrecord f name t el =
    Format.fprintf f "%a = {%a}" self#binding name (self#def_fields name) el

  method mutable_ f m =
    match Mutable.unfix m with
    | Mutable.Dot (m, field) ->
      Format.fprintf f "%a[%a]"
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


  method multiread f instrs = self#basemultiread f instrs
end
