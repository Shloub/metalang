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


(** Visual Basic .NET Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast
open Printer
open CsharpPrinter


class vbDotNetPrinter = object(self)
  inherit csharpPrinter as super

  method combine_formats () = false

  method lang () = "vb"

  method read_decl f t v =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[<h>Dim %a As %a = readInt()%a@]"
        self#binding v
        self#ptype t
	self#separator ()
    | Type.Char -> Format.fprintf f "@[<h>Dim %a As %a = readChar()%a@]"
        self#binding v
        self#ptype t
      self#separator ()
    | _ -> raise (Warner.Error (fun f -> Format.fprintf f "invalid type %s for format\n" (Type.type_t_to_string t)))

  method char f c =
    if (c >= 'A' && c <= 'Z' ) ||
      (c >= 'a' && c <= 'z' ) ||
      (c >= '0' && c <= '9' ) ||
      (c = '-' || c = '_' )
    then Format.fprintf f "\"%c\"C" c
    else Format.fprintf f "Chr(%d)" (int_of_char c)

  method declaration f var t e =
    Format.fprintf f "@[<hov>Dim %a@ As %a@ =@ %a@]"
      self#binding var
      self#ptype t
      self#expr e


  method string f s = self#string_noprintable false f s

  method prog f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f
      "Imports System@\n%a@\nModule %s@\n@[<v 2>%s%s%s%s@\n%a@\n%a@]@\nEnd Module@\n"
      (fun f () ->
        if Tags.is_taged "use_readline"
        then Format.fprintf f "Imports System.Collections.Generic@\n"
      ) ()
      prog.Prog.progname
      (if need then "
Dim eof As Boolean
Dim buffer As String
Function readChar_() As Char
  If buffer Is Nothing Then
    buffer = Console.ReadLine()
  End If
  If buffer.Length = 0 Then
    Dim tmp As String = Console.ReadLine()
    eof = (tmp Is Nothing)
    buffer = Chr(10)+tmp
  End If
  Return buffer(0)
End Function

Sub consommeChar()
  readChar_()
  buffer = buffer.Substring(1)
End Sub" else "")

      (if need_readchar then "
Function readChar() As Char
  Dim out_ as Char = readChar_()
  consommeChar()
  Return out_
End Function" else "")

      (if need_stdinsep then "

Sub stdin_sep()
  Do
    If eof Then
      Return
    End If
    Dim c As Char = readChar_()
    If c = \" \"C Or c = Chr(13) Or c = Chr(9) Or c = Chr(10) Then
      consommeChar()
    Else
      Return
    End If
  Loop
End Sub" else "")
      (if need_readint then "

Function readInt() As Integer
  Dim i As Integer = 0
  Dim s as Char = readChar_()
  Dim sign As Integer = 1
  If s = \"-\"C Then
    sign = -1
    consommeChar()
  End If
  Do
    Dim c as Char = readChar_()
    If c <= \"9\"C And c >= \"0\"C Then
      i = i * 10 + Asc(c) - Asc(\"0\"C)
      consommeChar()
    Else
      return i * sign
    End If
  Loop
End Function" else "")
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main


  method separator f () = Format.fprintf f ""

  method main f main =
    Format.fprintf f "Sub Main()@\n  @[<v>%a@]@\nEnd Sub@\n"
      self#instructions main

  method forloop f varname expr1 expr2 li =
      Format.fprintf f "@[<h>For@  %a As Integer @ =@ %a@ to @ %a@\n@]  @[<v>%a@]@\nNext"
        self#binding varname
        self#expr expr1
        self#expr expr2
        self#bloc li

  method print_proto f (funname, t, li) =
    Format.fprintf f "%a(%a)%a"
      self#funname funname
      (print_list
         (fun t (binding, type_) ->
           Format.fprintf t "%a %a@ as@ %a"
	     self#val_or_ref type_
             self#binding binding
             self#prototype type_
         ) sep_c
      ) li
      (fun f () -> match Type.unfix t with
      | Type.Void -> ()
      | _ ->
	Format.fprintf f " As %a" self#prototype t) ()

  method val_or_ref f t = match Type.unfix t with
    | Type.Integer
    | Type.Void
    | Type.Bool
    | Type.Char
    | Type.Enum _ ->  Format.fprintf f "ByVal"
    | _ ->  Format.fprintf f "ByRef"

  method ptype f t =
    match Type.unfix t with
    | Type.Integer -> Format.fprintf f "Integer"
    | Type.String -> Format.fprintf f "String"
    | Type.Array a -> Format.fprintf f "%a()" self#ptype a
    | Type.Void ->  Format.fprintf f "Void"
    | Type.Bool -> Format.fprintf f "Boolean"
    | Type.Char -> Format.fprintf f "Char"
    | Type.Named n -> Format.fprintf f "%s" n
    | Type.Struct li -> Format.fprintf f "a struct"
    | Type.Enum _ -> Format.fprintf f "an enum"
    | Type.Auto -> assert false
    | Type.Lexems -> assert false
    | Type.Tuple _ -> assert false


  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
      | Expr.Add -> "+"
      | Expr.Sub -> "-"
      | Expr.Mul -> "*"
      | Expr.Div -> "\\"
      | Expr.Mod -> "Mod"
      | Expr.Or -> "OrElse"
      | Expr.And -> "AndAlso"
      | Expr.Lower -> "<"
      | Expr.LowerEq -> "<="
      | Expr.Higher -> ">"
      | Expr.HigherEq -> ">="
      | Expr.Eq -> "="
      | Expr.Diff -> "<>"
      )

  method unop f op a =
    let pop f () = match op with
      | Expr.Neg -> Format.fprintf f "-"
      | Expr.Not -> Format.fprintf f "Not"
    in if self#nop (Expr.unfix a) then
        Format.fprintf f "%a %a" pop () self#expr a
      else
        Format.fprintf f "%a(%a)" pop () self#expr a

  method return f e = Format.fprintf f "@[<h>Return@ %a@]" self#expr e


  method print_fun f funname t li instrs =
    match Type.unfix t with
    | Type.Void ->
      Format.fprintf f "Sub @[<h>%a@]@\n@[<v 2>  %a@]@\nEnd Sub@\n"
	self#print_proto (funname, t, li)
	self#instructions instrs
    | _ ->
      Format.fprintf f "Function @[<h>%a@]@\n@[<v 2>  %a@]@\nEnd Function@\n"
	self#print_proto (funname, t, li)
	self#instructions instrs

  method binop f op a b =
    match op with
    | Expr.Eq ->
      begin match Type.unfix @$ Typer.get_type (super#getTyperEnv ()) a with
      | Type.Struct _ ->
	Format.fprintf f "Object.ReferenceEquals(%a, %a)"
        (self#chf op Left) a
        (self#chf op Right) b
      | _ -> super#binop f op a b
      end
    | Expr.Diff ->
      begin match Type.unfix @$ Typer.get_type (super#getTyperEnv ()) a with
      | Type.Struct _ ->
	Format.fprintf f "Not(Object.ReferenceEquals(%a, %a))"
        (self#chf op Left) a
        (self#chf op Right) b
      | _ -> super#binop f op a b
      end
    | _ -> super#binop f op a b


  method if_ f e ifcase elsecase =
    match elsecase with
    | [] -> Format.fprintf f "@[<h>If@ %a Then@]@\n  @[<v>%a@]@\nEnd If"
      self#expr e
      self#bloc ifcase
    | [Instr.Fixed.F ( _, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>If@ %a Then@]@\n  @[<v>%a@]@\nElse%a"
        self#expr e
        self#bloc ifcase
        self#instr instr
    | _ -> Format.fprintf f "@[<h>If@ %a Then@]@\n  @[<v>%a@]@\nElse@\n  @[<v>%a@]@\nEnd If"
      self#expr e
      self#bloc ifcase
      self#bloc elsecase

  method hasSelfAffect op = false

  method comment f s =
    let lic = String.split s '\n' in
    print_list
      (fun f s -> Format.fprintf f "'%s@\n" s) nosep
      f
      lic

  method concat_operator f () = Format.fprintf f "&"

  method whileloop f expr li =
    Format.fprintf f "@[<hov>Do While %a@]@\n  @[<v>%a@]@\nLoop"
      self#expr expr
      self#bloc li

  method bloc f li = 
    print_list self#instr sep_nl f li

  method mutable_ f m =
    match Mutable.unfix m with
    | Mutable.Dot (m, field) ->
      Format.fprintf f "%a.%a"
        self#mutable_ m
        self#field field
    | Mutable.Var binding -> self#binding f binding
    | Mutable.Array (m, indexes) ->
      Format.fprintf f "%a(%a)"
        self#mutable_ m
        (print_list self#expr (sep "%a)(%a")) indexes

  method allocarray f binding type_ len useless =
    let rec g f t = match Type.unfix t with
      | Type.Array ty -> g (fun ff () -> Format.fprintf ff "%a()" f ()) ty
      | _ -> f, t
    in let parent, ty = g (fun f () -> ()) type_ in
    Format.fprintf f "@[<hov>Dim %a(%a)%a As %a"
      self#binding binding
      self#expr len
      parent ()
      self#ptype ty


  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
        Format.fprintf f "Public Class %a@\n  @[<v>%a@]@\nEnd Class"
          self#typename name
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "Public %a As %a%a" self#field name self#ptype type_ 
		 self#separator ()
             ) sep_nl
          ) li
    | Type.Enum li ->
      Format.fprintf f "Enum %a@\n  @[<v>%a@]@\nEnd Enum@\n"
        self#typename name
        (print_list
           (fun t name ->
             self#enumfield t name
           ) sep_nl
        ) li
    | _ -> super#decl_type f name t

  method allocrecord f name t el =
    Format.fprintf f "Dim %a As %a = new %a()@\n%a"
      self#binding name
      self#ptype t
      self#ptype t
      (self#def_fields name) el


end
