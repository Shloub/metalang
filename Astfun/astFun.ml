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
  | Char of char
  | String of string
  | Integer of int
  | Bool of bool
  | Enum of string
  | Binding of string

  type formatPart =
    | IntFormat
    | StringFormat
    | CharFormat
    | StringConstant of string

  type 'a tofix =
  | Skip
  | LetRecIn of string * string list * 'a * 'a
  | UnOp of 'a * Ast.Expr.unop
  | BinOp of 'a * Ast.Expr.binop * 'a
  | Fun of string list * 'a
  | FunTuple of string list * 'a
  | Apply of 'a * 'a list
  | Tuple of 'a list
  | Lief of lief
  | Comment of string * 'a
  | If of 'a * 'a * 'a
  | Print of 'a * Ast.Type.t
  | MultiPrint of (formatPart list) * ('a * Ast.Type.t) list
  | ReadIn of Ast.Type.t * 'a
  | Block of 'a list
  | Record of ('a * string) list
  | RecordAffect of 'a * string * 'a
  | RecordAccess of 'a * string
  | ArrayMake of 'a * 'a * 'a
  | ArrayInit of 'a * 'a
  | ArrayAccess of 'a * 'a list
  | ArrayAffect of 'a * 'a list * 'a
  | LetIn of string * 'a * 'a

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
      | If (e1, e2, e3) -> If (f e1, f e2, f e3)
      | Print (e, ty) -> Print (f e, ty)
      | ReadIn (ty, e) -> ReadIn (ty, f e)
      | Skip -> Skip
      | Block li -> Block (List.map f li)
      | Record li -> Record (List.map (fun (e, s) -> f e, s) li)
      | RecordAffect (e1, s, e2) -> RecordAffect (f e1, s, f e2)
      | RecordAccess (e, s) -> RecordAccess (f e, s)
      | ArrayAccess (tab, indexes) -> ArrayAccess (f tab, List.map f indexes)
      | ArrayMake (len, lambda, env) -> ArrayMake (f len, f lambda, f env)
      | ArrayInit (len, lambda) -> ArrayInit (f len, f lambda)
      | MultiPrint (format, li) -> MultiPrint (format, List.map (fun (a, b) -> (f a, b)) li)
      | ArrayAffect (tab, indexes, v) -> ArrayAffect (f tab, List.map f indexes, f v)
      | LetIn (binding, e, b) -> LetIn (binding, f e, f b)
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
        | If (e1, e2, e3) ->
          let acc, e1 = f acc e1 in
          let acc, e2 = f acc e2 in
          let acc, e3 = f acc e3 in
          acc, If (e1, e2, e3)
        | Print (e, ty) ->
          let acc, e = f acc e in
          acc, Print (e, ty)
        | ReadIn (ty, e) ->
          let acc, e = f acc e in
          acc, ReadIn (ty, e)
        | Skip -> acc, Skip
				| Block li ->
						let acc, li = List.fold_left_map f acc li in
						acc, Block li
				| Record li ->
						let acc, li = List.fold_left_map (fun acc (e, s) ->
							let acc, e = f acc e in
							acc, (e, s)
																						 ) acc li in
						acc, Record li
				| RecordAffect (e1, s, e2) ->
						let acc, e1 = f acc e1 in
          let acc, e2 = f acc e2 in
          acc, RecordAffect (e1, s, e2)
				| RecordAccess (e, s) ->
						let acc, e = f acc e in
						acc, RecordAccess (e, s)
				| ArrayAccess (tab, indexes) ->
						let acc, tab = f acc tab in
						let acc, indexes = List.fold_left_map f acc indexes in
						acc, ArrayAccess (tab, indexes)
				| ArrayMake (len, lambda, env) ->
						let acc, len = f acc len in
						let acc, env = f acc env in
						let acc, lambda = f acc lambda in
						acc, ArrayMake (len, lambda, env)
        | ArrayInit (len, lambda) ->
						let acc, len = f acc len in
						let acc, lambda = f acc lambda in
						acc, ArrayInit (len, lambda)
				| ArrayAffect (tab, indexes, v) ->
						let acc, tab = f acc tab in
						let acc, indexes = List.fold_left_map f acc indexes in
						let acc, v = f acc v in
						acc, ArrayAffect (tab, indexes, v)
				| LetIn (binding, e, b) ->
						let acc, e = f acc e in
						let acc, b = f acc b in
						acc, LetIn (binding, e, b)

      | MultiPrint (format, li) ->
	 let acc, li = List.fold_left_map (fun acc (a, b) ->
					   let acc, a = f acc a in
					   acc, (a, b)) acc li in
	 acc, MultiPrint (format, li)

      in acc, fixa annot unfixed
  end)
  let letrecin name params e1 e2 = fix (LetRecIn (name, params, e1, e2))
  let letin name e1 e2 = fix (LetIn (name, e1, e2) )
  let lief l = fix (Lief l)
  let unit = lief (Unit)
  let error = lief (Error)
  let integer i = lief (Integer i)
  let unop e op = fix (UnOp (e, op))
  let binop e1 op e2 = fix (BinOp (e1, op, e2))
  let binding s = fix (Lief (Binding s))
  let apply a li = fix (Apply (a, li))
  let fun_ li a = fix (Fun (li, a))
  let funtuple li a = fix (FunTuple (li, a))
  let tuple li = fix (Tuple li)
  let comment s c = fix (Comment (s, c))
  let if_ e1 e2 e3 = fix (If (e1, e2, e3))
  let block li = fix (Block li)
  let print e ty next = block [ fix (Print (e, ty)); next]
  let multiprint fs exprs = fix (MultiPrint (fs, exprs))
  let print_ e ty = fix (Print (e, ty))
  let readin e ty = fix (ReadIn (ty, e))
  let skipin e = block [fix Skip; e]
  let record li = fix (Record li)
  let recordaccess e s = fix (RecordAccess (e, s))
  let recordaffectin record field value in_ = block [fix (RecordAffect (record, field, value)); in_]
  let arraymake len lambda env = fix (ArrayMake (len, lambda, env))
  let arrayinit len lambda = fix (ArrayInit (len, lambda))
  let arrayaccess tab indexes = fix (ArrayAccess (tab, indexes))
  let arrayaffectin tab indexes v in_ = block [fix (ArrayAffect (tab, indexes, v)); in_]
end

type expr = Expr.t

type declaration =
| Declaration of string * expr
| DeclareType of string * Ast.Type.t
| Macro of string * Ast.Type.t * (string * Ast.Type.t) list * (string * string ) list

type opts = { hasSkip : bool; reads : Ast.TypeSet.t }
type prog = { declarations : declaration list; options : opts ; side_effects : bool IntMap.t }

let existsExpr f li =
   List.exists (function
     | Declaration (_, e) -> Expr.Writer.Deep.exists f e
    | _ -> false
              ) li
