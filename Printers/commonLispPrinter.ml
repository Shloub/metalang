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

(** scheme Printer
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Printer

class commonLispPrinter = object(self)
  inherit printer as super

  method lang () = "clisp"

  method char f c = match c with
	| ' ' -> Format.fprintf f "#\\Space"
	| '\n' -> Format.fprintf f "#\\NewLine"
	| x -> if (x >= 'a' && x <= 'z') or
			(x >= '0' && x <= '9') or
			(x >= 'A' && x <= 'Z') 
		then Format.fprintf f "#\\%c" x
    else Format.fprintf f "(int-char %d)" (int_of_char c)

  method string f s =
		let s = String.replace "\\\"" "\\\\\"" s in
		Format.fprintf f "\"%s\"" s

	method affectop f m = match Mutable.unfix m with
	| Mutable.Array _ | Mutable.Dot _ -> Format.fprintf f "setf"
	| Mutable.Var _ ->  Format.fprintf f "setq"

	val mutable iblocname = 0
  val mutable funname_ = ""
  val mutable nlet = 0

  method comment f str = Format.fprintf f "#|%s|#" str

  method selfAssoc f m e2 = function
  | Expr.Add -> Format.fprintf f "@[<h>(%a %a ( + %a %a))@]" self#affectop m self#mutable_ m self#mutable_ m self#expr e2
  | Expr.Sub -> Format.fprintf f "@[<h>(%a %a ( - %a %a))@]" self#affectop m self#mutable_ m self#mutable_ m self#expr e2
  | Expr.Mul -> Format.fprintf f "@[<h>(%a %a ( * %a %a))@]" self#affectop m self#mutable_ m self#mutable_ m self#expr e2
  | Expr.Div -> Format.fprintf f "@[<h>(%a %a ( quotient %a %a))@]" self#affectop m self#mutable_ m self#mutable_ m self#expr e2
  | _ -> assert false


  method allocarray_lambda f binding type_ len binding2 lambda =
    let () = nlet <- nlet + 1 in
    Format.fprintf f "@[<h>(let@\n ((%a@ (@[<v 2>array_init@\n%a@\n(function (lambda (%a)@\n%a)@\n@]))))"
      self#binding binding
      self#expr len
      self#binding binding2
      self#blocnamed lambda

  method stdin_sep f =
    Format.fprintf f "@[(mread-blank)@]"

  method read_decl f t v =
    match Type.unfix t with
      | Type.Integer ->
        self#declaration f v t (Expr.call "mread-int" [])
      | Type.Char ->
        self#declaration f v t (Expr.call "mread-char" [])
      | _ -> assert false

  method read f t mutable_ =
    match Type.unfix t with
      | Type.Integer ->
        self#affect f mutable_ (Expr.call "mread-int" [])
      | Type.Char ->
        self#affect f mutable_ (Expr.call "mread-char" [])
      | _ -> assert false

  method instructions f instrs =
    (print_list
       self#instr
       (fun t print1 item1 print2 item2 ->
         Format.fprintf t "%a@\n%a" print1 item1 print2 item2
       )
    ) f instrs

  method mutable_ f m =
    match m |> Mutable.unfix with
      | Mutable.Var binding ->
        self#binding f binding
      | Mutable.Dot (mutable_, field) ->
        Format.fprintf f "@[<h>(%s-%a %a)@]"
					(self#typename_of_field field)
          self#field field
					self#mutable_ mutable_
      | Mutable.Array (mut, indexes) ->

				List.fold_left (fun func e f () ->
					Format.fprintf f "(aref %a %a)"
						func ()
						self#expr e
				)
					(fun f () -> self#mutable_ f mut)
					indexes
					f
					()

  method binding f i = Format.fprintf f "%s" i

  method print_proto f (funname, t, li) =
		funname_ <- funname;
    Format.fprintf f "%a (%a)"
      self#funname funname
      (print_list
   (fun f (n, t) ->
     self#binding f n)
   (fun t f1 e1 f2 e2 -> Format.fprintf t
     "%a@ %a" f1 e1 f2 e2)) li

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>(defun@ %a@\n%a)@]@\n"
      self#print_proto (funname, t, li)
      self#bloc instrs


  method if_ f e ifcase elsecase =
    match elsecase with
      | [] ->
  Format.fprintf f "@[<v 2>(if@\n%a@\n%a)@]"
    self#expr e
    self#bloc ifcase
      | _ ->
  Format.fprintf f "@[<v 2>(if@\n%a@\n%a@\n%a)@]"
    self#expr e
    self#bloc ifcase
    self#bloc elsecase


  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<v 2>(do@\n@[<h>((%a %a (+ 1 %a)))@]@\n@[<h>((> %a@ %a))@]@\n%a@]@\n)"
      self#binding varname
      self#expr expr1
      self#binding varname
      self#binding varname
      self#expr expr2
      self#bloc li

  method unop f op a = match op with
    | Expr.Neg -> Format.fprintf f "(- 0 %a)" self#expr a
    | Expr.Not -> Format.fprintf f "(not %a)" self#expr a

  method expr f t =
    let binop op a b = Format.fprintf f "@[<h>(%a@ %a@ %a)@]" self#print_op op self#expr a self#expr b
    in
    let t = Expr.unfix t in
    match t with
    | Expr.Bool b -> self#bool f b
    | Expr.UnOp (a, op) -> self#unop f op a
    | Expr.BinOp (a, op, b) -> binop op a b
    | Expr.Integer i -> Format.fprintf f "%i" i
    | Expr.String i -> self#string f i
    | Expr.Access a -> self#access f a
    | Expr.Call (funname, li) -> self#apply f funname li
    | Expr.Char (c) -> self#char f c
    | Expr.Enum e -> Format.fprintf f "'%s" e
    | Expr.Lexems e -> assert false
    | Expr.Record e -> self#record f e

  method apply (f:Format.formatter) (var:funname) (li:Utils.expr list) : unit =
    match BindingMap.find_opt var macros with
      | Some ( (t, params, code) ) ->
  self#expand_macro_apply f var t params code li
      | None ->
    Format.fprintf
      f
      "@[<h>(%a %a)@]"
    self#funname var
    (print_list
       self#expr
       (fun t f1 e1 f2 e2 ->
         Format.fprintf t "%a@ %a" f1 e1 f2 e2
       )
    ) li

  method call (f:Format.formatter) (var:funname) (li:Utils.expr list) : unit =
    self#apply f var li

  method print f t expr =
    Format.fprintf f "@[(princ@ %a)@]" self#expr expr

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
      )
      (fun t f1 e1 f2 e2 ->
	Format.fprintf t
	  "%a@\n%a" f1 e1 f2 e2)
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
      (self#def_fields "") el

  method whileloop f expr li =
    Format.fprintf f "@[<h>(loop while %a@]@\ndo @[<v 2>%a@]@\n)"
      self#expr expr
      self#bloc li

  method affect f mutable_ expr =
      Format.fprintf f "@[<h>(%a@ %a@ %a)@]" self#affectop mutable_ self#mutable_ mutable_ self#expr expr

  method return f e =
    Format.fprintf f "@[<h>(return-from %s %a)@]" funname_ self#expr e

  method bool f = function
    | true -> Format.fprintf f "t"
    | false -> Format.fprintf f "nil"

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
    | _ ->
    let exnlet = nlet in
    begin
      nlet <- 0;
      Format.fprintf f "@[<v 2>(progn@\n%a@]@\n)"
  (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
    "%a@\n%a" f1 e1 f2 e2)) li;
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
  (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
    "%a@\n%a" f1 e1 f2 e2)) li;
      for i = 1 to nlet do
  Format.fprintf f ")@]";
      done;
      nlet <- exnlet;
			funname_ <- exname;
    end

(* TODO n'afficher array_init que quand on en a besoin *)
  method prog f (prog:Utils.prog) =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))
(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))
(defun not-equal (a b) (not (eq a b)))
%s%s%s%s%a"
      (if need then
      "(let ((last-char 0)))
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
      (while (and last-char (>= (char-int last-char) (char-int #\\0)) (<= (char-int last-char) (char-int #\\9)))
        (progn
          (setq out (+ (* 10 out) (- (char-int last-char) (char-int #\\0))))
          (next-char)
        )
      )
      out
    ))))
" else "")
      (if need_stdinsep then
"(defun mread-blank () (progn
  (while (or (eq last-char #\\NewLine) (eq last-char #\\Space) ) (next-char))
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
	| Expr.Eq -> "eq"
	| Expr.Diff -> "not-equal"
      )

  method decl_type f name t =
        match (Type.unfix t) with
	        | Type.Struct li ->
	          Format.fprintf f "(defstruct (%a (:type list) :named)@\n  @[<v>%a@])@\n"
	            self#binding name
	            (print_list
	               (fun t (name, type_) ->
	                 Format.fprintf t "%a@\n" self#binding name
	               )
	               (fun t fa a fb b -> Format.fprintf t "%a%a" fa a fb b)
	            ) li
          | Type.Enum li -> ()
          | _ ->
            Format.fprintf f "type %a = %a;" self#binding name self#ptype t

end
