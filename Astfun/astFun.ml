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


(**
   Ce module contient un ast fonctionnel
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast

module Expr = struct

  type lief = (* le même type que dans Ast, sauf qu'on ajoute unit *)
  | Unit
  | Error
  | IntMapEmpty
  | Char of char
  | String of string
  | Integer of int
  | Bool of bool
  | Enum of string
  | Binding of string

  type 'a tofix =
  | LetRecIn of string * string list * 'a * 'a
  | UnOp of 'a * Ast.Expr.unop
  | BinOp of 'a * Ast.Expr.binop * 'a
  | Fun of string list * 'a
  | FunTuple of string list * 'a
  | Apply of 'a * 'a list
  | Tuple of 'a list
  | Lief of lief
  | Comment of string * 'a
  | Ignore of 'a * 'a
  | If of 'a * 'a * 'a
  | Print of 'a * Ast.Type.t * 'a
  | ReadIn of Ast.Type.t * 'a
  | SkipIn of 'a
  | IntMapAdd of 'a * 'a * 'a
  | IntMapGet of 'a * 'a

  module Fixed = Fix(struct
    type ('a, 'b) alias = 'a tofix
    type ('a, 'b) tofix = ('a, 'b) alias
    let map f = function
      | LetRecIn (name, params, e1, e2) ->
        LetRecIn (name, params, f e1, f e2)
      | BinOp (a, op, b) -> BinOp (f a, op, f b)
      | UnOp (a, op) -> UnOp (f a, op)
      | Fun (params, e) -> Fun (params, f e)
      | FunTuple (params, e) -> Fun (params, f e)
      | Apply (e, li) -> Apply (f e, List.map f li)
      | Tuple li -> Tuple (List.map f li)
      | Lief l -> Lief l
      | Comment (s, c) -> Comment (s, f c)
      | Ignore (e1, e2) -> Ignore (f e1, f e2)
      | If (e1, e2, e3) -> If (f e1, f e2, f e3)
      | Print (e, ty, next) -> Print (f e, ty, f next)
      | ReadIn (ty, e) -> ReadIn (ty, f e)
      | SkipIn e -> SkipIn (f e)
      | IntMapAdd (e1, e2, e3) -> IntMapAdd (f e1, f e2, f e3)
      | IntMapGet (e1, e2) -> IntMapGet (f e1, f e2)
    let next () = next ()
  end)

  type t = unit Fixed.t
  let fix : 'a -> t = Fixed.fix
  let unfix = Fixed.unfix
  let fixa : 'a -> 'b -> t = Fixed.fixa

  module Writer = AstWriter.F (struct
    type 'a alias = t
    type 'a t = 'a alias
    let foldmap f acc e =
      let annot = Fixed.annot e in
      let acc, unfixed = match unfix e with
        | LetRecIn (name, params, e1, e2) ->
          let acc, e1 = f acc e1 in
          let acc, e2 = f acc e2 in
          acc, LetRecIn (name, params, e1, e2)
        | BinOp (a, op, b) ->
          let acc, a = f acc a in
          let acc, b = f acc b in
          acc, BinOp (a, op, b)
        | UnOp (a, op) ->
          let acc, a = f acc a in
          acc, UnOp (a, op)
        | Fun (params, e) ->
          let acc, e = f acc e in
          acc, Fun (params, e)
        | FunTuple (params, e) ->
          let acc, e = f acc e in
          acc, FunTuple (params, e)
        | Apply (e, li) ->
          let acc, e = f acc e in
          let acc, li = List.fold_left_map f acc li in
          acc, Apply (e, li)
        | Tuple li ->
          let acc, li = List.fold_left_map f acc li in
          acc, Tuple li
        | Lief l -> acc, Lief l
        | Comment (s, c) ->
          let acc, c = f acc c in
          acc, Comment (s, c)
        | Ignore (e1, e2) ->
          let acc, e1 = f acc e1 in
          let acc, e2 = f acc e2 in
          acc, Ignore (e1, e2)
        | If (e1, e2, e3) ->
          let acc, e1 = f acc e1 in
          let acc, e2 = f acc e2 in
          let acc, e3 = f acc e3 in
          acc, If (e1, e2, e3)
        | Print (e, ty, next) ->
          let acc, e = f acc e in
          let acc, next = f acc next in
          acc, Print (e, ty, next)
        | ReadIn (ty, e) ->
          let acc, e = f acc e in
          acc, ReadIn (ty, e)
        | SkipIn e ->
          let acc, e = f acc e in
          acc, SkipIn e
        | IntMapAdd (e1, e2, e3) ->
          let acc, e1 = f acc e1 in
          let acc, e2 = f acc e2 in
          let acc, e3 = f acc e3 in
          acc, IntMapAdd (e1, e2, e3)
        | IntMapGet (e1, e2) ->
          let acc, e1 = f acc e1 in
          let acc, e2 = f acc e2 in
          acc, IntMapGet (e1, e2)
      in acc, fixa annot unfixed
  end)
  let letrecin name params e1 e2 = fix (LetRecIn (name, params, e1, e2))
  let lief l = fix (Lief l)
  let unit = lief (Unit)
  let error = lief (Error)
  let intmapempty = lief (IntMapEmpty)
  let intmapadd e1 e2 e3 = fix (IntMapAdd (e1, e2, e3))
  let intmapget e1 e2 = fix (IntMapGet (e1, e2))
  let integer i = lief (Integer i)
  let unop e op = fix (UnOp (e, op))
  let binop e1 op e2 = fix (BinOp (e1, op, e2))
  let binding s = fix (Lief (Binding s))
  let apply a li = fix (Apply (a, li))
  let fun_ li a = fix (Fun (li, a))
  let funtuple li a = fix (FunTuple (li, a))
  let tuple li = fix (Tuple li)
  let comment s c = fix (Comment (s, c))
  let ignore e1 e2 = fix (Ignore (e1, e2))
  let if_ e1 e2 e3 = fix (If (e1, e2, e3))
  let print e ty next = fix (Print (e, ty, next))
  let readin e ty = fix (ReadIn (ty, e))
  let skipin e = fix (SkipIn e)
end

type expr = Expr.t

type declaration = varname * expr

type prog = declaration list
