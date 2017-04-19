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

(** python Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ext
open Helper
open Ast

let prio_percent_percent = 0

let print_lief prio f l =
  let open Format in
  let open Expr in
  match l with
  | Char c -> unicode f c
  | Enum e -> fprintf f "%S" e
  | Bool true -> fprintf f "True"
  | Bool false -> fprintf f "False"
  | Nil -> fprintf f "None"
  | x -> print_lief prio f x

let config macros =
  let open Format in
  let open Expr in
  let prio_binop op = match op with
    | Mul -> assoc 5
    | Div
    | Mod -> nonassocr 7
    | Add -> assoc 9
    | Sub -> nonassocr 9
    | Lower
    | LowerEq
    | Higher
    | HigherEq
    | Eq
    | Diff -> nonassocl 13
    | And -> assoc 15
    | Or -> assoc 15 in
  let print_op f op =
    fprintf f (match op with
        | Add -> "+"
        | Sub -> "-"
        | Mul -> "*"
        | Div -> "/"
        | Mod -> "%%"
        | Or -> "or"
        | And -> "and"
        | Lower -> "<"
        | LowerEq -> "<="
        | Higher -> ">"
        | HigherEq -> ">="
        | Eq -> "=="
        | Diff -> "!=") in
  let print_unop f op =
    let open Ast.Expr in
    Format.fprintf f (match op with
        | Neg -> "-"
        | Not -> "not ") in
  {
    prio_binop;
    prio_unop;
    print_varname;
    print_lief;
    print_op;
    print_unop;
    print_mut;
    macros
  }

let print_expr config e f p =
  let open Format in
  let open Expr in
  let print_expr0 config e f prio_parent = match e with
    | BinOp (a, (Div as op), b) ->
      let _, priol, prior = prio_binop op in
      fprintf f "math.trunc(%a %a %a)" a priol print_op op b prior
    | BinOp (a, Mod, b) -> fprintf f "mod(%a, %a)" a nop b nop
    | Tuple li -> fprintf f "[%a]" (print_list (fun f x -> x f nop) sep_c) li
    | _ -> print_expr0 config e f prio_parent
  in Fixed.Deep.fold (print_expr0 config) e f p

let print_instr tyenv c i =
  let open Ast.Instr in
  let open Format in
  let block value f li =
    if List.for_all (fun i -> i.is_comment) li then fprintf f "@\npass"
    else fprintf f "@\n%a" (print_list (fun f i -> i.p f (false, value)) sep_nl) li in
  let block_lambda = block true in
  let read t pp f =
    match Type.unfix t with
    | Type.Integer -> fprintf f "@[<h>%a = readint()@]" pp ()
    | Type.Char -> fprintf f "@[<h>%a = readchar()@]" pp ()
    | _ -> assert false (* type non géré*) in
  let p f (inelseif, inlambda) =
    let block = block inlambda in match i with
    | Declare (var, ty, e, _) -> fprintf f "%a = %a" c.print_varname var e nop
    | Incr _ | Decr _ -> assert false
    | SelfAffect (mut, Ast.Expr.Div, e) -> fprintf f "%a = math.trunc(%a / %a)"
                                             (c.print_mut c nop) mut (c.print_mut c nop) mut e nop
    | SelfAffect (mut, Ast.Expr.Mod, e) -> fprintf f "%a = mod(%a, %a)"
                                             (c.print_mut c nop) mut (c.print_mut c nop) mut e nop
    | SelfAffect (mut, op, e) -> fprintf f "%a %a= %a" (c.print_mut c nop) mut c.print_op op e nop
    | Affect (mut, e) -> fprintf f "%a = %a" (c.print_mut c nop) mut e nop
    | ClikeLoop (init, cond, incr, li) -> assert false
    | Loop (var, e1, e2, li) -> fprintf f "@[<v 4>@[<h>for %a in range(%a, %a):@]%a@]"
                                  c.print_varname var e1 nop e2 nop
                                  block li
    | While (e, li) -> fprintf f "@[<v 4>while @[<h>%a@]:%a@]" e nop block li
    | Comment s -> let lic = String.split s '\n' in
      print_list (fun f s -> Format.fprintf f "#%s@\n" s) nosep f lic
    | Tag s -> fprintf f "/*%S*/" s
    | Return e -> if inlambda then fprintf f "next %a" e nop else fprintf f "return %a" e nop
    | AllocArray (name, t, e, None, opt) ->
      fprintf f "@[<h>%a@ =@ [None] * %a@]"
        c.print_varname name
        (fun f a -> a f (prio_right (prio_binop Ast.Expr.Mul))) e
    | AllocArray (name, t, e, Some (var, lambda), opt) ->
      fprintf f "@[<v 2>%a = [*0..@[<h>%a-1@]].map { |%a|@\n%a@\n}@]"
        c.print_varname name
        e nop
        c.print_varname var
        block_lambda lambda
    | AllocArrayConst (name, ty, len, lief, opt) ->
      fprintf f "@[<h>%a@ = [%a] * %a@]"
        c.print_varname name
        (c.print_lief nop) lief
        len (prio_right (prio_binop Ast.Expr.Mul))
    | AllocRecord (name, ty, list, opt) ->
      fprintf f "@[<v 4>%a = {%a}@\n@]" c.print_varname name
        (print_list (fun f (field, x) -> fprintf f "%S:%a" field x nop) sep_nl) list
    | If (e, listif, []) when inelseif ->
      fprintf f "if %a:%a@]" e nop block listif
    | If (e, listif, [elsecase]) when inelseif && elsecase.is_if ->
      fprintf f "if %a:%a@]@\n@[<v 4>el%a" e nop block listif elsecase.p (true, inlambda)          
    | If (e, listif, listelse)  when inelseif ->
      fprintf f "if %a:%a@]@\n@[<v 4>else:%a@]" e nop block listif block listelse
    | If (e, listif, []) ->
      fprintf f "@[<v 4>if %a:%a@]" e nop block listif
    | If (e, listif, [elsecase]) when elsecase.is_if ->
      fprintf f "@[<v 4>if %a:%a@]@\n@[<v 4>el%a" e nop block listif elsecase.p (true, inlambda)          
    | If (e, listif, listelse) ->
      fprintf f "@[<v 4>if %a:%a@]@\n@[<v 4>else:%a@]" e nop block listif block listelse
    | Call (func, li) ->  begin match StringMap.find_opt func c.macros with
        | Some ( (t, params, code) ) -> pmacros f "%s" t params code li nop
        | None -> fprintf f "%s(%a)" func (print_list (fun f x -> x f nop) sep_c) li
      end
    | Print li->
      let format, exprs = extract_multi_print clike_noformat format_type li in
      (* TODO match end of format *)
      begin match exprs with
        | [] -> fprintf f "print(\"%s\", end='')" format
        | [_ty, e] -> fprintf f "print(\"%s\" %% %a, end='')" format e prio_percent_percent
        | _ -> fprintf f "print(\"%s\" %% (%a), end='')" format
                 (print_list (fun f (t, e) -> e f nop) sep_c) exprs
      end
    | Read li ->
      let li = List.map (function
          | Separation -> fun f -> fprintf f "@[<hov>stdinsep()@]"
          | DeclRead (t, var, _option) -> read t (fun f () -> print_varname f var)
          | ReadExpr (t, m) -> read t (fun f () -> c.print_mut c nop f m)) li
      in print_list (fun f e -> e f) sep_nl f li
    | Untuple (li, expr, opt) -> fprintf f "(%a) = %a" (print_list c.print_varname sep_c) (List.map snd li) expr nop
    | Unquote e -> assert false in
  let is_multi_instr = match i with
    | Read (hd::tl) -> true
    | _ -> false in
  {
    is_multi_instr = is_multi_instr;
    is_if=is_if i;
    is_if_noelse=is_if_noelse i;
    is_comment=is_comment i;
    p=p;
    default = (false, false);
    print_lief = c.print_lief;
  }
  
  let instructions macros typerEnv f li =
    let open Ast.Instr.Fixed.Deep in
    let macros = StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc "py" li
        with Not_found -> List.assoc "" li) macros in
    let c = config macros in
    let li = List.map (fun i -> (fold (print_instr typerEnv c) (mapg (print_expr c) i))) li in
    let p f () = print_list (fun f i -> i.p f i.default) sep_nl f li in
    if List.for_all (fun i -> i.is_comment) li then
      Format.fprintf f "@[<h>pass@]"
    else p f ()


  let header f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "%s%s%s%s%s%s@\n"
      (if Tags.is_taged "__internal__div" ||
          Tags.is_taged "__internal__mod" ||
          Tags.is_taged "use_math"
       then
         "import math
" else "")
      (if need then "import sys
char_ = None

def readchar_():
    global char_
    if char_ == None:
        char_ = sys.stdin.read(1)
    return char_

def skipchar():
    global char_
    char_ = None
    return

" else "" )
      (if need_readchar then
         "def readchar():
    out = readchar_()
    skipchar()
    return out

" else "")
      (if need_stdinsep then
         "def stdinsep():
    while True:
        c = readchar_()
        if c == '\\n' or c == '\\t' or c == '\\r' or c == ' ':
            skipchar()
        else:
            return

" else "")
      (if need_readint then
         "def readint():
    c = readchar_()
    if c == '-':
        sign = -1
        skipchar()
    else:
        sign = 1
    out = 0
    while True:
        c = readchar_()
        if c <= '9' and c >= '0' :
            out = out * 10 + int(c)
            skipchar()
        else:
            return out * sign

" else "")
      (if Tags.is_taged "__internal__mod" then
         "def mod(x, y):
    return x - y * math.trunc(x / y)

"
       else "")

let prog typerEnv f (prog: Utils.prog)  =
  let open Format in
  let macros, items = List.fold_left
      (fun (macros, li) item -> match item with
         | Prog.Comment str -> 
           macros, (fun f -> let trimmed = String.trim str in
           if not (String.starts_with trimmed "\"" || String.ends_with trimmed "\"") then
             fprintf f "\"\"\"%s\"\"\"" trimmed
           else if not (String.starts_with trimmed "'" || String.ends_with trimmed "'") then
             fprintf f "'''%s'''" trimmed
           else
             fprintf f "\"\"\"@\n%s@\n\"\"\"" trimmed) :: li
         | Prog.DeclarFun (funname, t, vars, instrs, _opt) ->
           macros, (fun f -> fprintf f "@[<v 4>@[<h>def %s(%a):@]@\n%a@]" funname
             (print_list print_varname sep_c) (List.map fst vars)
             (instructions macros typerEnv) instrs) :: li
         | Prog.Macro (name, t, params, code) ->
           let macros = StringMap.add name (t, params, code) macros in macros, li
         | _ -> macros, li
      ) (StringMap.empty, []) prog.Prog.funs
  in
  fprintf f "%a%a@\n%a@\n"
    header prog
    (print_list (fun f g -> g f) sep_nl) (List.rev items)
    (print_option (instructions macros typerEnv )) prog.Prog.main
