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

let print_mut0 tyenv m f () =
  let open Format in
  let open Ast.Mutable in match m with
  | Var v -> print_varname f v
  | Array (m, fi) ->
    List.fold_left (fun t (_, param) f () -> fprintf f "(aref %a %a)" t () param None) m fi f ()
  | Dot (m, field) -> fprintf f "(%s-%s %a)" (Typer.typename_for_field field tyenv) field m ()

let p_char f c = let open Format in match c with
  | ' ' -> fprintf f "#\\Space"
  | '\n' -> fprintf f "#\\NewLine"
  | x -> if (x >= 'a' && x <= 'z') ||
            (x >= '0' && x <= '9') ||
            (x >= 'A' && x <= 'Z')
    then fprintf f "#\\%c" x
    else fprintf f "(code-char %d)" (int_of_char c)

let  is_char_printable_instring c =
  let i = int_of_char c in
  c == '\n' || (i > 30 && i < 127 && c != '"' && c != '\\')

let p_string f s = let open Format in
  if String.for_all is_char_printable_instring s then
    fprintf f "\"%s\"" (String.replace "\"" "\\\"" s)
  else
    fprintf f "(format nil \"%a\"%a)"
      (fun f s ->
         String.iter (fun c -> if is_char_printable_instring c
                       then fprintf f "%c" c
                       else fprintf f "~C") s
      ) s
      (fun f s ->
         String.iter (fun c -> if not(is_char_printable_instring c)
                       then fprintf f " %a" p_char c) s
      ) s

let print_expr0 macros tyenv (annot:int) e =
  let print_mut tyenv f m = Mutable.Fixed.Deep.fold (print_mut0 tyenv) m f () in
  let open Expr in   
  let open Format in
  let binopstr = function
    | Add -> "+"
    | Sub -> "-"
    | Mul -> "*"
    | Div -> "quotient"
    | Mod -> "remainder"
    | Or -> "or"
    | And -> "and"
    | Lower -> "<"
    | LowerEq -> "<="
    | Higher -> ">"
    | HigherEq -> ">="
    | _ -> assert false in
  let lambda = (fun f parent_operator ->
      match e with
      | BinOp ((annota, a), Eq, (_, b)) ->
        if Typer.is_int_a tyenv annota then fprintf f "@[<h>(= %a@ %a)@]" a None b None
        else fprintf f "@[<h>(eq %a@ %a)@]" a None b None
      | BinOp ((annota, a), Diff, (_, b)) ->
        if Typer.is_int_a tyenv annota then fprintf f "@[<h>(not (= %a@ %a))@]" a None b None
        else fprintf f "@[<h>(not (eq %a@ %a))@]" a None b None
      | BinOp ((_, a), ((Add | Mul | Or | And) as op), (_, b)) when Some op = parent_operator ->
        fprintf f "%a %a" a parent_operator b parent_operator
      | BinOp ((_, a), op, (_, b)) ->
        let sop = Some op in
        fprintf f "(%s %a %a)" (binopstr op) a sop b sop
      | UnOp ((_, a), Not) -> fprintf f "(not %a)" a None
      | UnOp ((_, a), Neg) -> fprintf f "(- 0 %a)" a None
      | Lief l -> begin match l with
          | Char c -> p_char f c
          | String s -> p_string f s
          | Bool true -> fprintf f "t"
          | Bool false -> fprintf f "nil"
          | Integer i -> fprintf f "%i" i
          | Enum e -> fprintf f "'%s" e
        end
      | Access m -> print_mut tyenv f m
      | Call (func, li) ->
        let li = List.map snd li in
        begin match StringMap.find_opt func macros with
          | Some ( (t, params, code) ) ->
            pmacros f "%s" t params code li None
          | None -> fprintf f "(%s %a)" func (print_list (fun f x -> x f None) sep_space) li
        end
      | Tuple _
      | Lexems _ -> assert false
      | Record li ->
        let t = Typer.typename_for_field (fst (List.hd li) ) tyenv in
        fprintf f "(make-%s @[<v>%a@])" t
          (print_list (fun f (name, (_, x)) ->
               fprintf f ":%s %a" name x None) sep_c) li
    ) in annot, lambda


let print_expr tyenv macros e f () = ( snd (Expr.Fixed.Deep.folda (print_expr0 tyenv macros) e) ) f None

class commonLispPrinter = object(self)
  inherit Printer.printer as super

  method lang () = "clisp"

  method expr f e = print_expr
      (StringMap.map (fun (ty, params, li) ->
           ty, params,
           try List.assoc (self#lang ()) li
           with Not_found -> List.assoc "" li) macros) (self#getTyperEnv ()) e f ()

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

  method apply (f:Format.formatter) (var:funname) (li:Utils.expr list) : unit =
    match StringMap.find_opt var macros with
    | Some _ -> super#apply f var li
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

  method formater_type t = match Type.unfix t with
    | Type.Integer -> "~D"
    | Type.Char -> "~C"
    | Type.String ->  "~A"
    | _ -> raise (Warner.Error (fun f -> Format.fprintf f "invalid type %s for format\n" (Type.type_t_to_string t)))

  method noformat s = let s = Format.sprintf "-%s-" s
    in List.fold_left (fun s (from, to_) -> String.replace from to_ s) s
      ["~", "~~"; "\n", "~%"]

  method multi_print f li =
    let format, exprs = self#extract_multi_print li in
    Format.fprintf f "@[<v>(format t %a %a)@]"
      p_string format
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
