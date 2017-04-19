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
    TODO : virer les parametres inutiles des lambdas
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper

let lang = "rkt"

module E = AstFun.Expr
module Type = Ast.Type
module TypeSet = Ast.TypeSet

let format_to_string li =
  let li = List.map (function
      | E.IntFormat -> "~a"
      | E.StringFormat -> "~a"
      | E.CharFormat -> "~c"
      | E.StringConstant s -> String.replace "~" "~~" s) li
  in String.concat "" li

let binopstr = let open Ast.Expr in function
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
    | Eq -> "eq?"
    | Diff -> assert false

let print_lief f = let open Format in function
    | E.Error -> fprintf f "(assert false)"
    | E.Unit -> fprintf f "'()"
    | E.Char c ->
      begin match c with
        | ' ' -> fprintf f "#\\Space"
        | '\n' -> fprintf f "#\\NewLine"
        | x -> if (x >= 'a' && x <= 'z') ||
                  (x >= '0' && x <= '9') ||
                  (x >= 'A' && x <= 'Z')
          then fprintf f "#\\%c" x
          else fprintf f "(integer->char %d)" (int_of_char c)
      end
    | E.String s -> fprintf f "%S" s
    | E.Integer i -> fprintf f "%i" i
    | E.Bool true -> fprintf f "#t"
    | E.Bool false -> fprintf f "#f"
    | E.Enum s -> fprintf f "'%s" s
    | E.Binding s -> print_varname f s
    | E.Nil -> fprintf f "null"

let print_expr macros tyenv e f parent_operator =
  let open Ast.Expr in
  let open AstFun.Expr in
  let open Format in
  match e with
  | Just e -> e f parent_operator
  | Skip -> fprintf f "(mread-blank)"
  | BinOp(a, Diff, b) -> fprintf f "(not (eq? %a %a))" a None b None
  | UnOp (a, Not) -> fprintf f "(not %a)" a None
  | UnOp (a, Neg) -> fprintf f "(- %a)" a None
  | BinOp (a, ((Add | Mul | Or | And) as op), b) when Some op = parent_operator ->
    fprintf f "%a %a" a parent_operator b parent_operator
  | BinOp (a, op, b) ->
    let sop = Some op in
    fprintf f "(%s %a %a)" (binopstr op) a sop b sop
  | Comment (s, c) ->
    let lic = String.split s '\n' in
    fprintf f "%a%a"
      (print_list
         (fun f s -> Format.fprintf f ";%s@\n" s) nosep)
      lic c None
  | Lief l -> print_lief f l
  | ReadIn (ty, a) -> begin match Type.unfix ty with
      | Type.Char -> fprintf f "(%a (mread-char))" a None
      | Type.Integer -> fprintf f "(%a (mread-int))" a None
      | _ -> assert false
    end
  | If (a, b, c) -> fprintf f "@[(if %a@\n%a@\n%a)@]" a None b None c None
  | Block li -> fprintf f "@[<v 2>(block@\n%a@\n)@]" (print_list (fun f e -> e f None) sep_nl) li
  | Print (x, ty) -> fprintf f "(display %a)" x None
  | Apply(fu, []) -> fprintf f "(%a 'nil)" fu None
  | Apply(fu, li) -> fprintf f "(%a %a)" fu None (print_list (fun f e -> e f None) sep_space) li
  | ApplyMacro(m, li) ->
    let t, params, code = Ast.BindingMap.find m macros in
    pmacros f "(%s)" t params code li None
  | Tuple li -> fprintf f "(list %a)" (print_list (fun f e -> e f None) sep_space) li
  | RecordAffect (r, field, e) -> fprintf f "(set-%s-%s! %a %a)"
                                    (Typer.typename_for_field field tyenv) field r None e None
  | RecordAccess (e, field) -> fprintf f "(%s-%s %a)"
                                 (Typer.typename_for_field field tyenv) field e None
  | ArrayAffect (a, li, e) ->
    begin match List.rev li with
      | hd::tl ->
        fprintf f "(vector-set! %a %a %a)"
          (List.fold_left (fun acc e f _ -> Format.fprintf f "(vector-get %a %a)" acc None e None) a tl) None
          hd None
          e None
      | _ -> assert false
    end
  | MultiPrint (formats, exprs) ->
    fprintf f "(printf %S %a)"
      (format_to_string formats)
      (print_list (fun f (a, ty) -> a f None) sep_space) exprs
  | ArrayInit (len, lambda) -> fprintf f "(build-vector %a %a)" len None lambda None
  | ArrayMake (len, lambda, env) -> fprintf f "(array_init_withenv %a %a %a)" len None lambda None env None
  | Record li ->
    let li = List.sort (fun (_, f1) (_, f2) -> String.compare f1 f2) li in
    let f1 = snd @$ List.hd li in
    fprintf f "(%s %a)"
      (Typer.typename_for_field f1 tyenv)
      (print_list
         (fun f (expr, field) -> expr f None)
         sep_space) li
  | ArrayAccess (a, li) ->
    List.fold_right (fun e acc f _ -> fprintf f "(vector-ref %a %a)" acc None e None) li a f None
  | FunTuple ([], e)
  | Fun ([], e) -> fprintf f "@[<v 2>(lambda (_) @\n%a@])@]" e None
  | Fun (params, e) -> fprintf f "@[<v 2>(lambda (%a) @\n%a@])@]" (print_list print_varname sep_space) params e None

  | FunTuple (params, e) -> fprintf f "(lambda (internal_env) (apply (lambda@[ (%a) @\n%a@]) internal_env))"
                              (print_list print_varname sep_space) params e None
  | LetIn (a, b, c) -> fprintf f "@[(let ([%a %a])@\n%a@])" print_varname a b None c None
  | LetRecIn(name, params, e1, e2) ->
    let params = if params = [] then [Ast.UserName "_"] else params in
    fprintf f "@[<v 2>(letrec ([%a (lambda (%a) %a)])@\n%a)@]"
      print_varname name
      (print_list print_varname sep_space) params
      e1 None e2 None

let print_expr macros tyEnv f e =
  let macros = Ast.BindingMap.map (fun (ty, params, li) ->
      ty, params,
      try List.assoc lang li
      with Not_found -> List.assoc "" li) macros
  in AstFun.Expr.Fixed.Deep.fold (print_expr macros tyEnv) e f None

let header array_make f opts =
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

let prog typerEnv (f:Format.formatter) (prog:AstFun.prog) =
    let toplvl_declare macros f name e =
      match E.unfix e with
      | E.Fun (params, e) ->
        let params = if params = [] then [Ast.UserName "_"] else params in
        Format.fprintf f "@[<v2>(define (%a %a)@\n%a@]@\n)@\n" print_varname name
          (print_list print_varname sep_space) params
          (print_expr macros typerEnv) e
      | _ -> Format.fprintf f "@[<v2>(define %a@\n%a@]@\n)@\n" print_varname name (print_expr macros typerEnv) e in
    let toplvl_declarety f name ty =
    match Ast.Type.unfix ty with
    | Type.Struct fields ->
      let fields = List.sort String.compare @$ List.map fst fields in
      Format.fprintf f "@[<v 2>(struct %s (%a)@])@\n" name
        (print_list (fun f name -> Format.fprintf f "[%s #:mutable]" name)
           sep_space) fields
    | _ -> () in
    let macros, liitems = List.fold_left (fun (macros, liitems) -> function
        | AstFun.Declaration (name, e) -> macros, (fun f -> toplvl_declare macros f name e) :: liitems
        | AstFun.DeclareType (name, ty) -> macros, (fun f -> toplvl_declarety f name ty) :: liitems
        | AstFun.Macro (name, t, params, code) ->
          let macros = Ast.BindingMap.add name (t, params, code) macros in
          macros, liitems
      ) (Ast.BindingMap.empty, []) prog.AstFun.declarations
    in
    let array_make = AstFun.existsExpr (fun e ->match E.unfix e with
        | E.ArrayMake _ -> true
        | _ -> false ) prog.AstFun.declarations in
    Format.fprintf f "%a%a" (header array_make) prog.AstFun.options
      (print_list (fun f g -> g f) sep_nl) (List.rev liitems)
