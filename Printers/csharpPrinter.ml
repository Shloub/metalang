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
    | x -> print_lief prio f x

let print_mut conf prio f m = Mutable.Fixed.Deep.fold
    (print_mut0 "%a%a" "[%a]" "%a.%s" conf) m f prio
let config tyenv macros = {
  prio_binop;
  prio_unop;
  print_varname;
  print_lief = print_lief tyenv;
  print_op;
  print_unop;
  print_mut;
  macros
} 
let print_expr config e f p =
   Expr.Fixed.Deep.fold (print_expr0 config) e f p

let ptype t f () =
  let open Type in let open Format in
  match t with
  | Integer -> fprintf f "int"
  | String -> fprintf f "String"
  | Array a -> fprintf f "%a[]" a ()
  | Void ->  fprintf f "void"
  | Bool -> fprintf f "bool"
  | Char -> fprintf f "char"
  | Named n -> fprintf f "%s" n
  | Struct li -> fprintf f "a struct"
  | Enum _ -> fprintf f "an enum"
  | Auto | Tuple _ | Lexems -> assert false
let ptype f t = Ast.Type.Fixed.Deep.fold ptype t f ()
        
let rec prefix_type f t =
  match Type.unfix t with
  | Type.Array t2 -> prefix_type f t2
  | t2 -> ptype f t

let rec suffix_type f t =
  match Type.unfix t with
  | Type.Array t2 ->
      Format.fprintf f "[]%a" suffix_type t2
  | _ -> Format.fprintf f ""
          
let print_instr c i =
  let open Ast.Instr in
  let open Format in
  let p f pend = match i with
  | Declare (var, ty, e, _) -> fprintf f "%a %a = %a%a" ptype ty c.print_varname var e nop pend ()
  | AllocArrayConst (name, ty, len, lief, opt) -> assert false
  | AllocArray (name, t, e, Some (var, lambda), opt) -> assert false
  | AllocArray (name, t, e, None, opt) ->    
      begin match Type.unfix t with
      | Type.Array t2 ->
          fprintf f "@[<h>%a[] %a = new %a[%a]%a%a@]"
            ptype t
            c.print_varname name
            prefix_type t2
            e nop
            suffix_type t pend ()
      | _ ->
          fprintf f "@[<h>%a[] %a = new %a[%a]%a@]"
            ptype t
            c.print_varname name
            ptype t
            e nop pend ()
      end
  | AllocRecord (name, ty, list, opt) ->
      fprintf f "%a %a = new %a()%a@\n%a"
        ptype ty c.print_varname name ptype ty pend ()
        (print_list (fun f (field, x) -> fprintf f "%a.%s = %a%a" 
            c.print_varname name field x nop pend ()) sep_nl) list
  | Print [StringConst s] -> fprintf f "Console.Write(%a);" (c.print_lief prio_operator) (Expr.String s)
  | Print [PrintExpr (_, e)] -> fprintf f "Console.Write(%a);" e nop
  | Print li->
      fprintf f "Console.Write(%a%a);"
        (fun f () ->
          match li with
          | (PrintExpr (_, _))::(PrintExpr (_, _))::_ -> fprintf f "\"\" + "
          | _ -> ()
        ) ()
          (print_list
             (fun f e ->
               match e with
               | StringConst s -> c.print_lief prio_operator f (Expr.String s)
               | PrintExpr (_, e) -> e f prio_operator)
             (fun t f1 e1 f2 e2 -> Format.fprintf t "%a + %a" f1 e1 f2 e2)) li
  | Read li ->
      print_list
        (fun f -> function
          | Separation -> Format.fprintf f "@[stdin_sep()%a@]" pend ()
          | DeclRead (ty, v, opt) ->
              begin match Ast.Type.unfix ty with
              | Ast.Type.Char -> fprintf f "@[%a %a = readChar()%a@]" ptype ty c.print_varname v pend ()
              | Ast.Type.Integer -> fprintf f "@[%a %a = readInt()%a@]" ptype ty c.print_varname v pend ()
              | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot read type %s"
                    (Type.type_t_to_string ty)))
              end
          | ReadExpr (ty, mut) ->
              begin match Ast.Type.unfix ty with
              | Ast.Type.Char -> fprintf f "@[%a = readChar()%a@]" (c.print_mut c nop) mut pend ()
              | Ast.Type.Integer -> fprintf f "@[%a = readInt()%a@]" (c.print_mut c nop) mut pend ()
              | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot read type %s"
                    (Type.type_t_to_string ty)))
              end
        ) sep_nl f li
  | Untuple (li, expr, opt) -> assert false
  | Unquote e -> assert false
  | _ -> clike_print_instr c i f pend
  in
  let is_multi_instr = match i with
  | Read (hd::tl) -> true
  | Declare _ -> true
  | _ -> false in
  {
   is_multi_instr = is_multi_instr;
   is_if=is_if i;
   is_if_noelse=is_if_noelse i;
   is_comment=is_comment i;
   p=p;
   default = seppt;
   print_lief = c.print_lief;
 }
    
let print_instr tyenv macros i =
  let open Ast.Instr.Fixed.Deep in
  let c = config tyenv macros in
  let i = (fold (print_instr c) (mapg (print_expr c) i))
  in fun f -> i.p f i.default

class csharpPrinter = object(self)
  inherit JavaPrinter.javaPrinter as super

  method instr f t =
   let macros = StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros
   in (print_instr (self#getTyperEnv ()) macros t) f

  method lang () = "csharp"

  method exprp p f e =
    let config = config (self#getTyperEnv ())
      (StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros) in
    print_expr config e f p

  method expr f e = self#exprp nop f e

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
  if (buffer == null || buffer.Length == 0){
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
        ptype t
        self#binding v
	self#separator ()
    | Type.Char -> Format.fprintf f "@[<h>%a %a = readChar()%a@]"
        ptype t
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
               Format.fprintf t "public %a %a%a" ptype type_ self#field name
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

  method print_proto f (funname, t, li) =
    Format.fprintf f "%a%a %a(%a)"
      self#static () ptype t
      self#funname funname
      (print_list
         (fun t (binding, type_) ->
           Format.fprintf t "%a@ %a"
             ptype type_
             self#binding binding
         ) sep_c
      ) li

end
