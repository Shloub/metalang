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
open Ast
open Printer
open JavaPrinter


class csharpPrinter = object(self)
  inherit javaPrinter as super

  method lang () = "csharp"

  method char f c =
    if (c >= 'A' && c <= 'Z' ) ||
      (c >= 'a' && c <= 'z' ) ||
      (c >= '0' && c <= '9' ) ||
      (c = '-' || c = '_' )
    then Format.fprintf f "%C" c
    else Format.fprintf f "(char)%d" (int_of_char c)


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
      | Type.Auto -> assert false
			| Type.Lexems -> assert false

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
public static char readChar_(){
  if (buffer == null){
    buffer = Console.ReadLine();
  }
  if (buffer.Length == 0){
    String tmp = Console.ReadLine();
    eof = tmp == null;
    buffer = \"\\n\"+tmp;
  }
  char c = buffer[0];
  return c;
}
public static void consommeChar(){
       readChar_();
  buffer = buffer.Substring(1);
}" else "")

      (if need_readchar then "
public static char readChar(){
  char out_ = readChar_();
  consommeChar();
  return out_;
}" else "")

      (if need_stdinsep then "
public static void stdin_sep(){
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
public static int readInt(){
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
    Format.fprintf f "@[Console.Write(%a);@]" self#expr expr

  method main f main =
    Format.fprintf f "public static void Main(String[] args)@\n@[<v 2>{@\n%a@]@\n}@\n"
      self#instructions main

  method stdin_sep f  =
    Format.fprintf f "@[stdin_sep();@]"

  method length f tab =
    Format.fprintf f "%a.Length" self#mutable_ tab

  method multi_print f format exprs = super#base_multi_print f format exprs

  method read f t m =
    match Type.unfix t with
      | Type.Integer ->
	Format.fprintf f "@[<h>%a = readInt();@]"
	  self#mutable_ m
      | Type.Char -> Format.fprintf f "@[<h>%a = readChar();@]"
	self#mutable_ m
      | _ -> raise (Warner.Error (fun f -> Format.fprintf f "invalid type %s for format\n" (Type.type_t_to_string t)))


  method decl_type f name t =
    match (Type.unfix t) with
	Type.Struct li ->
	Format.fprintf f "public class %a {%a}"
	  self#binding name
	  (print_list
	     (fun t (name, type_) ->
	       Format.fprintf t "public %a %a;" self#ptype type_ self#binding name
	     )
	     (fun t fa a fb b -> Format.fprintf t "%a%a" fa a fb b)
	  ) li
      | Type.Enum li ->
        Format.fprintf f "enum %a { @\n@[<v2>  %a@]}@\n"
          self#binding name
          (print_list
	           (fun t name ->
               self#binding t name
	           )
	           (fun t fa a fb b -> Format.fprintf t "%a,@\n %a" fa a fb b)
	        ) li
      | _ -> super#decl_type f name t


end
