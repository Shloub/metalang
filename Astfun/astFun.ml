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
  | Char of char
  | String of string
  | Integer of int
  | Bool of bool
  | Enum of string
  | Binding of string

  type 'a tofix =
  | UnOp of 'a * Ast.Expr.unop
  | BinOp of 'a * Ast.Expr.binop * 'a
  | Fun of string list * 'a
  | Apply of 'a * 'a list
  | Lief of lief
  | Comment of string * 'a
  | Ignore of 'a * 'a
  | If of 'a * 'a * 'a
  | Print of 'a * Ast.Type.t * 'a

  module Fixed = Fix(struct
    type ('a, 'b) alias = 'a tofix
    type ('a, 'b) tofix = ('a, 'b) alias
    let map f = function
      | BinOp (a, op, b) -> BinOp ((f a), op, f b)
      | UnOp (a, op) -> UnOp ((f a), op)
      | Fun (params, e) -> Fun (params, f e)
      | Apply (e, li) -> Apply (f e, List.map f li)
      | Lief l -> Lief l
      | Comment (s, c) -> Comment (s, f c)
      | Ignore (e1, e2) -> Ignore (f e1, f e2)
      | If (e1, e2, e3) -> If (f e1, f e2, f e3)
      | Print (e, ty, next) -> Print (f e, ty, f next)
    let next () = next ()
  end)

  type t = unit Fixed.t
  let fix : 'a -> t = Fixed.fix
  let unfix = Fixed.unfix

  let lief l = fix (Lief l)
  let unit = lief (Unit)
  let unop e op = fix (UnOp (e, op))
  let binop e1 op e2 = fix (BinOp (e1, op, e2))
  let binding s = fix (Lief (Binding s))
  let apply a li = fix (Apply (a, li))
  let fun_ li a = fix (Fun (li, a))
  let comment s c = fix (Comment (s, c))
  let ignore e1 e2 = fix (Ignore (e1, e2))
  let if_ e1 e2 e3 = fix (If (e1, e2, e3))
  let print e ty next = fix (Print (e, ty, next))
end

type expr = Expr.t

type declaration = varname * expr

type prog = declaration list
