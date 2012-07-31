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
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THI
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *)

(** Expressions Ast
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
    @author Arthur Wendling (art.wendling\@gmail.com)
*)


open Stdlib
open Ast

type unop = Neg | Not | BNot

type binop =
  | Add | Sub | Mul | Div (* int or float *)
  | Mod (* int *)
  | Or | And (* bool *)
  | Lower | LowerEq | Higher | HigherEq (* 'a *)
  | Eq | Diff (* 'a *)
  | BinOr | BinAnd | RShift | LShift (* int *)

type ('a, 'lex) tofix =
    (*operations numeriques*)
    BinOp of 'a * binop * 'a
  | UnOp of 'a * unop
  (* liefs *)
  | Char of char
  | String of string
  | Float of float
  | Integer of int
  | Bool of bool
  | Access of 'a Mutable.t
  | Length of 'a Mutable.t
  | Call of funname * 'a list
  | Lexems of 'lex list
type 'lex t = F of int * ('lex t, 'lex) tofix
let annot = function F (i, _) -> i
let unfix = function F (_, x) -> x
let fix x = F ((next ()), x)
let fixa a x = F (a, x)

let map f = function
  | BinOp (a, op, b) -> BinOp ((f a), op, f b)
  | UnOp (a, op) -> UnOp((f a), op)
  | (
    Integer _
        | Float _
        | String _
        | Char _
        | Bool _) as lief -> lief
  | Access m ->
    let (), m2 = Mutable.foldmap_expr (fun () e -> (), f e) () m in
    Access m2
  | Length m ->
    let (), m2 = Mutable.foldmap_expr (fun () e -> (), f e) () m in
    Length m2
  | Call (n, li) -> Call (n, List.map f li)

let bool b = fix (Bool b)

let unop op a = fix (UnOp (a, op))
let binop op a b = fix (BinOp (a, op, b))

let integer i = fix (Integer i)
let char i = fix (Char i)
let float f = fix (Float f)
let string f = fix (String f)
let boolean b = fix (Bool b)

let lexems li = fix (Lexems li)

let access m = fix (Access m )

let call name li = fix ( Call(name, li))
let length m = fix ( Length (Mutable.var m) )

let default_value t = match Type.unfix t with
  | Type.Integer -> integer 0
  | Type.Float -> float 0.
  | Type.String -> string ""
  | Type.Char -> char '_'
  | Type.Array _ -> failwith ("new array is not an expression")
  | Type.Void -> failwith ("no dummy expression for void")
  | Type.Bool -> boolean false
  | Type.Named _ -> failwith ("new named is not an expression")
  | Type.Auto -> failwith ("auto is not an expression")
  | Type.Struct _ -> failwith ("new named is not an expression")

module Writer = AstWriter.F (struct
  type 'a alias = 'a t;;
  type 'a t = 'a alias;;
  let foldmap f acc t =
    let annot = annot t in
    match unfix t with
      | UnOp (a, op) ->
        let acc, a = f acc a in
        (acc, F(annot, UnOp(a, op)))
      | BinOp (a, op, b) ->
        let acc, a = f acc a in
        let acc, b = f acc b in
        (acc, F (annot, BinOp (a, op, b) ) )
      | Char _ -> acc, t
      | String _ -> acc, t
      | Float _ -> acc, t
      | Integer _ -> acc, t
      | Bool _ -> acc, t
      | Access m ->
        let acc, m = Mutable.foldmap_expr f acc m in
        acc, F (annot, Access m)
      | Length m ->
        let acc, m = Mutable.foldmap_expr f acc m in
        acc, F (annot, Length m)
      | Call (name, li) ->
        let acc, li = List.fold_left_map f acc li in
        (acc, F (annot, Call(name, li)) )
end)
