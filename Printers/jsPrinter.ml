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
 *)

(** Javascript Printer
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
    let cs = sprintf "%C" c in
    if String.length cs == 6 then fprintf f "'\\x%02x'" (int_of_char c)
    else fprintf f "%s" cs
  | Enum e -> fprintf f "%S" e
  | x -> print_lief prio f x

let config macros = {
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
  let open Ast.Expr in 
  let print_mut conf priority f m = Mutable.Fixed.Deep.fold
      (print_mut0 "%a%a" "[%a]" "%a.%s" conf) m f priority in
  let print_expr0 config e f prio_parent = match e with
    | BinOp (a, ((Div | Mod) as op), b) ->
      let prio, priol, prior = prio_binop op in
      fprintf f "~~(%a %a %a)" a priol print_op op b prior
    | _ -> print_expr0 config e f prio_parent
  in Fixed.Deep.fold (print_expr0 config) e f p

let print_instr c i =
  let open Ast.Instr in
  let open Format in
  let p f pend = match i with
    | Declare (var, ty, e, _) -> fprintf f "var %a = %a%a" c.print_varname var e nop pend ()
    | AllocArray (name, t, e, None, opt) -> fprintf f "var %a = new Array(%a)%a"
                                              c.print_varname name
                                              e nop
                                              pend ()
    | AllocArray (name, t, e, Some (var, lambda), opt) -> assert false
    | AllocArrayConst (name, ty, len, lief, opt) ->
      fprintf f "@[<h>%a = array_fill(0, %a, %a)%a@]" c.print_varname name
        len nop (c.print_lief nop) lief pend ()
    | AllocRecord (name, ty, list, opt) ->
      fprintf f "@[<v 4>var %a = {@\n%a}%a@]" c.print_varname name
        (print_list (fun f (field, x) -> fprintf f "%S:%a" field x nop) (sep "%a,@\n%a")) list
        pend ()
    | Print li->
      fprintf f "util.print(%a)%a"
        (print_list
           (fun f -> function
              | StringConst s -> c.print_lief nop f (Ast.Expr.String s)
              | PrintExpr (_, e) -> e f nop) sep_c) li
        pend ()
    | Read li ->
      print_list
        (fun f -> function
           | Separation -> Format.fprintf f "@[stdinsep()%a@]" pend ()
           | DeclRead (ty, v, opt) ->
             begin match Ast.Type.unfix ty with
               | Ast.Type.Char -> fprintf f "@[var %a = read_char_()%a@]" c.print_varname v pend ()
               | Ast.Type.Integer -> fprintf f "@[var %a = read_int_()%a@]" c.print_varname v pend ()
               | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot read type %s"
                                              (Type.type_t_to_string ty)))
             end
           | ReadExpr (ty, mut) ->
             begin match Ast.Type.unfix ty with
               | Ast.Type.Char -> fprintf f "@[%a = read_char_()%a@]" (c.print_mut c nop) mut pend ()
               | Ast.Type.Integer -> fprintf f "@[%a = read_int_()%a@]" (c.print_mut c nop) mut pend ()
               | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot read type %s"
                                              (Type.type_t_to_string ty)))
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
    is_multi_instr = is_multi_instr;
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

let prog f (prog: Utils.prog) =
    let instrs macros f t =
      let macros = StringMap.map (fun (ty, params, li) ->
          ty, params,
          try List.assoc "js" li
          with Not_found -> List.assoc "" li) macros
      in print_list (fun f t -> print_instr macros t f) sep_nl f t in
    let macros, items = List.fold_left
        (fun (macros, li) item -> match item with
           | Prog.Macro (name, t, params, code) ->
             StringMap.add name (t, params, code) macros, li
           | Prog.Comment s -> macros, (fun f -> clike_comment f s) :: li
           | Prog.DeclarFun (funname, t, vars, liinstrs, _opt) ->
             macros, (fun f -> Format.fprintf f "@[<v 4>@[<hov>function %s(%a){@]@\n%a@]@\n}" funname
               (print_list print_varname sep_c) (List.map fst vars)
               (instrs macros) liinstrs) :: li
           | _ -> macros, li
        ) (StringMap.empty, []) prog.Prog.funs in
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "var util = require(\"util\");@\n%s%s%s%s%a@\n%a@\n"
      (if need then "var fs = require(\"fs\");
var current_char = null;
function read_char0(){
    return fs.readSync(process.stdin.fd, 1)[0];
}" else "")
      (if need_readchar then "
function read_char_(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
}" else "")
      (if need_stdinsep then "
function stdinsep(){
    if (current_char == null) current_char = read_char0();
    while (current_char.match(/[\\n\\t\\s]/g))
        current_char = read_char0();
}" else "")
      (if need_readint then "
function read_int_(){
  if (current_char == null) current_char = read_char0();
  var sign = 1;
  if (current_char == '-'){
     current_char = read_char0();
     sign = -1;
  }
  var out = 0;
  while (true){
    if (current_char.match(/[0-9]/g)){
      out = out * 10 + current_char.charCodeAt(0) - '0'.charCodeAt(0);
      current_char = read_char0();
    }else{
      return out * sign;
    }
  }
}
" else "")
    (print_list (fun f g -> g f) sep_nl) (List.rev items)
      (print_option (instrs macros)) prog.Prog.main
