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



(*
TODO
les inputs et outputs
les boucles for
les returns
les tableaux
*)
open Stdlib
open Ast
open Printer

class ['lex] schemePrinter = object(self)
  inherit ['lex] printer as super

  method lang () = "scheme"

  val mutable nlet = 0

  method char f c =
    Format.fprintf f "(integer->char %d)" (int_of_char c)

  method allocarray_lambda f binding type_ len binding2 lambda =
    let () = nlet <- nlet + 1 in
    Format.fprintf f "@[<h>(let@\n ((%a@ (@[<v 2>make-initialized-vector@\n%a@\n(lambda (%a)@\n%a)@\n@])))"
      self#binding binding
      self#expr len
      self#binding binding2
      self#bloc lambda

  method stdin_sep f =
    Format.fprintf f "@[(read-blank)@]"

  method read f t mutable_ =
    match Type.unfix t with
      | Type.Integer ->
        self#affect f mutable_ (Expr.call "read-int" [])
      | Type.Char ->
        self#affect f mutable_ (Expr.call "stdin 'readchar-skip" [])
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
        Format.fprintf f "@[<h>%a.%a@]" (* TODO*)
          self#mutable_ mutable_
          self#field field
      | Mutable.Array (mut, indexes) ->
        Format.fprintf f "@[<h>%a %a %a)@]"
          (print_list
             (fun f _ -> Format.fprintf f "(vector-ref")
             (fun f f1 e1 f2 e2 -> ()
             )) indexes
          self#mutable_ mut
          (print_list
             self#expr
             (fun f f1 e1 f2 e2 ->
               Format.fprintf f "%a %a)"
                 f1 e1
                 f2 e2
             )) indexes

  method binding f i = Format.fprintf f "%s" i

  method print_proto f (funname, t, li) =
    Format.fprintf f "(%a %a)"
      self#funname funname
      (print_list
   (fun f (n, t) ->
     self#binding f n)
   (fun t f1 e1 f2 e2 -> Format.fprintf t
     "%a@ %a" f1 e1 f2 e2)) li

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>(define@ %a@\n%a)@]@\n"
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


  method expr f t =
    let binop op a b = Format.fprintf f "(%a@ %a@ %a)" self#print_op op self#expr a self#expr b
    in
    let t = Expr.unfix t in
    match t with
    | Expr.Bool b -> self#bool f b
    | Expr.UnOp (a, op) -> self#unop f op a
    | Expr.BinOp (a, op, b) -> binop op a b
    | Expr.Integer i -> Format.fprintf f "%i" i
    | Expr.Float i -> self#float f i
    | Expr.String i -> self#string f i
    | Expr.Access a -> self#access f a
    | Expr.Call (funname, li) -> self#apply f funname li
    | Expr.Length (tab) ->
      self#length f tab
    | Expr.Char (c) -> self#char f c


  method apply (f:Format.formatter) (var:funname) (li:'lex Expr.t list) : unit =
    match BindingMap.find_opt var macros with
      | Some ( (t, params, code) ) ->
  self#expand_macro_apply f var t params code li
      | None ->
    Format.fprintf
      f
      "(%a %a)"
    self#funname var
    (print_list
       self#expr
       (fun t f1 e1 f2 e2 ->
         Format.fprintf t "%a@ %a" f1 e1 f2 e2
       )
    ) li

  method call (f:Format.formatter) (var:funname) (li:'lex Expr.t list) : unit =
    self#apply f var li

  method print f t expr =
    Format.fprintf f "@[(display@ %a)@]" self#expr expr

  method declaration f var t e =
    let () = nlet <- nlet + 1 in
    Format.fprintf f "@[<v2>(let @[<h>((%a@ %a))@]"
      self#binding var
      self#expr e


  method whileloop f expr li =
    Format.fprintf f "@[<h>(do () %a@]@\n@[<v 2>  %a@]@\n)"
      self#expr expr
      self#bloc li

  method affect f mutable_ expr =
    match Mutable.unfix mutable_ with
      | Mutable.Var binding ->
        Format.fprintf f "@[<h>(set!@ %a@ %a)@]"
          self#binding binding self#expr expr
      | Mutable.Array (mut, li) ->
        match List.rev li with
          | [hd] ->
            Format.fprintf f
            "@[<h>(vector-set! %a %a)@]"
              self#mutable_ mut
              self#expr hd
          | hd::tl ->
            Format.fprintf f
            "@[<h>(vector-set! %a %a)@]"
              self#mutable_ (Mutable.Array (mut, (List.rev tl)) |> Mutable.fix)
              self#expr hd
          | _ -> assert false

  method return f e =
    Format.fprintf f "@[<h>%a@]" self#expr e

  method bloc f li =
    let exnlet = nlet in
    begin
      nlet <- 0;
      Format.fprintf f "@[<v 2>(begin@\n%a@]@\n)"
  (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
    "%a@\n%a" f1 e1 f2 e2)) li;
      for i = 1 to nlet do
  Format.fprintf f ")@]";
      done;
      nlet <- exnlet;
    end

  method prog f (prog:'lex Prog.t) =
    Format.fprintf f
      "

(define (make-initialized-vector len fun)
  (let ((out (make-vector len)) (i 0))
    (while (not (= i len))
           (begin
             (vector-set! out i (fun i))
             (set! i (+ 1 i ))
             )
           )
    out
    )
  )

(define stdin
  (let ((char #f))
    (lambda (word)
      (begin
        (display word)
        (newline)
        (cond
       ((eq? word 'read)
        (if char
            char
            (begin
              (set! char (read-char))
              (display \"stdin 'read =\")
              (display (char->integer char))
              (newline)
              char
              )
            )
        )
       ((eq? word 'skip)
        (set! char #f)
        )
       ((eq? word 'eof)
        (eof-object? char)
        )
       ((eq? word 'readchar-skip)
        (let ((out (stdin 'read)))
          (begin
            (stdin 'skip)
            out))
        )
       )
        )
      ))
  )



(define (read-int)
  (let ((out 0) (l 1))
    (begin
      (display \"read_int\")
      (newline)
      (while (= l 1)
        (let ((c (stdin 'read)))
          (cond
           ((eof-object? c)
            (begin
              (set! l 2)
              (display \"EOF\")
              (newline)
              ))
           ((and
             (<= (char->integer c) 57)
             (>= (char->integer c) 48)
             )
            (begin
              (stdin 'skip)
              (set! out (+ (* 10 out) (- (char->integer c) 48) ))
              ))
           (#t
            (set! l 2)
            ))
          )
        )
      (display \"out=\")
      (display out)
      (newline)
      out)
    ))

(define (read-blank)
  (let ((out 0) (l 1))
    (begin
      (display \"read_blank\")
      (newline)
      (while (= l 1)
        (let ((c (stdin 'read)))
          (cond
           ((eof-object? c) (begin (set! l 2) (display \"EOF\") (newline)))
           ((let ((i (char->integer c))) (or (= i 10) (= i 13) (= i 32) ))
            (stdin 'skip))
           (#t (set! l 2))
           ))))))


%a" super#prog prog

  method main f main =
    self#bloc f main


  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
	| Expr.Add -> "+"
	| Expr.Sub -> "-"
	| Expr.Mul -> "*"
	| Expr.Div -> "/"
	| Expr.Mod -> "mod"
	| Expr.Or -> "or"
	| Expr.And -> "and"
	| Expr.Lower -> "<"
	| Expr.LowerEq -> "<="
	| Expr.Higher -> ">"
	| Expr.HigherEq -> ">="
	| Expr.Eq -> "=="
	| Expr.Diff -> "!="
	| Expr.BinOr -> "lor"
	| Expr.BinAnd -> "land"
	| Expr.RShift -> "lsl"
	| Expr.LShift -> "lsr"
      )


end
