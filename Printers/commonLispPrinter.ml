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

(** Common lisp Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast
open Printer

class commonLispPrinter = object(self)
  inherit printer as super

  method lang () = "clisp"

  method char f c = match c with
  | ' ' -> Format.fprintf f "#\\Space"
  | '\n' -> Format.fprintf f "#\\NewLine"
  | x -> if (x >= 'a' && x <= 'z') ||
      (x >= '0' && x <= '9') ||
      (x >= 'A' && x <= 'Z')
    then Format.fprintf f "#\\%c" x
    else Format.fprintf f "(code-char %d)" (int_of_char c)

  method string f s =
		let s = List.fold_left (fun s (from, to_) -> String.replace from to_ s) s
			["\\\"", "\\\\\""] in
    Format.fprintf f "\"%s\"" s

  method affectop f m = match Mutable.unfix m with
  | Mutable.Array _ | Mutable.Dot _ -> Format.fprintf f "setf"
  | Mutable.Var _ ->  Format.fprintf f "setq"

  val mutable iblocname = 0
  val mutable funname_ = ""
  val mutable nlet = 0

  method comment f str = Format.fprintf f "#|%s|#" str

  method hasSelfAffect op = false

  method allocarray_lambda f binding type_ len binding2 lambda _ =
    let () = nlet <- nlet + 1 in
    Format.fprintf f "@[<h>(let@\n ((%a@ (@[<v 2>array_init@\n%a@\n(function (lambda (%a)@\n%a)@\n@]))))"
      self#binding binding
      self#expr len
      self#binding binding2
      self#blocnamed lambda

  method stdin_sep f = Format.fprintf f "@[(mread-blank)@]"

  method read_decl f t v =
    match Type.unfix t with
    | Type.Integer -> self#declaration f v t (Expr.call "mread-int" [])
    | Type.Char -> self#declaration f v t (Expr.call "mread-char" [])
    | _ -> assert false

  method read f t mutable_ =
    match Type.unfix t with
    | Type.Integer -> self#affect f mutable_ (Expr.call "mread-int" [])
    | Type.Char -> self#affect f mutable_ (Expr.call "mread-char" [])
    | _ -> assert false


  method m_field f m field =
      Format.fprintf f "@[<h>(%s-%a %a)@]"
        (self#typename_of_field field)
        self#field field
        self#mutable_get m

  method m_array f m indexes =
      List.fold_left (fun func e f () ->
        Format.fprintf f "(aref %a %a)"
          func ()
          self#expr e
      )
        (fun f () -> self#mutable_get f m)
        indexes
        f
        ()

  method print_proto f (funname, t, li) =
    funname_ <- funname;
    Format.fprintf f "%a (%a)"
      self#funname funname
      (print_list self#binding sep_space) (List.map fst li)

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>(defun@ %a@\n%a)@]@\n"
      self#print_proto (funname, t, li)
      self#bloc instrs

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<v 2>(if@\n%a@\n%a)@]"
        self#expr e
        self#blocnonnull ifcase
    | _ ->
      Format.fprintf f "@[<v 2>(if@\n%a@\n%a@\n%a)@]"
        self#expr e
        self#blocnonnull ifcase
        self#bloc elsecase

	method blocnonnull f = function
	| [] -> Format.fprintf f "'()"
	| li -> self#bloc f li

  method forloop f varname expr1 expr2 li =
		Format.fprintf f "@[<v 2>(loop for %a from %a to %a do@\n%a)@]"
			self#binding varname
      self#expr expr1
      self#expr expr2
      self#blocnonnull li

  method unop f op a = match op with
  | Expr.Neg -> Format.fprintf f "(- 0 %a)" self#expr a
  | Expr.Not -> Format.fprintf f "(not %a)" self#expr a

  method expr f t =
    let binop op a b = match op with
      | Expr.Eq ->
        if Typer.is_int (super#getTyperEnv ()) a then
          Format.fprintf f "@[<h>(= %a@ %a)@]" self#expr a self#expr b
        else
          Format.fprintf f "@[<h>(eq %a@ %a)@]"self#expr a self#expr b
      | Expr.Diff ->
        if Typer.is_int (super#getTyperEnv ()) a then
          Format.fprintf f "@[<h>(not (= %a@ %a))@]" self#expr a self#expr b
        else
          Format.fprintf f "@[<h>(not (eq %a@ %a))@]" self#expr a self#expr b
      | _ ->
        Format.fprintf f "@[<h>(%a@ %a@ %a)@]" self#print_op op self#expr a self#expr b
    in
    let t = Expr.unfix t in
    match t with
    | Expr.UnOp (a, op) -> self#unop f op a
    | Expr.BinOp (a, op, b) -> binop op a b
    | Expr.Access a -> self#access f a
    | Expr.Call (funname, li) -> self#apply f funname li
    | Expr.Lexems e -> assert false
    | Expr.Record e -> self#record f e
    | Expr.Lief l -> self#lief f l
    | Expr.Tuple _ -> assert false

  method enum f e = Format.fprintf f "'%s" e

  method apply (f:Format.formatter) (var:funname) (li:Utils.expr list) : unit =
    match StringMap.find_opt var macros with
    | Some ( (t, params, code) ) ->
      self#expand_macro_apply f var t params code li
    | None -> Format.fprintf f "@[<h>(%a %a)@]" self#funname var (print_list self#expr sep_space) li

  method call (f:Format.formatter) (var:funname) (li:Utils.expr list) : unit = self#apply f var li

  method print f t expr = Format.fprintf f "@[(princ %a)@]" self#expr expr

  method declaration f var t e =
    let () = nlet <- nlet + 1 in
    Format.fprintf f "@[<v2>(let @[<h>((%a@ %a))@]"
      self#binding var
      self#expr e

  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
        Format.fprintf f ":%a %a"
          self#field fieldname
          self#expr expr
      ) sep_nl
      f
      li

  method allocrecord f name t el =
    let () = nlet <- nlet + 1 in
    Format.fprintf f "(let ((%a %a))"
      self#binding name
      self#record el

  method record f el =
    let t = Typer.typename_for_field (fst (List.hd el) ) typerEnv in
    Format.fprintf f "(make-%s @[<v>%a@])"
      t
      (self#def_fields (InternalName 0)) el

  method whileloop f expr li =
    Format.fprintf f "@[<h>(loop while %a@]@\ndo @[<v 2>%a@]@\n)"
      self#expr expr
      self#blocnonnull li

  method affect f mutable_ expr =
    Format.fprintf f "@[<h>(%a@ %a@ %a)@]" self#affectop mutable_ self#mutable_set mutable_ self#expr expr

  method return f e =
    Format.fprintf f "@[<h>(return-from %s %a)@]" funname_ self#expr e

  method bool f = function
  | true -> Format.fprintf f "t"
  | false -> Format.fprintf f "nil"

	method formater_type t = match Type.unfix t with
  | Type.Integer -> "~D"
  | Type.Char -> "~C"
  | Type.String ->  "~A"
  | _ -> raise (Warner.Error (fun f -> Format.fprintf f "invalid type %s for format\n" (Type.type_t_to_string t)))

  method noformat s = let s = Format.sprintf "-%s-" s
                      in List.fold_left (fun s (from, to_) -> String.replace from to_ s) s
											["~", "~~"; "\n", "~%"]

	method combine_formats () = true

	method multi_print f format exprs =
		Format.fprintf f "@[<v>(format t %a %a)@]"
			self#string format
      (print_list (fun f (t, e) -> self#expr f e) sep_space) exprs

  method bloc f li =
    match li with
    | [instr] ->
      let exnlet = nlet in
      begin
        nlet <- 0;
        Format.fprintf f "@[<v 2>%a@]" self#instr instr;
        for i = 1 to nlet do
          Format.fprintf f ")@]";
        done;
        nlet <- exnlet;
      end
		| li when (match li with [_] -> false | _ -> true)
				&& List.for_all self#is_print li -> self#instructions f li;
    | _ ->
      let exnlet = nlet in
      begin
        nlet <- 0;
        Format.fprintf f "@[<v 2>(progn@\n%a@]@\n)"
          self #instructions li;
        for i = 1 to nlet do
          Format.fprintf f ")@]";
        done;
        nlet <- exnlet;
      end

  method blocnamed f li =
    let exname = funname_ in
    let exnlet = nlet in
    begin
      nlet <- 0;
      iblocname <- iblocname + 1;
      funname_ <- "lambda_" ^ (string_of_int iblocname);
      Format.fprintf f "@[<v 2>(block %s@\n%a@]@\n)"
        funname_
				self#instructions li;
      for i = 1 to nlet do
        Format.fprintf f ")@]";
      done;
      nlet <- exnlet;
      funname_ <- exname;
    end

  method prog f (prog:Utils.prog) =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "%s%s%s%s%s%s%s%a@\n"
(if Tags.is_taged "__internal__allocArray" then "
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))
" else "")
(if Tags.is_taged "__internal__div" then "\n(defun quotient (a b) (truncate a b))\n" else "")
(if Tags.is_taged "__internal__mod" then "(defun remainder (a b) (- a (* b (truncate a b))))\n" else "")
      (if need then
          "(defvar last-char 0)
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
" else "" )
      (if need_readchar then
          "(defun mread-char ()
  (let (( out last-char))
    (progn
      (next-char)
      out
    )))
" else "")
      (if need_readint then
          "(defun mread-int ()
  (if (eq #\\- last-char)
  (progn (next-char) (- 0 (mread-int)))
  (let ((out 0))
    (progn
      (loop while (and last-char (>= (char-code last-char) (char-code #\\0)) (<= (char-code last-char) (char-code #\\9))) do
        (progn
          (setq out (+ (* 10 out) (- (char-code last-char) (char-code #\\0))))
          (next-char)
        )
      )
      out
    ))))
" else "")
      (if need_stdinsep then
          "(defun mread-blank () (progn
  (loop while (or (eq last-char #\\NewLine) (eq last-char #\\Space) ) do (next-char))
))
" else "")

      super#prog prog

  method main f main =
    self#bloc f main

  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
      | Expr.Add -> "+"
      | Expr.Sub -> "-"
      | Expr.Mul -> "*"
      | Expr.Div -> "quotient"
      | Expr.Mod -> "remainder"
      | Expr.Or -> "or"
      | Expr.And -> "and"
      | Expr.Lower -> "<"
      | Expr.LowerEq -> "<="
      | Expr.Higher -> ">"
      | Expr.HigherEq -> ">="
      | _ -> assert false)

  method decl_type f name t =
    match (Type.unfix t) with
    | Type.Struct li ->
      Format.fprintf f "(defstruct (%a (:type list) :named)@\n  @[<v>%a@])@\n"
        self#typename name
        (print_list
           (fun t (name, type_) ->
             Format.fprintf t "%a@\n" self#field name
           ) nosep
        ) li
    | Type.Enum li -> ()
    | _ ->
      Format.fprintf f "type %a = %a;" self#typename name self#ptype t

end
