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

(** Forth Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast

let is_string tyenv a =
  match Typer.get_type_a tyenv a |> Type.unfix with
  | Type.String -> true
  | _ -> false
let print_access f access = Format.fprintf f (if access then " @@" else "")
let print_access_double f access = Format.fprintf f (if access then " 2@@" else "")
let print_mut0 tyenv annot m f access =
  let open Format in
  let open Mutable in match m with
  | Var v -> print_varname f v
  | Array (m, li) ->
      if is_string tyenv annot then
        match List.rev li with
        | hd::tl ->
            fprintf f "%a %a %a cells 2 * + %a" m true
              (print_list (fun f a -> fprintf f "%a cells + @@" a ()) (sep "%a %a")) (List.rev tl)
              hd ()
              print_access_double access
        | [] -> assert false
      else
        begin match List.rev li with
        | hd::tl ->
            fprintf f "%a %a %a cells + %a" m true
              (print_list (fun f a -> fprintf f "%a cells + @@" a ()) (sep "%a %a")) (List.rev tl)
              hd ()
              print_access access
        | [] -> assert false
        end
  | Dot (m, field) ->
      if is_string tyenv annot then
        fprintf f "%a ->%s%a" m true field print_access_double access
      else fprintf f "%a ->%s%a" m true field print_access access

let print_expr0 tyenv macros e f prio_parent =
  let open Expr in
  let open Format in
  let print_op f op = fprintf f
      "%s"
      (match op with
      | Add -> "+"
      | Sub -> "-"
      | Mul -> "*"
      | Div -> "//"
      | Mod -> "%"
      | Or -> "OR"
      | And -> "AND"
      | Lower -> "<"
      | LowerEq -> "<="
      | Higher -> ">"
      | HigherEq -> ">="
      | Eq -> "="
      | Diff -> "<>"
      ) in
  let print_lief f = function
    | String s ->
        let s = " " ^ s in
        let s = Printf.sprintf "%S" s in
        fprintf f (if String.exists ((=) '\\') s then "S\\%s" else "S%s") s
    | Char c -> let ci = int_of_char c in
      if ci >= 48 && ci <= 127 then fprintf f "[char] %c" c
      else fprintf f "%d" ci
    | Bool true -> fprintf f "true"
    | Bool false -> fprintf f "false"
    | Enum e -> fprintf f "%s" e
    | Integer i -> fprintf f "%i" i
  in
  let print_mut m f b = Mutable.Fixed.Deep.folda (print_mut0 tyenv) m f b in
  match e with
  | BinOp (a, op, b) -> fprintf f "%a %a %a" a () b () print_op op
  | UnOp (a, Not) -> fprintf f "%a INVERT" a ()
  | UnOp (a, Neg) -> fprintf f "%a NEGATE" a ()
  | Lief l -> print_lief f l
  | Access m -> print_mut m f true
  | Call (func, li) ->
      begin match StringMap.find_opt func macros with
      | Some ( (t, params, code) ) ->
          pmacros f "%s" t params code li ()
      | None -> fprintf f "%a %s" (print_list (fun f x -> x f ()) sep_space) li func
      end
  | Lexems li -> assert false
  | Tuple li -> assert false
  | Record li -> assert false

let print_expr tyenv macros e f () = Expr.Fixed.Deep.fold (print_expr0 tyenv macros) e f ()

class forthPrinter = object(self)
  inherit Printer.printer as super

  method lang () = "fs"

  method field f i = Format.fprintf f "->%s" i

  method comment f s =
    let lic = String.split s '\n' in
    print_list (fun f s -> Format.fprintf f "\\ %s@\n" s) nosep f lic

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "%a@\n@[<v 2>IF@\n%a@]@\nTHEN"
        self#expr e
        self#bloc ifcase
    | _ ->
      Format.fprintf f "%a@\n@[<v 2>IF@\n%a@]@\n@[<v 2>ELSE@\n%a@]@\nTHEN"
        self#expr e
        self#bloc ifcase
        self#bloc elsecase

  method bloc f li = print_list self#instr sep_nl f li

  method main f main =
    Format.fprintf f "@[<v 2>: main@\n%a@\n;@]"
      self#instructions main

  method whileloop f expr li =
    Format.fprintf f "@[<v 2>BEGIN@\n%a@]@\n@[<v 2>WHILE@\n%a@]@\nREPEAT"
      self#expr expr
      self#bloc li

  val mutable ndrop = 0
  method forloop f varname expr1 expr2 li =
    ndrop <- ndrop + 2;
    Format.fprintf f "@[<v 2>@[<h>%a %a BEGIN 2dup >= WHILE DUP { %a }@]@\n%a@]@\n 1 + REPEAT 2DROP"
      self#expr expr2
      self#expr expr1
      self#binding varname
      self#bloc li;
    ndrop <- ndrop - 2

  method print f t expr = match Type.unfix t with
  | Type.Char -> Format.fprintf f "@[%a EMIT@]" self#expr expr
  | Type.String -> Format.fprintf f "@[%a TYPE@]" self#expr expr
  | Type.Integer -> Format.fprintf f "@[%a s>d 0 d.r@]" self#expr expr
  | _ -> assert false

  method prog f (prog: Utils.prog) =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "%a%a%a%a%a%a%a%a@\nmain@\nBYE@\n"
                     (fun f () ->
                       if Tags.is_taged "__internal__div" then
                         Format.fprintf f ": // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;@\n") ()
                     (fun f () ->
                       if Tags.is_taged "__internal__mod" then
                         Format.fprintf f ": %% { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;@\n" ) ()
                     (fun f () -> if need then
print_list (fun f s -> if need then Format.fprintf f "%s@\n" s) nosep f
["VARIABLE buffer-index";
"1000 buffer-index !";
"VARIABLE NEOF";
"1 NEOF !";
"VARIABLE buffer-max";
"0 buffer-max !";
"create bufferc 128 allot";
": next-char";
"  buffer-index @ 1 + buffer-index !";
"  buffer-index @ buffer-max @ > IF";
"    0 buffer-index !";
"    bufferc 128 stdin read-line DROP -1 = NEOF ! buffer-max !";
"    10 bufferc buffer-max @ + !";
"  THEN ;";
": current-char";
"  buffer-index @ buffer-max @ > IF next-char THEN";
"  bufferc buffer-index @ + c@ ;"
]
) ()
(fun f () -> if need_stdinsep then print_list (fun f s -> Format.fprintf f "%s@\n" s) nosep f
[": skipspaces";
"  BEGIN NEOF @ current-char 13 = current-char 32 = OR current-char 10 = OR AND";
"  WHILE next-char REPEAT ;"]) ()
(fun f () -> if need_readint then print_list (fun f s -> Format.fprintf f "%s@\n" s) nosep f
[ ": read-int";
"  [char] - current-char = IF -1 next-char ELSE 1 THEN";
"  0 BEGIN current-char [char] 0 >= current-char [char] 9 <= AND";
"  WHILE 10 * current-char [char] 0 - + next-char REPEAT * ;"
]) ()
(fun f () -> if need_readchar then Format.fprintf f ": read-char current-char next-char ;@\n") ()

      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method declaration f var t e =
    Format.fprintf f "@[<hov>%a@ { %a }@]" self#expr e self#binding var

  method allocarray f binding type_ len useless =
    match Type.unfix type_ with
    | Type.String ->
        Format.fprintf f "@[<h>HERE %a cells 2 * allot { %a }@]"
          self#expr len
          self#binding binding
    | _ ->
        Format.fprintf f "@[<h>HERE %a cells allot { %a }@]"
          self#expr len
          self#binding binding

  method separator f () = Format.fprintf f ""
  method return f e = Format.fprintf f "@[<hov>%a%a exit@]"
      (print_ntimes ndrop) "DROP "
      self#expr e

  method hasSelfAffect op = false

  method apply f var li =
    match StringMap.find_opt var macros with
    | Some ( (t, params, code) ) ->
      self#expand_macro_call f var t params code li
    | None ->
      Format.fprintf
        f
        "@[<hov>%a %a%a@]"
        (print_list self#expr sep_space) li
        self#funname var
	        self#separator ()

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<hov>: %a%a { %a }@]@\n@[<v 2>  %a@]@\n;@\n"
      self#funname funname
      (fun f () -> if self#is_rec funname then
        Format.fprintf f " recursive") ()
      (print_list (fun f (n, t) ->
        match Type.unfix t with
        | Type.String -> Format.fprintf f "D: %a" self#binding n
        | _ -> self#binding f n)
         sep_space) li
      self#instructions instrs

  method mutable0 f m =
    let macros = self#gmacros () in
    let tyenv = self#getTyperEnv () in
    let mut = Ast.Mutable.Fixed.Deep.mapg (print_expr tyenv macros) m in
    Ast.Mutable.Fixed.Deep.folda (print_mut0 tyenv) mut f false

  method mutable_get f m =
    match Mutable.unfix m with
    | Mutable.Var v -> self#mutable0 f m
    | _ -> match Typer.get_type_a (self#getTyperEnv ()) (Mutable.Fixed.annot m) |> Type.unfix with
        | Type.String -> Format.fprintf f "%a 2@@" self#mutable0 m
        | _ -> Format.fprintf f "%a @@" self#mutable0 m

  method mutable_set f mutable_ =
    match Typer.get_type_a (self#getTyperEnv ()) (Mutable.Fixed.annot mutable_) |> Type.unfix with
    | Type.String -> begin  match Mutable.unfix mutable_ with
      | Mutable.Var v -> Format.fprintf f "2TO %a" self#binding v
      | _ -> Format.fprintf f "%a 2!" self#mutable0 mutable_
    end
    | _ -> match Mutable.unfix mutable_ with
      | Mutable.Var v -> Format.fprintf f "TO %a" self#binding v
      | _ -> Format.fprintf f "%a !" self#mutable0 mutable_

  method affect f mutable_ (expr : 'lex Expr.t) =
    Format.fprintf f "%a %a"
      self#expr expr
      self#mutable_set mutable_

  method stdin_sep f = Format.fprintf f "skipspaces"
  method readtype f t = match Type.unfix t with
  | Type.Integer -> Format.fprintf f "read-int"
  | Type.Char -> Format.fprintf f "read-char"
  | _ -> assert false

  method read f t mutable_ =
        Format.fprintf f "@[%a %a@]" self#readtype t self#mutable_set mutable_

  method read_decl f t v =
    Format.fprintf f "@[%a { %a }@]" self#readtype t self#binding v

  method decl_type f name t =
    match (Type.unfix t) with
    | Type.Struct li ->
      Format.fprintf f "@[<v 2>struct@\n%a@]@\nend-struct %a@\n"
        (print_list
           (fun t (name, type_) ->
             match Type.unfix type_ with
             | Type.String -> Format.fprintf t "double%% field %a" self#field name
             | _ -> Format.fprintf t "cell%% field %a" self#field name
           ) sep_nl
        ) li
        self#typename name
    | Type.Enum li ->
        print_list_indexed
          (fun t name index ->
            Format.fprintf t "%d constant %a"
              index
              self#enumfield name
          ) sep_nl
          f li
    | _ -> ()

  method def_fields name f li =
    Format.fprintf f "@[<hov>%a@]"
      (print_list
         (fun f (fieldname, expr) ->
           Format.fprintf f (match Typer.get_type (self#getTyperEnv ()) expr |> Type.unfix with
           | Type.String -> "%a %a %a 2!"
           | _ -> "%a %a %a !")
             self#expr expr
             self#binding name
             self#field fieldname
         ) sep_nl)
      li

  method allocrecord f name t el =
    Format.fprintf f "%a %%allot { %a }@\n%a"
      self#ptype t
      self#binding name
      (self#def_fields name) el


  method typename f i = Format.fprintf f "%s%%" i
  method ptype f (t:Type.t) =
    match Type.unfix t with
    | Type.Named n -> self#typename f n
    | _ ->  super#ptype f t

  method gmacros () = StringMap.map (fun (ty, params, li) ->
    ty, params,
    try List.assoc (self#lang ()) li
    with Not_found -> List.assoc "" li) macros

  method expr f e = print_expr (self#getTyperEnv ()) (self#gmacros ()) e f ()

end

