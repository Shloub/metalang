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
let apply op i1 i2 = (match op with Expr.Add -> (+) | Expr.Sub -> (-)) i1 i2
  
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
  | Expr.BinOp ( (_, e1), Expr.LowerEq, (_, Expr.Fixed.F (_, Expr.Lief (Expr.Integer i)))) ->
      true, Expr.binop Expr.Lower e1 (Expr.integer (i + 1))
  | Expr.BinOp ((_, e1), Expr.Lower,
  (_, Expr.Fixed.F (_, Expr.BinOp (e2, Expr.Add,
  Expr.Fixed.F (_, Expr.Lief (Expr.Integer 1))
  )))) ->
    true, Expr.binop Expr.LowerEq e1 e2
  | Expr.BinOp ( (_, Expr.Fixed.F (_, Expr.Lief Expr.Integer i1)), ((Expr.Add | Expr.Sub) as op), (_, Expr.Fixed.F (_, Expr.Lief Expr.Integer i2 )))
    when i1 = 1 || i2 = 1
    ->
      let e = apply op i1 i2 in
      let e = Expr.Lief (Expr.Integer e) in
      true, Expr.Fixed.fixa annot e

 | Expr.BinOp ( (_, e1), Expr.Sub, (_, Expr.Fixed.F (_, Expr.Lief Expr.Integer i2 )))
    when i2 < 0 ->
      let e2 = Expr.lief (Expr.Integer (-i2)) in
      let e = Expr.BinOp (e1, Expr.Add, e2) in
      true, Expr.Fixed.fixa annot e
 | Expr.BinOp ( (_, Expr.Fixed.F (_, Expr.BinOp( e1, ((Expr.Add | Expr.Sub) as op1), Expr.Fixed.F (_, Expr.Lief Expr.Integer i2)))), ((Expr.Add | Expr.Sub) as op2), (_, Expr.Fixed.F (_, Expr.Lief Expr.Integer i3 ))) ->
     let i2 = match op1 with | Expr.Sub -> -i2 | _ -> i2 in
     let i = apply op2 i2 i3 in
     let e =
       if i = 0 then Expr.unfix e1 else if i < 0 then
         let e2 = Expr.lief (Expr.Integer (-i)) in
         Expr.BinOp (e1, Expr.Sub, e2)
       else
         let e2 = Expr.lief (Expr.Integer i) in
         Expr.BinOp (e1, Expr.Add, e2) in
     true, Expr.Fixed.fixa annot e
 | e ->
     let b, e = Expr.Fixed.Surface.foldmap (fun (b, e) acc -> acc || b, e) e false in
     b, Expr.Fixed.fixa annot e

let rec rewrite_expr e =
  let changed, e = Expr.Fixed.Deep.folda rewrite_expr0 e in
  if changed then rewrite_expr e
  else e
      
let process () li = (), List.map (Instr.Fixed.Deep.mapg rewrite_expr) li
