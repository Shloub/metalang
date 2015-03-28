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


(** Racket Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper

module E = AstFun.Expr
module Type = Ast.Type
module TypeSet = Ast.TypeSet

let format_to_string li =
  let li = List.map (function
		      | E.IntFormat -> "~a"
		      | E.StringFormat -> "~s"
		      | E.CharFormat -> "~c"
		      | E.StringConstant s -> String.replace "~" "~~" s
		    ) li
  in String.concat "" li

class racketPrinter = object(self)
  inherit OcamlFunPrinter.camlFunPrinter as super
  method lang () = "rkt"

  method binopstr = function
  | Ast.Expr.Add -> "+"
  | Ast.Expr.Sub -> "-"
  | Ast.Expr.Mul -> "*"
  | Ast.Expr.Div -> "quotient"
  | Ast.Expr.Mod -> "remainder"
  | Ast.Expr.Or -> "or"
  | Ast.Expr.And -> "and"
  | Ast.Expr.Lower -> "<"
  | Ast.Expr.LowerEq -> "<="
  | Ast.Expr.Higher -> ">"
  | Ast.Expr.HigherEq -> ">="
  | Ast.Expr.Eq -> "eq?"
  | Ast.Expr.Diff -> assert false

  method unopstr = function
  | Ast.Expr.Neg -> "-"
  | Ast.Expr.Not -> "not"

  method lief f = function
  | E.Error -> Format.fprintf f "(assert false)"
  | E.Unit -> Format.fprintf f "'()"
  | E.Char c ->
    begin match c with
    | ' ' -> Format.fprintf f "#\\Space"
    | '\n' -> Format.fprintf f "#\\NewLine"
    | x -> if (x >= 'a' && x <= 'z') ||
	    (x >= '0' && x <= '9') ||
	    (x >= 'A' && x <= 'Z')
      then Format.fprintf f "#\\%c" x
      else Format.fprintf f "(integer->char %d)" (int_of_char c)
    end
  | E.String s -> Format.fprintf f "%S" s
  | E.Integer i -> Format.fprintf f "%i" i
  | E.Bool true -> Format.fprintf f "#t"
  | E.Bool false -> Format.fprintf f "#f"
  | E.Enum s -> Format.fprintf f "'%s" s
  | E.Binding s -> self#binding f s

  method comment f s c =
    let lic = String.split s '\n' in
    Format.fprintf f "%a%a"
      (print_list
	 (fun f s -> Format.fprintf f ";%s@\n" s) nosep)
      lic
      self#expr c

  method binop f a op b =
    match op with
    | Ast.Expr.Diff -> Format.fprintf f "(not (eq? %a %a))" self#expr a self#expr b
    | _ -> Format.fprintf f "(%a %a %a)" self#pbinop op self#expr a self#expr b

  method fun_ f params e =
    let params = if params = [] then ["_"] else params in
    Format.fprintf f "@[<v 2>(lambda (%a) @\n%a@])@]"
      (print_list self#binding sep_space)
      params
      self#expr e

  method header array_init array_make f opts =
    let need_stdinsep = opts.AstFun.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) opts.AstFun.reads in
    let need_readchar = TypeSet.mem (Type.char) opts.AstFun.reads in
    let need = need_stdinsep || need_readint || need_readchar in
Format.fprintf f "#lang racket
(require racket/block)
%a%a%a%a%a@\n"
(fun f () -> if array_make then Format.fprintf f
"(define array_init_withenv (lambda (len f env)
  (let ((tab (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    ))))) (list env tab))))
"
) ()
(fun f () -> if need then Format.fprintf f
"(define last-char 0)
(define next-char (lambda () (set! last-char (read-char (current-input-port)))))
(next-char)
") ()
(fun f () -> if need_readchar then Format.fprintf f
"(define mread-char (lambda ()
  (let ([ out last-char])
    (block
      (next-char)
      out
    ))))
") ()
(fun f () -> if need_readint then Format.fprintf f
"(define mread-int (lambda ()
  (if (eq? #\\- last-char)
  (block
    (next-char) (- 0 (mread-int)))
    (letrec ([w (lambda (out)
      (if (eof-object? last-char)
        out
        (if (and last-char (>= (char->integer last-char) (char->integer #\\0)) (<= (char->integer last-char) (char->integer #\\9)))
          (let ([out (+ (* 10 out) (- (char->integer last-char) (char->integer #\\0)))])
            (block
              (next-char)
              (w out)
          ))
        out
      )))]) (w 0)))))
") ()
(fun f () -> if need_stdinsep then Format.fprintf f 
"(define mread-blank (lambda ()
  (if (or (eq? last-char #\\NewLine) (eq? last-char #\\Space) ) (block (next-char) (mread-blank)) '())
))
") ()


  method skip f = Format.fprintf f "(mread-blank)"

  method read f ty next = match Type.unfix ty with
  | Type.Char -> Format.fprintf f "(%a (mread-char))" self#expr next
  | Type.Integer -> Format.fprintf f "(%a (mread-int))" self#expr next
  | _ -> assert false

  method toplvl_declare f name e =
    match E.unfix e with
    | E.Fun (params, e) ->
      let params = if params = [] then ["_"] else params in
      Format.fprintf f "@[<v2>(define (%a %a)@\n%a@]@\n)@\n" self#binding name
	(print_list self#binding sep_space) params
	self#expr e
    | _ -> Format.fprintf f "@[<v2>(define %a@\n%a@]@\n)@\n" self#binding name self#expr e

  method toplvl_declarety f name ty =
    match Ast.Type.unfix ty with
    | Type.Struct fields ->
      let fields = List.sort String.compare @$ List.map fst fields in
      Format.fprintf f "@[<v 2>(struct %a (%a)@])@\n"
	self#binding name
	(print_list (fun f name -> Format.fprintf f "[%s #:mutable]" name)
	sep_space) fields
    | _ -> ()


  method if_ f e1 e2 e3 = Format.fprintf f "@[(if %a@\n%a@\n%a)@]" self#expr e1 self#expr e2 self#expr e3

  method funtuple f params e =
    match params with
    | [] -> Format.fprintf f "(lambda (_) %a)" self#expr e
    | _ -> Format.fprintf f "(lambda (internal_env) (apply (lambda@[ (%a) @\n%a@]) internal_env))"
      (print_list self#binding sep_space) params
      self#expr e

  method letin f params b  = Format.fprintf f "@[(let (%a)@\n%a@])"
    (print_list
       (fun f (s, a) ->
	 Format.fprintf f "[%a %a]"
	   self#binding s self#expr a
       ) sep_nl)
    params
    self#expr b

  method block1 f li = Format.fprintf f "@[<v 2>(block@\n%a@\n)@]"
    (print_list (fun f func -> func f ()) sep_nl) li

  method block f li = Format.fprintf f "@[<v 2>(block@\n%a@\n)@]"
    (print_list self#expr sep_nl) li

  method print_format f formats =
    Format.fprintf f "%S" (format_to_string formats)

  method multiprint f formats exprs =
    Format.fprintf f "(printf %a %a)"
		   self#print_format formats
		   (print_list (fun f (a, ty) -> self#expr f a) sep_space) exprs

  method print f e ty =
    Format.fprintf f "(display %a)"
      self#expr e

  method tuple f li =
    Format.fprintf f "(list %a)"
      (print_list self#expr sep_space) li

  method apply_nomacros f e li =
    if li = [] then Format.fprintf f "(%a 'nil)" self#expr e
    else Format.fprintf f "(%a %a)" self#expr e (print_list self#expr sep_space) li
      

  method letrecin f name params e1 e2 = (* TODO *)
    let e1 = E.fun_ params e1 in
    Format.fprintf f "@[<v 2>(letrec ([%a %a])@\n%a)@]"
      self#binding name
      self#expr e1
      self#expr e2

  method arrayinit f len lambda = Format.fprintf f "(build-vector %a %a)" self#expr len self#expr lambda

  method arraymake f len lambda env = Format.fprintf f "(array_init_withenv %a %a %a)" self#expr len self#expr lambda self#expr env

  method arrayindex f tab indexes =
    match List.rev indexes with
    | [] -> self#expr f tab
    | [expr] ->
      Format.fprintf f "(vector-ref %a %a)"
	self#expr tab
	self#expr expr
    | hd::tl -> Format.fprintf f "(vector-ref %a %a)"
      (fun f tl -> self#arrayindex f tab tl) tl
      self#expr hd

  method arrayaffect f tab indexes v =
    match List.rev indexes with
    | [] -> assert false
    | hd::tl ->
      let tl = List.rev tl in
      Format.fprintf f "(vector-set! %a %a %a)"
	(fun f () -> self#arrayindex f tab tl) ()
	self#expr hd
	self#expr v

  method recordaccess f record field  =
    Format.fprintf f "(%s-%s %a)"
      (self#typename_of_field field)
      field self#expr record

  method recordaffect f record field value =
    Format.fprintf f "(set-%s-%s! %a %a)"
      (self#typename_of_field field)
      field
      self#expr record
      self#expr value

  method record f li =
    let li = List.sort (fun (_, f1) (_, f2) -> String.compare f1 f2) li in
    let f1 = snd @$ List.hd li in
    Format.fprintf f "(%s %a)"
      (self#typename_of_field f1)
      (print_list
	 (fun f (expr, field) -> Format.fprintf f "%a" self#expr expr)
	 sep_space) li


end

let racketPrinter = new racketPrinter

