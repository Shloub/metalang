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
open Printer

class forthPrinter = object(self)
  inherit printer as super

  method lang () = "fs"

  method string f s = (* rien que les chaines, c'est déjà la fete... *)
    if s = "" then Format.fprintf f "S\" \"" else
    let nappend = ref (-1) in
    let instring = String.fold_left (fun instring -> function
      | '\n' ->
          if instring then Format.fprintf f "\" ";
          nappend := !nappend + 1;
          Format.fprintf f "NEWLINE";
          false
      | c ->
          if instring then Format.fprintf f "%c" c
          else begin
            nappend := !nappend + 1;
            Format.fprintf f " s\" %c" c
          end;
          true ) false s
    in if instring then
      Format.fprintf f "\"";
    print_ntimes !nappend f " S+"

  method comment f s =
    let lic = String.split s '\n' in
    print_list (fun f s -> Format.fprintf f "\\ %s@\n" s) nosep f lic

  method binop f op a b =
    Format.fprintf f "%a %a %a"
      self#expr a
      self#expr b
      self#print_op op

  method unop f op a = match op with
  | Expr.Neg -> Format.fprintf f "%a NEGATE" self#expr a
  | Expr.Not -> Format.fprintf f "%a INVERT" self#expr a

  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
      | Expr.Add -> "+"
      | Expr.Sub -> "-"
      | Expr.Mul -> "*"
      | Expr.Div -> "//"
      | Expr.Mod -> "%"
      | Expr.Or -> "OR"
      | Expr.And -> "AND"
      | Expr.Lower -> "<"
      | Expr.LowerEq -> "<="
      | Expr.Higher -> ">"
      | Expr.HigherEq -> ">="
      | Expr.Eq -> "="
      | Expr.Diff -> "<>"
      )

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "%a@\nIF%a@\nTHEN"
        self#expr e
        self#bloc ifcase
    | _ ->
      Format.fprintf f "%a@\nIF%a@\nELSE%a@\nTHEN"
        self#expr e
        self#bloc ifcase
        self#bloc elsecase

  method bloc f li =
    Format.fprintf f "@[<v>@\n%a@]"
      (print_list self#instr sep_nl) li

  method main f main =
    Format.fprintf f "@[<v 2>: main @\n%a@\n;@]"
      self#instructions main

  method whileloop f expr li =
    Format.fprintf f "@[<v 2>BEGIN@\n%a@]@\nWHILE%a@\nREPEAT"
      self#expr expr
      self#bloc li

  val mutable ndrop = 0
  method forloop f varname expr1 expr2 li =
    ndrop <- ndrop + 2;
    Format.fprintf f "@[<hov>%a %a BEGIN 2dup >= WHILE DUP { %a }@] %a@\n 1 + REPEAT 2DROP"
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
    Format.fprintf f "

: // { a b }
  a b /
  a 0 < b 0 < XOR IF 1 + THEN
;

: %% { a b }
  a b MOD
  a 0 < b 0 < XOR IF b - THEN
 ;


VARIABLE buffer-index
0 buffer-index !
VARIABLE NEOF
1 NEOF !
VARIABLE buffer-max
0 buffer-max !
create bufferc 128 allot
bufferc 128 stdin read-line 2DROP buffer-max !
13 bufferc buffer-max c@@ + !

: current-char bufferc buffer-index @@ + c@@ ;

: next-char
  buffer-index @@ 1 + buffer-index !
  buffer-index @@ buffer-max @@ > IF
    0 buffer-index !
    bufferc 128 stdin read-line DROP -1 = NEOF ! buffer-max !
    10 bufferc buffer-max @@ + !
  THEN
;

: skipspaces
  BEGIN NEOF @@ current-char 13 = current-char 32 = OR current-char 10 = OR AND
  WHILE next-char REPEAT
;

: read-int
  1 { sign }
  [char] - current-char = IF
    0 1 - TO sign
    next-char
  THEN
  0 { o }
  BEGIN current-char [char] 0 >= current-char [char] 9 <= AND
  WHILE o 10 * current-char [char] 0 - + TO o next-char REPEAT
  o sign *
;

: read-char current-char next-char ;


%a%a@\nmain@\nBYE@\n"
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method declaration f var t e =
    Format.fprintf f "@[<hov>%a@ { %a }@]" self#expr e self#binding var

  method allocarray f binding type_ len useless =
    Format.fprintf f "@[<hov>HERE %a cells allot { %a }@]"
      self#expr len
      self#binding binding

  method char f c =
    let ci = int_of_char c in
    if ci >= 48 && ci <= 127 then
      Format.fprintf f "[char] %c" c
    else Format.fprintf f "%d" ci (* TODO gérer la taille *)

  method separator f () = Format.fprintf f ""
  method return f e = Format.fprintf f "@[<hov>%a%a exit@]"
      (print_ntimes ndrop) "DROP "
      self#expr e

  method hasSelfAffect op = false

  method call f var li =
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
      (fun f () -> if self#is_rec funname instrs then
        Format.fprintf f " recursive") ()
      (print_list self#binding sep_space) (List.map fst li)
      self#instructions instrs

  method mutable0 f m =
    match Mutable.unfix m with
    | Mutable.Dot (m, field) ->
      Format.fprintf f "%a %a"
        self#mutable_ m
        self#field field
    | Mutable.Var binding -> self#binding f binding
    | Mutable.Array (m, indexes) ->
      Format.fprintf f "%a %a"
        self#mutable_ m
        (print_list
           (fun f e -> Format.fprintf f "%a cells +" self#expr e)
           (fun f f1 e1 f2 e2 ->
             Format.fprintf f "%a @ %a" f1 e1 f2 e2
           ))
        indexes

  method mutable_ f m =
    match Mutable.unfix m with
    | Mutable.Var v -> self#mutable0 f m
    | _ -> Format.fprintf f "%a @" self#mutable0 m

  method mutablea f mutable_ =
    match Mutable.unfix mutable_ with
    | Mutable.Var v -> Format.fprintf f "TO %a" self#binding v
    | _ -> Format.fprintf f "%a !" self#mutable0 mutable_

  method affect f mutable_ (expr : 'lex Expr.t) =
    Format.fprintf f "%a %a"
      self#expr expr
      self#mutablea mutable_

  method stdin_sep f = Format.fprintf f "skipspaces"
  method readtype f t = match Type.unfix t with
  | Type.Integer -> Format.fprintf f "read-int"
  | Type.Char -> Format.fprintf f "read-char"
  | _ -> assert false

  method read f t mutable_ =
        Format.fprintf f "@[%a %a@]" self#readtype t self#mutablea mutable_

  method read_decl f t v =
    Format.fprintf f "@[%a { %a }@]" self#readtype t self#binding v

  method decl_type f name t =
    match (Type.unfix t) with
    | Type.Struct li ->
      Format.fprintf f "@[<v 2>struct@\n%a@]@\nend-struct %a@\n"
        (print_list
           (fun t (name, type_) ->
             Format.fprintf t "cell%% field %a" self#field name
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
           Format.fprintf f "%a %a %a !"
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
    | _ -> assert false


end

