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


(** java Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Helper
open Printer
open CppPrinter

let prio_binop op =
  let open Ast.Expr in match op with
  | Mul -> assoc 5
  | Div
  | Mod -> nonassocr 7
  | Add -> assoc 9
  | Sub -> nonassocr 9
  | Lower
  | LowerEq
  | Higher
  | HigherEq -> assoc 11
  | Eq -> nonassocl 13
  | Diff -> nonassocl 13
  | And -> assoc 15
  | Or -> assoc 15

let print_lief tyenv prio f = function
  | Ast.Expr.Char c -> unicode f c
  | Ast.Expr.Enum e ->
      let t = Typer.typename_for_enum e tyenv in
      Format.fprintf f "%s.%s" t e
  | x -> print_lief prio f x

let print_expr tyenv macros e f p =
  let print_mut conf prio f m = Ast.Mutable.Fixed.Deep.fold
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
  } in Ast.Expr.Fixed.Deep.fold (print_expr0 config) e f p

class javaPrinter = object(self)
  inherit cppPrinter as cppprinter

  method expr f e = print_expr (self#getTyperEnv ()) 
      (StringMap.map (fun (ty, params, li) ->
        ty, params, List.assoc (self#lang ()) li) macros) e f nop

  method declare_for s f li = ()

  method combine_formats () = true

  method lang () = "java"

  method prototype f t = self#ptype f t

  method stdin_sep f =
    Format.fprintf f "@[<v>scanner.findWithinHorizon(\"[\\n\\r ]*\", 1)%a@]"
      self#separator ()

  method ptype f t =
    match Type.unfix t with
    | Type.Integer -> Format.fprintf f "int"
    | Type.String -> Format.fprintf f "String"
    | Type.Array a -> Format.fprintf f "%a[]" self#ptype a
    | Type.Void ->  Format.fprintf f "void"
    | Type.Bool -> Format.fprintf f "boolean"
    | Type.Char -> Format.fprintf f "char"
    | Type.Named n -> self#typename f n
    | Type.Enum _ -> Format.fprintf f "an enum"
    | Type.Struct li -> Format.fprintf f "a struct"
    | Type.Auto | Type.Tuple _ | Type.Lexems -> assert false

  method decl_field f (name, type_) = Format.fprintf f "public %a %a%a" self#ptype type_ self#field name self#separator ()

  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
        Format.fprintf f "@[<v 2>%aclass %a {@\n%a@]@\n}"
          self#static ()
          self#typename name
          (print_list self#decl_field sep_nl) li
    | Type.Enum li ->
      Format.fprintf f "enum %a { @\n@[<v2>  %a@]}@\n"
        self#typename name
        (print_list self#enumfield (sep "%a,@\n %a")) li
    | _ -> cppprinter#decl_type f name t

  method enum f e =
    let t = Typer.typename_for_enum e (cppprinter#getTyperEnv ()) in
    Format.fprintf f "%a.%s" self#typename t e

  method prog f prog =
    let reader = Tags.is_taged "use_readmacros" || prog.Prog.hasSkip || TypeSet.cardinal prog.Prog.reads <> 0 in
    let datareader = Tags.is_taged "use_java_readline" in
    Format.fprintf f
      "import java.util.*;@\n@\npublic class %s@\n@[<v 2>{@\n%a%a@\n%a@\n%a@]@\n}@\n"
      prog.Prog.progname
      (if reader || datareader then self#print_scanner else fun f () -> ()) ()
      (if datareader then self#print_datareader else fun f () -> ()) ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main


  method prefix_type f t =
    match Type.unfix t with
    | Type.Array t2 -> self#prefix_type f t2
    | t2 -> self#ptype f t

  method suffix_type f t =
    match Type.unfix t with
    | Type.Array t2 ->
      Format.fprintf f "[]%a" self#suffix_type t2
    | _ -> Format.fprintf f ""

  method allocarray f binding type_ len _ =
    match Type.unfix type_ with
    | Type.Array t2 ->
      Format.fprintf f "@[<h>%a[] %a = new %a[%a]%a%a@]"
        self#ptype type_
        self#binding binding
        self#prefix_type t2
        self#expr len
        self#suffix_type type_
          self#separator ()
    | _ ->
      Format.fprintf f "@[<h>%a[] %a = new %a[%a]%a@]"
        self#ptype type_
        self#binding binding
        self#ptype type_
        self#expr len
          self#separator ()

  method main f main =
    Format.fprintf f "public static void main(String args[])@\n@[<v 2>{@\n%a@]@\n}@\n"
      self#instructions main

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>%a@]@\n@[<v 2>{@\n%a@]@\n}@\n"
      self#print_proto (funname, t, li)
      self#instructions instrs

  method print_proto f triplet =
    Format.fprintf f "%a%a"
      self#static ()
      cppprinter#print_proto triplet

  method static f () = Format.fprintf f "static "

  method print_scanner f () =
    Format.fprintf f "@[<h>%aScanner scanner = new Scanner(System.in)%a@]"
      self#static ()
      self#separator ()

  method print_datareader f () =
    Format.fprintf f "@[<h>
    %aint[] read_int_line(){
        String[] s = scanner.nextLine().split(\" \");
        int[] out = new int[s.length];
        for (int i = 0; i < s.length; i ++)
          out[i] = Integer.parseInt(s[i]);
        return out;
    }
@]"
  self#static ()

  method read f t m =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[<h>if (scanner.hasNext(\"^-\")){@\n  scanner.next(\"^-\");@\n  %a = -scanner.nextInt();@\n}else{@\n  %a = scanner.nextInt();@\n}@]"
        self#mutable_set m
        self#mutable_set m
    | Type.Char -> Format.fprintf f "@[<h>%a = scanner.findWithinHorizon(\".\", 1).charAt(0);@]"
      self#mutable_set m
    | _ -> failwith("unsuported read")

  method read_decl f t v =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[<h>%a %a;@\nif (scanner.hasNext(\"^-\")){@\n  scanner.next(\"^-\");@\n  %a = scanner.nextInt();@\n} else {@\n  %a = scanner.nextInt();@\n}@]"
        self#ptype t
        self#binding v
        self#binding v
        self#binding v
    | Type.Char -> Format.fprintf f "@[<h>char %a = scanner.findWithinHorizon(\".\", 1).charAt(0);@]"
      self#binding v
    | _ -> failwith("unsuported read")

  method multi_print f format exprs =
    match exprs with
    | [] -> Format.fprintf f "@[<h>System.out.print(\"%s\");@]" format
    | _ ->
      Format.fprintf f "@[<h>System.out.printf(\"%s\", %a);@]" format
        (print_list self#expr sep_c ) (List.map snd exprs)

  method print f t expr = match Expr.unfix expr with
  | Expr.Lief (Expr.String s) -> Format.fprintf f "@[System.out.print(%S);@]" s
  | _ ->
    Format.fprintf f "@[System.out.printf(\"%a\", %a);@]" self#format_type t self#expr expr

  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
        Format.fprintf f "@[<h>%a.%a = %a%a@]"
          self#binding name
          self#field fieldname
          self#expr expr
	  self#separator ()
      ) sep_nl
      f
      li


  method allocrecord f name t el =
    Format.fprintf f "%a %a = new %a()%a@\n%a"
      self#ptype t
      self#binding name
      self#ptype t
      self#separator ()
      (self#def_fields name) el
      
  method m_field f m field = 
      Format.fprintf f "%a.%s"
        self#mutable_get m
        field

  method m_array f m indexes =
      Format.fprintf f "@[<h>%a[%a]@]"
        self#mutable_get m
        (print_list self#expr (sep "%a][%a")) indexes

  method multiread f instrs = self#basemultiread f instrs
end
