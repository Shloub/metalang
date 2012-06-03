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
* @see http://prologin.org
* @author Prologin <info@prologin.org>
* @author Maxime Audouin <coucou747@gmail.com>
*
*)

(*
TODO console
*)
open Stdlib
open Ast
open Printer
open CPrinter

let header =
"
import sys

char=None

def readchar_():
  global char;
  if char == None:
    char = sys.stdin.read(1);
  return char;

def skipchar():
  global char;
  char = None;
  return;

def readchar():
  out = readchar_();
  skipchar();
  return out;

def stdinsep():
  while True:
    c = readchar_();
    if c == '\\n' or c == '\\t' or c == '\\r' or c == ' ':
      skipchar();
    else:
      return;

def readint():
  out = 0;
  while True:
    c = readchar_();
    if c <= '9' and c >= '0' :
      out = out * 10 + int(c);
      skipchar();
    else:
      return out;
"

class pyPrinter = object(self)
  inherit cPrinter as super

  method lang () = "py"

  method unop f op a =
    match op with
      | Expr.Neg -> Format.fprintf f "-(%a)" self#expr a
      | Expr.Not -> Format.fprintf f "not (%a)" self#expr a
      | Expr.BNot -> Format.fprintf f "~(%a)" self#expr a

  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
	| Expr.Add -> "+"
	| Expr.Sub -> "-"
	| Expr.Mul -> "*"
	| Expr.Div -> "//"
	| Expr.Mod -> "%"
	| Expr.Or -> "or"
	| Expr.And -> "and"
	| Expr.Lower -> "<"
	| Expr.LowerEq -> "<="
	| Expr.Higher -> ">"
	| Expr.HigherEq -> ">="
	| Expr.Eq -> "=="
	| Expr.Diff -> "!="
	| Expr.BinOr -> "lor"
	| Expr.BinAnd -> "land"
	| Expr.RShift -> "lsl"
	| Expr.LShift -> "lsr"
      )

  method bool f = function
    | true -> Format.fprintf f "True"
    | false -> Format.fprintf f "False"

  method read f t mutable_ =
match Type.unfix t with
  | Type.Integer ->
    Format.fprintf f "@[%a=readint();@]"
      self#mutable_ mutable_
  | Type.Char ->
    Format.fprintf f "@[%a=readchar();@]"
      self#mutable_ mutable_


  method stdin_sep f =
    Format.fprintf f "@[stdinsep();@]"



  method main f main =
   self#instructions f main

  method header f () =
    Format.fprintf f "%s" header

  method prog f prog =
    Format.fprintf f "%a%a%a@\n"
      self#header ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main


  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ =@ %a;@]"
      self#binding var
      self#expr e

  method bloc f li =
    match li with
      | [] -> Format.fprintf f "@[<h>  pass;@]"
      | _ ->
	Format.fprintf f "@[<v 2>  %a@]" self#instructions li


  method if_ f e ifcase elsecase =
    match elsecase with
      | [] ->
	Format.fprintf f "@[<h>if@ %a:@]@\n%a"
	  self#expr e
	  self#bloc ifcase

      | [Instr.F ( Instr.If (condition, instrs1, instrs2) ) as instr] ->
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
    Format.fprintf f "\"\"\"%s\"\"\"" str


  method whileloop f expr li =
    Format.fprintf f "@[<h>while (%a):@]@\n%a"
      self#expr expr
      self#bloc li

  method allocarray f binding type_ len =
      Format.fprintf f "@[<h>%a@ =@ [None] * (%a);@]"
	self#binding binding
	self#expr len

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>%a@]@\n@[<v 2>  %a@]@\n"
      self#print_proto (funname, t, li)
      self#bloc instrs

  method decl_type f name t = ()

  method forloop f varname expr1 expr2 li =
      self#forloop_content f (varname, expr1, expr2, li)

 method forloop_content f (varname, expr1, expr2, li) =
    Format.fprintf f "@[<h>for@ %a@ in@ range(%a,@ 1 + %a):@\n@]%a"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#bloc li

   method print_proto f (funname, t, li) =
    Format.fprintf f "def %a( %a ):"
      self#funname funname
      (print_list
	 (fun t (a, type_) ->
	     self#binding t a)
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a,@ %a" f1 e1 f2 e2)) li


  method print f t expr =
    Format.fprintf f "@[print(\"%a\" %% %a, end='');@]" self#format_type t self#expr expr

  method field f field =
    Format.fprintf f "%S" field

  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
	Format.fprintf f "@[<h>%a:%a@]"
	  self#field fieldname
	  self#expr expr
      )
      (fun t f1 e1 f2 e2 ->
	Format.fprintf t
	  "%a, %a" f1 e1 f2 e2)
      f
      li

  method length f tab =
    Format.fprintf f "%a.__len__()" self#binding tab

  method allocrecord f name t el =
    Format.fprintf f "%a = {%a};@\n"
      self#binding name
      (self#def_fields name) el


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


end

let printer = new pyPrinter;;
