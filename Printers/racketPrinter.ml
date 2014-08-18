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
    Pour l'adapter à un autre scheme / lisp / etc...:
    @see http://hyperpolyglot.org/lisp
*)

open Stdlib

module E = AstFun.Expr
module Type = Ast.Type
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
    | x -> if (x >= 'a' && x <= 'z') or
	(x >= '0' && x <= '9') or
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
      (Printer.print_list
	 (fun f s -> Format.fprintf f ";%s@\n" s)
	 (fun f pa a pb b -> Format.fprintf f "%a%a" pa a pb b))
      lic
      self#expr c

  method binop f a op b =
    match op with
    | Ast.Expr.Diff -> Format.fprintf f "(not (eq? %a %a))" self#expr a self#expr b
    | _ -> Format.fprintf f "(%a %a %a)" self#pbinop op self#expr a self#expr b

  method fun_ f params e =
    Format.fprintf f "@[<v 2>(lambda (%a) @\n%a@])@]"
      (Printer.print_list self#binding
      (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b))
      params
      self#expr e

  method header f () = Format.fprintf f "#lang racket
(require racket/block)

(define array_init_withenv (lambda (len f env)
  (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    )))))
(define last-char 0)
(define next-char (lambda () (set! last-char (read-char (current-input-port)))))
(next-char)
(define mread-char (lambda ()
  (let ([ out last-char])
    (block
      (next-char)
      out
    ))))

(define mread-int (lambda ()
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

(define mread-blank (lambda ()
  (if (or (eq? last-char #\\NewLine) (eq? last-char #\\Space) ) (block (next-char) (mread-blank)) '())
))
"
  method skipin f e = Format.fprintf f "(block (mread-blank) %a )" self#expr e

  method read f ty next = match Type.unfix ty with
  | Type.Char -> Format.fprintf f "(%a (mread-char))" self#expr next
  | Type.Integer -> Format.fprintf f "(%a (mread-int))" self#expr next
  | _ -> assert false

  method toplvl_declare f name e = Format.fprintf f "@[<v 2>(define %a %a@])@\n" self#binding name self#expr e

  method toplvl_declarety f name ty =
    match Ast.Type.unfix ty with
    | Type.Struct fields ->
      let fields = List.sort String.compare @$ List.map fst fields in
      Format.fprintf f "@[<v 2>(struct %a (%a)@])@\n"
	self#binding name
	(Printer.print_list (fun f name -> Format.fprintf f "[%s #:mutable]" name)
	   (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)) fields
    | _ -> ()

  method print f e ty =
    Format.fprintf f "(display %a)"
      self#expr e

  method if_ f e1 e2 e3 = Format.fprintf f "@[<v 2>(if %a@\n%a@\n%a)@]" self#expr e1 self#expr e2 self#expr e3

  method funtuple f params e =
    match params with
    | [] -> Format.fprintf f "(lambda () %a)" self#expr e
    | _ -> Format.fprintf f "(lambda (internal_env) (apply (lambda@[ (%a) @\n%a@]) internal_env))"
      (Printer.print_list
         self#binding
         (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)) params
      self#expr e

  method letin f params b  = Format.fprintf f "@[<v 2>(let (%a)@\n%a@])"
    (Printer.print_list
       (fun f (s, a) ->
	 Format.fprintf f "[%a %a]"
	   self#binding s self#expr a
       )
       (fun f pa a pb b -> Format.fprintf f "%a@\n%a" pa a pb b))
    params
    self#expr b

  method block f li = Format.fprintf f "@[<v 2>(block@\n%a@\n)@]"
    (Printer.print_list
       self#expr
       (fun f pa a pb b -> Format.fprintf f "%a@\n%a" pa a pb b)) li

  method tuple f li =
    Format.fprintf f "(list %a)"
      (Printer.print_list self#expr
	 (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)) li

  method apply_nomacros f e li =
    Format.fprintf f "(%a %a)"
      self#expr e
      (Printer.print_list self#expr (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)) li
      

  method letrecin f name params e1 e2 = (* TODO *)
    let e1 = E.fun_ params e1 in
    Format.fprintf f "@[<v 2>(letrec ([%a %a])@\n%a)@]"
      self#binding name
      self#expr e1
      self#expr e2

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

  method arrayaffectin f tab indexes v in_ =
    match List.rev indexes with
    | [] -> assert false
    | hd::tl ->
      let tl = List.rev tl in
      Format.fprintf f "(block (vector-set! %a %a %a) %a)"
	(fun f () -> self#arrayindex f tab tl) ()
	self#expr hd
	self#expr v
	self#expr in_



  method recordaccess f record field  =
    Format.fprintf f "(%s-%s %a)"
      (self#typename_of_field field)
      field self#expr record

  method recordaffectin f record field value in_ =
    Format.fprintf f "(block (set-%s-%s! %a %a) %a)"
      (self#typename_of_field field)
      field
      self#expr record
      self#expr value
      self#expr in_

  method record f li =
    let li = List.sort (fun (_, f1) (_, f2) -> String.compare f1 f2) li in
    let f1 = snd @$ List.hd li in
    Format.fprintf f "(%s %a)"
      (self#typename_of_field f1)
      (Printer.print_list
	 (fun f (expr, field) -> Format.fprintf f "%a" self#expr expr)
	 (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)) li


end

let racketPrinter = new racketPrinter

