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


(** Ocaml printer for functional AST
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper

module E = AstFun.Expr
module Type = Ast.Type

let lang = "ml"

let prio_if = -107
let prio_arg = -105
let prio_tuple = -103
let prio_apply = -101
let prio_array = -100
let prio_record = -100
let prio_if = 100

let binopstr op =
  let open Ast.Expr in match op with
  | Add -> "+"
  | Sub -> "-"
  | Mul -> "*"
  | Div -> "/"
  | Mod -> "mod"
  | Or -> "||"
  | And -> "&&"
  | Lower -> "<"
  | LowerEq -> "<="
  | Higher -> ">"
  | HigherEq -> ">="
  | Eq -> "="
  | Diff -> "<>"

let unopstr = let open Ast.Expr in function
    | Neg -> "-"
    | Not -> "not"

let print_expr macros e f prio_parent =
  let open Ast.Expr in
  let open Format in
  let open AstFun.Expr in
  let print_lief f = function
    | Error -> fprintf f "(assert false)"
    | Unit -> fprintf f "()"
    | Char c -> fprintf f "%C" c
    | String s -> fprintf f "%S" s
    | Integer i -> fprintf f "%i" i
    | Bool true -> fprintf f "true"
    | Bool false -> fprintf f "false"
    | Enum s -> fprintf f "%s" s
    | Binding s -> print_varname f s in
  match e with
  | Skip -> parens prio_parent prio_apply f "Scanf.scanf \"%%[\\n \\010]\" (fun _ -> ())"
  | UnOp (a, op) -> parens prio_parent prio_apply f "%s %a" (unopstr op) a prio_arg
  | BinOp (a, op, b) ->
    let prio, prio_left, prio_right = prio_binop op in
    parens prio_parent prio f "%a %s %a" a prio_left (binopstr op) b prio_right
  | Fun ([], e) -> fprintf f "(fun () -> @[<v>%a@])" e nop
  | Fun (params, e) ->
    fprintf f "(fun %a -> %a)" (print_list print_varname sep_space) params e nop
  | LetRecIn (name, [], e1, e2) ->
    fprintf f "@[<v 2>let rec %a () =@\n%a in@\n%a@]"
      print_varname name e1 nop e2 nop
  | LetRecIn (name, params, e1, e2) ->
    fprintf f "@[<v 2>let rec %a %a =@\n%a in@\n%a@]"
      print_varname name
      (print_list print_varname sep_space) params e1 nop e2 nop
  | Print (e, ty) ->
    parens prio_parent prio_apply f "Printf.printf %S %a"
      (format_type ty) e prio_arg
  | FunTuple (params, e) ->
    fprintf f "(fun (%a) ->@[<v>%a@])" (print_list print_varname sep_c) params e nop
  | Lief l -> print_lief f l
  | MultiPrint (fmt, li) ->
    parens prio_parent prio_apply f "Printf.printf %S %a"
      (format_to_string fmt)
      (print_list (fun f (a, ty) -> a f prio_arg) sep_space) li

  | Apply (a, []) -> parens prio_parent prio_apply f "%a ()" a nop
  | Apply (a, params) -> parens prio_parent prio_apply f "%a %a" a nop (print_list (fun f a -> a f prio_arg) sep_space) params
  | Tuple li -> parens prio_parent prio_tuple f "%a" (print_list (fun f a -> a f nop) sep_c) li
  | If (e1, e2, e3) -> parens prio_parent prio_if f "@[if %a@\nthen %a@\nelse %a@]" e1 prio_if e2 prio_if e3 prio_if
  | Block li ->
    fprintf f "( @[<v>%a@])"
      (print_list
         (fun f a -> a f nop)
         (sep "%a;@\n%a")) li
  | RecordAffect (a, field, v) -> fprintf f "%a.%s <- %a" a prio_record field v nop
  | RecordAccess (a, field) -> fprintf f "%a.%s" a prio_record field
  | Record li ->
    fprintf f "{@[<v>%a}@]"
      (print_list
         (fun f (expr, field) -> fprintf f "%s=%a" field expr nop)
         (sep "%a;@\n%a")) li
  | ArrayInit (len, lambda) -> parens prio_parent prio_apply f "Array.init %a %a"
                                 len prio_arg lambda prio_arg
  | ArrayMake (len, lambda, env) -> parens prio_parent prio_apply f "Array.init_withenv %a %a %a"
                                      len prio_arg lambda prio_arg env prio_arg
  | ArrayAccess (tab, indexes) ->
    fprintf f "%a%a" tab prio_array (print_list (fun f a -> fprintf f ".(%a)" a nop) nosep) indexes
  | ArrayAffect (tab, indexes, v) ->
    fprintf f "%a%a <- %a" tab prio_array (print_list (fun f a -> fprintf f ".(%a)" a nop) nosep) indexes v nop
  | LetIn (var, e, i) -> fprintf f "let %a = %a in@\n%a" print_varname var e nop i nop
  | Comment (s, i) -> fprintf f "(* %s *)@\n%a" s i prio_parent
  | ReadIn (ty, next) -> parens prio_parent prio_apply f "Scanf.scanf %S@\n%a" (format_type ty) next prio_arg
  | ApplyMacro(m, li) ->
    let t, params, code = Ast.BindingMap.find m macros in
    pmacros f "(%s)" t params code li nop

let print_expr macros f e =
  AstFun.Expr.Fixed.Deep.fold (print_expr macros) e f nop

let rec extract_fun_params e acc = match E.unfix e with
    | E.Fun ([], e) ->
      let acc f () = Format.fprintf f "%a ()" acc ()
      in extract_fun_params e acc
    | E.Fun (params, e) ->
      let acc f () = Format.fprintf f "%a %a" acc () (print_list print_varname sep_space) params
      in extract_fun_params e acc
    | E.FunTuple (params, e) ->
      let acc f () = Format.fprintf f "%a (%a)" acc () (print_list print_varname sep_c) params
      in extract_fun_params e acc
    | _ -> acc, e

let header array_init array_make f _ =
    if array_make then
      Format.fprintf f
        "module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end
"

  let prog (f:Format.formatter) (prog:AstFun.prog) =
    let macros, liitems = List.fold_left (fun (macros, liitems) -> function
        | AstFun.Declaration (name, e) ->
          macros, (fun f -> let is_rec =
                              E.Fixed.Deep.exists (fun e -> match E.unfix e with
                                  | E.Lief (E.Binding n) -> n = name
                                  | _ -> false) e in
                    let pparams, e = extract_fun_params e (fun f () -> ()) in
                    Format.fprintf f "@[<v 2>let%s %a%a =@\n%a@]@\n" (if is_rec then " rec" else "")
                      print_varname name pparams () (print_expr (Ast.BindingMap.map (fun (ty, params, li) ->
                          ty, params,
                          try List.assoc lang li with Not_found -> List.assoc "" li) macros))
                      e) :: liitems
        | AstFun.DeclareType (name, ty) -> macros, (fun f -> Format.fprintf f "@[<v 2>type %s = %a@]@\n" name Mllike.ptype ty)::liitems
        | AstFun.Macro (name, t, params, code) ->
          let macros = Ast.BindingMap.add name (t, params, code) macros in
          macros, liitems
      ) (Ast.BindingMap.empty, []) prog.AstFun.declarations
    in
    let array_init = AstFun.existsExpr (fun e ->match E.unfix e with
        | E.ArrayInit _ -> true
        | _ -> false ) prog.AstFun.declarations in
    let array_make = AstFun.existsExpr (fun e ->match E.unfix e with
        | E.ArrayMake _ -> true
        | _ -> false ) prog.AstFun.declarations in
    Format.fprintf f "%a%a" (header array_init array_make) prog.AstFun.options
      (print_list (fun f g -> g f) sep_nl) (List.rev liitems)
