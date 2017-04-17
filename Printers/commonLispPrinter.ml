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

let print_mut tyenv f m = Mutable.Fixed.Deep.fold (print_mut0 tyenv) m f ()

let p_record tyenv f li =
  let open Format in
  let t = Typer.typename_for_field (fst (List.hd li) ) tyenv in
  fprintf f "(make-%s @[<v>%a@])" t
    (print_list (fun f (name, (_, x)) ->
         fprintf f ":%s %a" name x None) sep_space) li
let print_lief f l =
  let open Expr in   
  let open Format in
  match l with
  | Char c -> p_char f c
  | String s -> p_string f s
  | Bool true -> fprintf f "t"
  | Bool false -> fprintf f "nil"
  | Integer i -> fprintf f "%i" i
  | Enum e -> fprintf f "'%s" e
  | Nil -> fprintf f "nil"

let pcall f func li macros =
  let li = List.map snd li in
  begin match StringMap.find_opt func macros with
    | Some ( (t, params, code) ) ->
      pmacros f "%s" t params code li None
    | None -> Format.fprintf f "(%s %a)" func (print_list (fun f x -> x f None) sep_space) li
  end
  
let print_expr0 macros tyenv (annot:int) e =
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
      | Lief l -> print_lief f l
      | Access m -> print_mut tyenv f m
      | Call (func, li) -> pcall f func li macros
      | Tuple _
      | Lexems _ -> assert false
      | Record li -> p_record tyenv f li
    ) in annot, lambda

let print_printable f = function
  | Ast.Instr.StringConst s -> print_lief f (Ast.Expr.String s)
  | Ast.Instr.PrintExpr (_, (_, e)) -> e f None

let print_expr0 macros tyenv e = Expr.Fixed.Deep.folda (print_expr0 macros tyenv) e
let print_expr macros tyenv e f () =
  let _, b = print_expr0 macros tyenv e
  in b f None



let print_instr =
  let iblocname = ref 0 in
  fun tyenv macros i ->
  let open Ast.Instr in
  let open Format in
  let affectop f m = match Mutable.unfix m with
    | Mutable.Array _ | Mutable.Dot _ -> fprintf f "setf"
    | Mutable.Var _ ->  fprintf f "setq" in
  let mutable_set f m = print_mut tyenv f m in
  let instructions funname f li = print_list (fun f (_, g) -> g f funname) sep_nl f li in
  let bloc f li funname =
    match li with
    | [nlet, instr] ->
      begin
        fprintf f "@[<v 2>%a@]" instr funname;
        for i = 1 to nlet do
          fprintf f ")@]";
        done;
      end
    | _ ->
      let nlet = List.fold_left (+) 0 (List.map fst li) in
      begin
        fprintf f "@[<v 2>(progn@\n%a@]@\n)" (instructions funname) li;
        for i = 1 to nlet do
          fprintf f ")@]";
        done;
      end
  in
  let blocnonnull funname f = function
    | [] -> fprintf f "'()"
    | li -> bloc f li funname
  in
  let blocnamed f li =
    incr iblocname;
    let nlet = List.fold_left (+) 0 (List.map fst li) in
    let funname = "lambda_" ^ (string_of_int (!iblocname)) in
    fprintf f "@[<v 2>(block %s@\n%a@]@\n)" funname (instructions funname) li;
    for i = 1 to nlet do
      fprintf f ")@]";
    done
  in
  let noformat s = let s = sprintf "-%s-" s
    in List.fold_left (fun s (from, to_) -> String.replace from to_ s) s
      ["~", "~~"; "\n", "~%"] in
 let formater_type t = match Type.unfix t with
    | Type.Integer -> "~D"
    | Type.Char -> "~C"
    | Type.String ->  "~A"
    | _ -> raise (Warner.Error (fun f -> fprintf f "invalid type %s for format\n" (Type.type_t_to_string t))) in
  let count_let = match i with
    | AllocRecord _ | AllocArray _ | Declare _ -> 1
    | Read li -> List.fold_left (fun acc -> function
                                        | Separation | ReadExpr _ -> acc
                                        | DeclRead _ -> acc + 1) 0 li
    | _ -> 0
  in
  let p f funname = match i with
    | Declare (var, ty, (_, e), _) -> fprintf f "@[<v2>(let @[<h>((%a@ %a))@]" print_varname var e None
    | SelfAffect (mut, op, (_, e)) -> assert false
    | Affect (mut, (_, e)) -> fprintf f "@[<h>(%a@ %a@ %a)@]" affectop mut mutable_set mut e None
    | ClikeLoop (init, cond, incr, li) -> assert false
    | Loop (var, (_, e1), (_, e2), li) ->
      fprintf f "@[<v 2>(loop for %a from %a to %a do@\n%a)@]"
      print_varname var
      e1 None e2 None
      (blocnonnull funname) li
    | While ( (_,e), li) -> fprintf f "@[<h>(loop while %a@]@\ndo @[<v 2>%a@]@\n)" e None
                              (blocnonnull funname) li
    | Comment s -> fprintf f "#|%s|#" s
    | Tag s -> assert false
    | Return (_,e) -> fprintf f "@[<h>(return-from %s %a)@]" funname e None
    | AllocArray (name, t, (_,e), None, opt) -> assert false
    | AllocArray (name, t, (_,e), Some (binding, li), opt) ->
      fprintf f "@[<h>(let@\n ((%a@ (@[<v 2>array_init@\n%a@\n(function (lambda (%a)@\n%a)@\n@]))))"
      print_varname name e None
      print_varname binding
      blocnamed li
    | AllocArrayConst (name, ty, len, lief, opt) -> assert false
    | Print [i] ->
      fprintf f "@[(princ %a)@]" print_printable i
    | Print li ->
      let format, li = extract_multi_print noformat formater_type li in
      fprintf f "@[(format t %a %a)@]"
        p_string format
        (print_list (fun f (_, (_, e)) -> e f None) sep_space) li
    | If ((_,e), listif, listelse) ->
      fprintf f "@[<v 2>(if@\n%a@\n%a)@]" e None (print_list (blocnonnull funname)(sep "%a@\n%a"))
        [listif; listelse]
    | Call (func, li) -> pcall f func li macros
    | Read li ->
      print_list
        (fun f -> function
           | Separation -> fprintf f "@[(mread-blank)@]"
           | DeclRead (ty, v, opt) ->
             begin match Ast.Type.unfix ty with
               | Type.Integer -> fprintf f "@[<v2>(let @[<h>((%a@ (mread-int)))@]" print_varname v
               | Type.Char -> fprintf f "@[<v2>(let @[<h>((%a@ (mread-char)))@]" print_varname v
               | _ -> assert false
             end
           | ReadExpr (ty, mut) ->
             begin match Ast.Type.unfix ty with
               | Type.Integer -> fprintf f "@[<h>(%a@ %a@ (mread-int))@]" affectop mut mutable_set mut
               | Type.Char -> fprintf f "@[<h>(%a@ %a@ (mread-char))@]" affectop mut mutable_set mut
               | _ -> assert false
             end) sep_nl f li
    | AllocRecord (name, ty, list, opt) -> fprintf f "(let ((%a %a))" print_varname  name (p_record tyenv) list
    | Incr _ | Decr _
    | Untuple _
    | Unquote _ -> assert false
  in count_let, p
(*
let print_instr tyenv macros i f funname =
  let open Ast.Instr.Fixed.Deep in
  let i =  mapg (print_expr0 macros tyenv) i in
  let nlet, p = (fold (print_instr tyenv macros) i)
  in p f funname;
  for i = 1 to nlet do
    Format.fprintf f ")@]";
  done
            *)

let print_instrs tyenv macros i f funname =
  let open Ast.Instr.Fixed.Deep in
  let i =  List.map (mapg (print_expr0 macros tyenv)) i in
  let i = List.map (fold (print_instr tyenv macros)) i in
  let nlet = List.fold_left (+) 0 (List.map fst i) in
  print_list (fun f (_,  g) -> g f funname) sep_nl f i;
  for i = 1 to nlet do
    Format.fprintf f ")@\n@]";
  done

let prog typerEnv f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    let instructions macros funname_ f li =
      let macros = StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc "clisp" li
        with Not_found -> List.assoc "" li) macros
      in (print_instrs typerEnv macros li) f funname_ in
    let bloc macros funname_ f li = Format.fprintf f "@[<v 2>(progn@\n%a@]@\n)" (instructions macros funname_) li in
    let macros, items = List.fold_left
        (fun (macros, li) item -> match item with
           | Prog.Macro (name, t, params, code) ->
             StringMap.add name (t, params, code) macros, li
           | Prog.Comment s -> macros, (fun f -> Format.fprintf f "#|%s|#@\n" s) :: li
           | Prog.DeclarFun (funname, t, vars, instrs, _opt) ->
             macros, (fun f -> Format.fprintf f "@[<h>(defun@ %s (%a)@\n%a)@]@\n"
               funname
               (print_list print_varname sep_space) (List.map fst vars)
               (bloc macros funname) instrs) :: li
           | Prog.DeclareType (name, t) ->
             macros, (fun f ->
               match (Type.unfix t) with
               | Type.Struct li ->
                 Format.fprintf f "(defstruct (%s (:type list) :named)@\n  @[<v>%a@])@\n"
                   name
                   (print_list
                      (fun t (name, type_) ->
                         Format.fprintf t "%s@\n" name
                      ) nosep
                   ) li
               | Type.Enum li -> ()
               | _ -> assert false
             ) :: li
           | _ -> macros, li
      ) (StringMap.empty, []) prog.Prog.funs in
    
    Format.fprintf f "%s%s%s%s%s%s%s%a%a@\n"
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
      (print_list (fun f g -> g f) sep_nl) (List.rev items)
      (print_option (bloc macros "main")) prog.Prog.main

