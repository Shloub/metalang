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

(** some utility functions for printers
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

let print_option (f : Format.formatter -> 'a -> unit) t obj =
  match obj with
  | None -> ()
  | Some s -> f t s

let print_list = Printers.print_list

let sep format f pa a pb b = Format.fprintf f format pa a pb b
let nosep f = sep "%a%a" f
let sep_space f = sep "%a %a" f
let sep_nl f = sep "%a@\n%a" f
let sep_c f = sep "%a, %a" f
let sep_cnl f = sep "%a,@\n%a" f
let sep_dc f = sep "%a; %a" f


let print_list_indexed print sep f li =
  print_list
    (fun f (toprint, index) ->
      print f toprint index
    )
    sep
    f
    (snd (List.fold_left_map
            (fun i m -> (i+1), (m, i))
            0
            li
     ))

let print_ntimes n f s =
  for i = 1 to n do
    Format.fprintf f "%s" s
  done

let simple_expression e =
  let f tra acc e = match Ast.Expr.unfix e with
  | Ast.Expr.Access m -> begin match Ast.Mutable.unfix m with
    | Ast.Mutable.Var _ -> acc
    | _ -> false
  end
  | Ast.Expr.Lief l -> acc
  | Ast.Expr.UnOp _
  | Ast.Expr.BinOp _ -> tra acc e
  | _ -> false
  in f (Ast.Expr.Writer.Traverse.fold f) true e

let contains_instr f prog =
    let cli = List.exists (Ast.Instr.Writer.Deep.exists f) in
    Option.map_default false cli prog.Ast.Prog.main ||
    (List.exists (function Ast.Prog.DeclarFun (_, _, _, instrs, _) -> cli instrs | _ -> false)
    prog.Ast.Prog.funs)


let print_varname f = function
  | Ast.UserName v -> Format.fprintf f "$%s" v
  | Ast.InternalName _ -> assert false

let print_mut m f () = match m with
| Ast.Mutable.Var v -> Format.fprintf f "$%a" print_varname v
| Ast.Mutable.Array (m, fi) -> Format.fprintf f "%a%a" m ()
      (print_list (fun f a -> Format.fprintf f "[%a]" a ()) nosep) fi
| Ast.Mutable.Dot (m, field) -> Format.fprintf f "%a[%S]" m () field
 
let parens (pa:int) pb f format =
  if pa < pb then Format.fprintf f "(%a)" (fun f -> Format.fprintf f format)
  else Format.fprintf f format

let print_op f op =
  Format.fprintf f (match op with
  | Ast.Expr.Add -> "+"
  | Ast.Expr.Sub -> "-"
  | Ast.Expr.Mul -> "*"
  | Ast.Expr.Div -> "/"
  | Ast.Expr.Mod -> "%%"
  | Ast.Expr.Or -> "||"
  | Ast.Expr.And -> "&&"
  | Ast.Expr.Lower -> "<"
  | Ast.Expr.LowerEq -> "<="
  | Ast.Expr.Higher -> ">"
  | Ast.Expr.HigherEq -> ">="
  | Ast.Expr.Eq -> "=="
  | Ast.Expr.Diff -> "!=")


let prio_binop = function
    | Ast.Expr.Add -> -1, -2, -2
    | Ast.Expr.Sub -> -1, -2, -1
    | Ast.Expr.Mul -> 0, -1, -1
    | Ast.Expr.Div -> -10, 15, 15
    | Ast.Expr.Mod -> -10, 15, 15
    | Ast.Expr.Or -> -8, -8, -8
    | Ast.Expr.And -> -10, -10, -10
    | Ast.Expr.Lower -> -5, -5, -5
    | Ast.Expr.LowerEq -> -5, -5, -5
    | Ast.Expr.Higher -> -5, -5, -5
    | Ast.Expr.HigherEq -> -5, -5, -5
    | Ast.Expr.Eq -> -6, -5, -5
    | Ast.Expr.Diff -> -5, -5, -5


let print_expr e f prio_parent = match e with
| Ast.Expr.BinOp (a, op, b) ->
    let prio, prio_left, prio_right = prio_binop op in
    parens prio prio_parent f "%a %a %a" a prio_left print_op op b prio_right
