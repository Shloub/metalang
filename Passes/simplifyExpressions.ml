(*
 * Copyright (c) 2016, Prologin
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
   Cette passe permet de déclarer simplifier quelques expressions bètes

   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
 *)

open Stdlib
open Ast

type acc0 = unit
type 'a acc = unit
let init_acc () = ()
let rewrite_expr0 annot e = match e with
  | Expr.BinOp ( (_, e1), Expr.LowerEq,
  (_, Expr.Fixed.F (_, Expr.BinOp (e2, Expr.Sub,
  Expr.Fixed.F (_, Expr.Lief (Expr.Integer 1))
  )))) ->
  true, Expr.binop Expr.Lower e1 e2
  | Expr.BinOp ( (_, e1), Expr.LowerEq,
  (_, Expr.Fixed.F (_, Expr.BinOp (e2, Expr.Sub,
  Expr.Fixed.F (_, Expr.Lief (Expr.Integer i))
  )))) ->
  true, Expr.binop Expr.Lower e1 (Expr.binop Expr.Sub e2 (Expr.integer (i - 1)))
  | Expr.BinOp ((_, e1), Expr.Lower,
  (_, Expr.Fixed.F (_, Expr.BinOp (e2, Expr.Add,
  Expr.Fixed.F (_, Expr.Lief (Expr.Integer 1))
  )))) ->
  true, Expr.binop Expr.LowerEq e1 e2
  | Expr.BinOp ( (_, e1), Expr.Add, (_, Expr.Fixed.F (_, Expr.BinOp (e2, Expr.Sub, e3)))) ->
  true, Expr.binop Expr.LowerEq e1 e2
  | e ->
      let b, e = Expr.Fixed.Surface.foldmap (fun (b, e) acc -> acc || b, e) e false in
      b, Expr.Fixed.fixa annot e
        
let rec rewrite_expr e =
  let changed, e = Expr.Fixed.Deep.folda rewrite_expr0 e in
  if changed then rewrite_expr e
  else e
      
let process () li = (), List.map (Instr.Fixed.Deep.mapg rewrite_expr) li
