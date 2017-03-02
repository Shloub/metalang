(*
 * Copyright (c) 2012 - 2016, Prologin
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


(** php Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast

let print_lief prio f l =
  let open Format in
  let open Expr in
  match l with
  | Char c ->
    let cs = Printf.sprintf "%C" c in
    if String.length cs == 6 || c == '\b' then
      fprintf f "\"\\x%02x\"" (int_of_char c)
    else fprintf f "%S" (String.from_char c)
  | String s ->
    let s = Printf.sprintf "%S" s in
    fprintf f "%s" (String.replace "$" "\\$" s)
  | Integer i ->
    if i < 0 then parens prio (-1) f "%i" i
    else fprintf f "%i" i
  | Bool true -> fprintf f "true"
  | Bool false -> fprintf f "false"
  | Enum s -> fprintf f "%S" s

let config macros = {
  prio_binop = prio_binop_equal;
  prio_unop;
  print_varname = dolar_varname;
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
      let prio, priol, prior = prio_binop op in
      fprintf f "intval(%a %a %a)" a priol print_op op b prior
    | Tuple li -> fprintf f "array(%a)" (print_list (fun f x -> x f nop) sep_c) li
    | Record li -> fprintf f "array(%a)" (print_list (fun f (name, x) ->
        fprintf f "%S => %a" name x nop) sep_c) li
    | _ -> print_expr0 config e f prio_parent
  in Fixed.Deep.fold (print_expr0 config) e f p

let print_instr c i =
  let open Ast.Instr in
  let open Format in
  let p f pend = match i with
    | Declare (var, ty, e, _) -> fprintf f "%a = %a%a" c.print_varname var e nop pend ()
    | AllocArray (name, t, e, None, opt) -> fprintf f "%a = array()%a" c.print_varname name pend ()
    | AllocArray (name, t, e, Some (var, lambda), opt) -> assert false
    | AllocArrayConst (name, ty, len, lief, opt) ->
      fprintf f "@[<h>%a = array_fill(0, %a, %a)%a@]" c.print_varname name
        len nop (c.print_lief nop) lief pend ()
    | AllocRecord (name, ty, list, opt) ->
      fprintf f "@[<v 4>%a = array(@\n%a)%a@]" c.print_varname name
        (print_list (fun f (field, x) -> fprintf f "%S => %a" field x nop) (sep "%a,@\n%a")) list
        pend ()
    | Print li->
      fprintf f "echo %a%a"
        (print_list
           (fun f -> function
              | StringConst s -> c.print_lief nop f (Ast.Expr.String s)
              | PrintExpr (_, e) -> e f nop) sep_c) li
        pend ()
    | Read li ->
      print_list
        (fun f -> function
           | Separation -> Format.fprintf f "@[scantrim()%a@]" pend ()
           | DeclRead (ty, v, opt) ->
             begin match Ast.Type.unfix ty with
               | Ast.Type.Char -> fprintf f "@[%a = nextChar()%a@]" c.print_varname v pend ()
               | _ -> fprintf f "@[list(%a) = scan(\"%a\")%a@]" c.print_varname v pformat_type ty pend ()
             end
           | ReadExpr (ty, mut) ->
             begin match Ast.Type.unfix ty with
               | Ast.Type.Char -> fprintf f "@[%a = nextChar()%a@]" (c.print_mut c nop) mut pend ()
               | _ -> fprintf f "@[list(%a) = scan(\"%a\")%a@]" (c.print_mut c nop) mut pformat_type ty pend ()
             end
        ) sep_nl f li
    | Untuple (li, expr, opt) -> fprintf f "list(%a) = %a%a" (print_list c.print_varname sep_c) (List.map snd li) expr nop pend ()
    | Unquote e -> assert false
    | _ -> clike_print_instr c i f pend
  in
  let is_multi_instr = match i with
    | Read (hd::tl) -> true
    | _ -> false in
  {
    is_multi_instr=is_multi_instr;
    is_if=is_if i;
    is_if_noelse=is_if_noelse i;
    is_comment=is_comment i;
    p=p;
    default = seppt;
    print_lief = c.print_lief;
  }

let print_instr macros i =
  let open Ast.Instr.Fixed.Deep in
  let c = config macros in
  let i = (fold (print_instr c) (mapg (print_expr c) i))
  in fun f -> i.p f i.default

let prog f prog =
    let instrs macros f t =
      let macros = StringMap.map (fun (ty, params, li) ->
          ty, params,
          try List.assoc "php" li
          with Not_found -> List.assoc "" li) macros
      in print_list (fun f t -> (print_instr macros t) f) sep_nl f t in
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in

    let macros, items = List.fold_left
        (fun (macros, li) item -> match item with
           | Prog.Comment s -> macros, (fun f -> Format.fprintf f "%a@\n" clike_comment s) :: li
           | Prog.DeclarFun (funname, t, vars, liinstrs, _opt) ->
             macros, (fun f -> Format.fprintf f "function %a%s(%a) {@\n@[<v 4>    %a@]@\n}@\n"
                         (fun f t -> match Type.unfix t with
                            | Type.Array _
                            | Type.Named _ ->
                              Format.fprintf f "&"
                            | _ -> ()
                         ) t funname
                         (print_list
                            (fun t (a, type_) ->
                               Format.fprintf t (match Type.unfix type_ with
                                   | Type.Array _ | Type.Named _ -> "&%a"
                                   | _ -> "%a")
                                 dolar_varname a) sep_c ) vars
                         (instrs macros) liinstrs) :: li
           | Prog.Macro (name, t, params, code) ->
             let macros = StringMap.add name (t, params, code) macros in macros, li
           | _ -> macros, li
        ) (StringMap.empty, []) prog.Prog.funs
    in
    Format.fprintf f "<?php@\n%s%s%s%a%a@\n"
      (if need then "$stdin='';
function stdin_(){
  global $stdin;
  if ( !feof(STDIN)) $stdin.=fgets(STDIN).\"\\n\";
}
function scan($format){
  stdin_();
  global $stdin;
  $out = sscanf($stdin, $format);
  $stdin = substr($stdin, strlen($out[0]));
  return $out;
}
" else "")
      (if need_stdinsep then "function scantrim(){
  global $stdin;
  while(true){
    $stdin = ltrim($stdin);
    if ($stdin != '' || feof(STDIN)) break;
    stdin_();
  }
}
" else "")
      (if need_readchar then "function nextChar(){
 stdin_();
  global $stdin;
  $out = $stdin[0];
  $stdin = substr($stdin, 1);
  return $out;
}
" else "")
      (print_list (fun f g -> g f) sep_nl) (List.rev items)
      (print_option (instrs macros)) prog.Prog.main
      
