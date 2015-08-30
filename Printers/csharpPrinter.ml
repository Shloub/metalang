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


(** C# Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast

let prio_operator = -100

let print_expr tyenv macros e f p =
  let print_lief tyenv prio f = function
    | Expr.Char c ->
        if (c >= 'A' && c <= 'Z' ) ||
        (c >= 'a' && c <= 'z' ) ||
        (c >= '0' && c <= '9' ) ||
        (c = '-' || c = '_' )
        then Format.fprintf f "%C" c
        else Format.fprintf f "(char)%d" (int_of_char c)
    | Ast.Expr.Enum e ->
        let t = Typer.typename_for_enum e tyenv in
        Format.fprintf f "%s.%s" t e
    | x -> print_lief prio f x in
  let print_mut conf prio f m = Mutable.Fixed.Deep.fold
      (print_mut0 "%a%a" "[%a]" "%a.%s" conf) m f prio in
  let config = {
    prio_binop;
    prio_unop;
    print_varname;
    print_lief = print_lief tyenv;
    print_op;
    print_unop;
    print_mut;
    macros
  } in Expr.Fixed.Deep.fold (print_expr0 config) e f p

class csharpPrinter = object(self)
  inherit JavaPrinter.javaPrinter as super

  method lang () = "csharp"

  method exprp p f e = print_expr (self#getTyperEnv ())
      (StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros) e f p

  method expr f e = self#exprp nop f e

  method ptype f t =
    match Type.unfix t with
    | Type.Integer -> Format.fprintf f "int"
    | Type.String -> Format.fprintf f "String"
    | Type.Array a -> Format.fprintf f "%a[]" self#ptype a
    | Type.Void ->  Format.fprintf f "void"
    | Type.Bool -> Format.fprintf f "bool"
    | Type.Char -> Format.fprintf f "char"
    | Type.Named n -> Format.fprintf f "%s" n
    | Type.Struct li -> Format.fprintf f "a struct"
    | Type.Enum _ -> Format.fprintf f "an enum"
    | Type.Auto | Type.Tuple _ | Type.Lexems -> assert false

  method prog f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f
      "using System;@\n%a@\npublic class %s@\n@[<v 2>{%s%s%s%s@\n%a@\n%a@]@\n}@\n"
      (fun f () ->
        if Tags.is_taged "use_readline"
        then Format.fprintf f "using System.Collections.Generic;@\n"
      ) ()
      prog.Prog.progname
      (if need then "
static bool eof;
static String buffer;
static char readChar_(){
  if (buffer == null){
    buffer = Console.ReadLine();
  }
  if (buffer.Length == 0){
    String tmp = Console.ReadLine();
    eof = tmp == null;
    buffer = tmp + \"\\n\";
  }
  char c = buffer[0];
  return c;
}
static void consommeChar(){
       readChar_();
  buffer = buffer.Substring(1);
}" else "")

      (if need_readchar then "
static char readChar(){
  char out_ = readChar_();
  consommeChar();
  return out_;
}" else "")

      (if need_stdinsep then "
static void stdin_sep(){
  do{
    if (eof) return;
    char c = readChar_();
    if (c == ' ' || c == '\\n' || c == '\\t' || c == '\\r'){
      consommeChar();
    }else{
      return;
    }
  } while(true);
}" else "")
      (if need_readint then "
static int readInt(){
  int i = 0;
  char s = readChar_();
  int sign = 1;
  if (s == '-'){
    sign = -1;
    consommeChar();
  }
  do{
    char c = readChar_();
    if (c <= '9' && c >= '0'){
      i = i * 10 + c - '0';
      consommeChar();
    }else{
      return i * sign;
    }
  } while(true);
} " else "")
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method print f t expr =
    Format.fprintf f "@[Console.Write(%a)%a@]" self#expr expr self#separator ()

  method main f main =
    Format.fprintf f "public static void Main(String[] args)@\n@[<v 2>{@\n%a@]@\n}@\n"
      self#instructions main

  method stdin_sep f  =
    Format.fprintf f "@[stdin_sep()%a@]" self#separator ()

  method concat_operator f () = Format.fprintf f "+"

  method multi_print f exprs =
    let exprs = (Instr.StringConst "") :: exprs in
    let rec compress = function
      | (e1::e2::tl ) as li ->
	begin match e1, e2 with
	| Instr.StringConst s1, Instr.StringConst s2 ->
	  Instr.StringConst (s2^s1)::tl
	| _ -> li
	end
      | x -> x
    in let exprs = List.fold_left (fun acc e ->
      let nacc = e::acc in
      compress nacc
    ) [] exprs in
    let exprs = List.rev exprs in
      Format.fprintf f "@[<h>Console.Write(%a)%a@]"
        (print_list
           (fun f e ->
             match e with
             | Instr.StringConst s -> self#exprp prio_operator f (Expr.string s)
             | Instr.PrintExpr (_, e) -> self#exprp prio_operator f e)
           (fun t f1 e1 f2 e2 -> Format.fprintf t "%a %a %a"
	     f1 e1
	     self#concat_operator ()
	     f2 e2)) exprs
	self#separator ()

  method read f t m =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[<h>%a = readInt()%a@]"
        self#mutable_set m self#separator ()
    | Type.Char -> Format.fprintf f "@[<h>%a = readChar()%a@]"
      self#mutable_set m self#separator ()
    | _ -> raise (Warner.Error (fun f -> Format.fprintf f "invalid type %s for format\n" (Type.type_t_to_string t)))

  method read_decl f t v =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[<h>%a %a = readInt()%a@]"
        self#ptype t
        self#binding v
	self#separator ()
    | Type.Char -> Format.fprintf f "@[<h>%a %a = readChar()%a@]"
        self#ptype t
        self#binding v
      self#separator ()
    | _ -> raise (Warner.Error (fun f -> Format.fprintf f "invalid type %s for format\n" (Type.type_t_to_string t)))

  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
        Format.fprintf f "@[<v 2>public class %a {@\n%a@]@\n}"
          self#typename name
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "public %a %a%a" self#ptype type_ self#field name
		 self#separator ()
             )
             sep_nl
          ) li
    | Type.Enum li ->
      Format.fprintf f "enum %a { @\n@[<v2>  %a@]}@\n"
        self#typename name
        (print_list self#enumfield (sep "%a,@\n %a")
        ) li
    | _ -> super#decl_type f name t

end
