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
open Helper
open Ast

let prio_percent_percent = 0

let print_lief prio f l =
  let open Format in
  let open Expr in
  match l with
    | Char c -> unicode f c
    | Enum e -> fprintf f "%S" e
    | Bool true -> fprintf f "True"
    | Bool false -> fprintf f "False"
    | x -> print_lief prio f x

let print_expr macros e f p =
  let open Format in
  let open Expr in
  let prio_binop op = match op with
  | Mul -> assoc 5
  | Div
  | Mod -> nonassocr 7
  | Add -> assoc 9
  | Sub -> nonassocr 9
  | Lower
  | LowerEq
  | Higher
  | HigherEq
  | Eq
  | Diff -> nonassocl 13
  | And -> assoc 15
  | Or -> assoc 15 in
  let print_expr0 config e f prio_parent = match e with
  | BinOp (a, (Div as op), b) ->
      let _, priol, prior = prio_binop op in
      fprintf f "math.trunc(%a %a %a)" a priol print_op op b prior
  | BinOp (a, Mod, b) -> fprintf f "mod(%a, %a)" a nop b nop
  | Tuple li -> fprintf f "[%a]" (print_list (fun f x -> x f nop) sep_c) li
  | _ -> print_expr0 config e f prio_parent
  in
  let print_op f op =
    fprintf f (match op with
    | Add -> "+"
    | Sub -> "-"
    | Mul -> "*"
    | Div -> "/"
    | Mod -> "%%"
    | Or -> "or"
    | And -> "and"
    | Lower -> "<"
    | LowerEq -> "<="
    | Higher -> ">"
    | HigherEq -> ">="
    | Eq -> "=="
    | Diff -> "!=") in
  let print_unop f op =
    let open Ast.Expr in
    Format.fprintf f (match op with
    | Neg -> "-"
    | Not -> "not ") in
  let config = {
    prio_binop;
    prio_unop;
    print_varname;
    print_lief;
    print_op;
    print_unop;
    print_mut;
    macros
  } in Fixed.Deep.fold (print_expr0 config) e f p

class pyPrinter = object(self)
  inherit CPrinter.cPrinter as super

  method exprp p f e = print_expr
      (StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros) e f p

  method multi_read f li = self#base_multi_read f li

  method expr f e = self#exprp nop f e

  method declare_for s f li = ()
  method separator f () = ()

  method selfAssoc f m e2 = function
  | Expr.Add -> Format.fprintf f "@[<h>%a += %a@]" self#mutable_set m self#expr e2
  | Expr.Sub -> Format.fprintf f "@[<h>%a -= %a@]" self#mutable_set m self#expr e2
  | Expr.Mul -> Format.fprintf f "@[<h>%a *= %a@]" self#mutable_set m self#expr e2
  | Expr.Div -> Format.fprintf f "@[<h>%a = math.trunc(%a / %a)@]" self#mutable_set m self#mutable_get m self#expr e2
  | Expr.Mod -> Format.fprintf f "@[<h>%a = mod(%a, %a)@]" self#mutable_set m self#mutable_get m self#expr e2
  | _ -> assert false

  method lang () = "py"

  method allocarrayconst f binding t len e opt =
    Format.fprintf f "@[<h>%a@ = [%a] * %a@]"
      self#binding binding
      (print_lief nop) e
      (fun f e -> self#exprp (prio_right (prio_binop Ast.Expr.Mul)) f e)
      len

  method read f t mutable_ =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[%a = readint()@]"
        self#mutable_set mutable_
    | Type.Char ->
      Format.fprintf f "@[%a = readchar()@]"
        self#mutable_set mutable_
    | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot print type %s"
      (Type.type_t_to_string t)
    ))

  method read_decl f t v =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[%a = readint()@]"
        self#binding v
    | Type.Char ->
      Format.fprintf f "@[%a = readchar()@]"
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
char_ = None

def readchar_():
    global char_
    if char_ == None:
        char_ = sys.stdin.read(1)
    return char_

def skipchar():
    global char_
    char_ = None
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
    Format.fprintf f "@[<h>%a@ =@ %a@]" self#binding var self#expr e

  method bloc f li =
    match li with
    | [] -> Format.fprintf f "@[<h>    pass@]"
    | _ -> Format.fprintf f "@[<v 4>    %a@]" self#instructions li

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

  method comment f str =
    let trimmed = String.trim str in
      if not (String.starts_with trimmed "\"" || String.ends_with trimmed "\"") then
        Format.fprintf f "\"\"\"%s\"\"\"" trimmed
      else if not (String.starts_with trimmed "'" || String.ends_with trimmed "'") then
        Format.fprintf f "'''%s'''" trimmed
      else
        Format.fprintf f "\"\"\"@\n%s@\n\"\"\"" trimmed

  method whileloop f expr li =
    Format.fprintf f "@[<h>while (%a):@]@\n%a" self#expr expr self#bloc li

  method allocarray f binding type_ len _ =
    Format.fprintf f "@[<h>%a@ =@ [None] * %a@]"
      self#binding binding
      (fun f a -> self#exprp (prio_right (prio_binop Ast.Expr.Mul)) f a) len

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>%a@]@\n@[<v 4>%a@]@\n"
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
    Format.fprintf f "def %a(%a):"
      self#funname funname
      (print_list self#binding sep_c) (List.map fst li)

  method print_args =
    print_list
      (fun f (t, expr) ->
        (self#expr) f expr)
      sep_c

  method multi_print f li =
    let format, exprs = self#extract_multi_print li in
      if String.ends_with format "\n" then
        let l = String.length format in
        Format.fprintf f "@[<h>print(\"%s\" %% (%a))@]" (String.sub format 0 (l - 1) )
          self#print_args exprs
      else
        Format.fprintf f "@[<h>print(\"%s\" %% (%a), end='')@]" format self#print_args exprs

  method print f t expr =
    match Expr.unfix expr with
    | Expr.Lief (Expr.String s) ->
      if String.ends_with s "\n" then
        let l = String.length s in
        Format.fprintf f "@[print(%S)@]" (String.sub s 0 (l - 1) )
      else Format.fprintf f "@[print(%S, end='')@]" s
    | _ ->
      Format.fprintf f "@[print(\"%a\" %% %a, end='')@]" self#format_type t
        (fun f expr -> self#exprp prio_percent_percent f expr) expr

  method field f field = Format.fprintf f "%S" field

  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
        Format.fprintf f "@[<h>%a:%a@]"
          self#field fieldname
          self#expr expr
      ) sep_cnl f li

  method allocrecord f name t el =
    Format.fprintf f "%a = {%a}" self#binding name (self#def_fields name) el

  method m_field f m field = Format.fprintf f "%a[%a]" self#mutable_get m self#field field
end
