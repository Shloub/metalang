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

module FunExpr = struct
  type 'a tofix =
  | UnOp of 'a * Ast.Expr.unop
  | BinOp of 'a * Ast.Expr.binop * 'a

  module Fixed = Fix(struct
    type ('a, 'b) alias = 'a tofix
    type ('a, 'b) tofix = ('a, 'b) alias
    let map f = function
      | BinOp (a, op, b) -> BinOp ((f a), op, f b)
      | UnOp (a, op) -> UnOp((f a), op)
      
    let next () = next ()
  end)

  type t = unit Fixed.t
  let fix = Fixed.fix
  let unfix = Fixed.unfix

end

type funexpr = FunExpr.t

type fundeclaration = varname * funexpr

type prog = fundeclaration list
