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
   Cette passe permet de remplacer a = a + 1 en a += 1

   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast

type acc0 = bool * Expr.binop list
type 'a acc = acc0
let init_acc conf = conf

let process acc li =
  List.fold_left_map (fun ((incr, li) as acc) i ->
      Instr.Writer.Deep.foldmap (fun acc i -> match Instr.unfix i with
          | Instr.Affect (m, Expr.Fixed.F(_, Expr.BinOp (
              Expr.Fixed.F (_, Expr.Access m2),
              ((Expr.Add | Expr.Sub) as op),
              Expr.Fixed.F (_, Expr.Lief (Expr.Integer 1))
            ))) when incr && List.mem op li &&
                     Mutable.equals Expr.equals m m2 ->
            let i0 = match op with
              | Expr.Add -> Instr.Incr m
              | Expr.Sub -> Instr.Decr m
            in acc, Instr.Fixed.fixa (Instr.Fixed.annot i) i0
          | Instr.Affect (m, Expr.Fixed.F(_, Expr.BinOp (
              Expr.Fixed.F (_, Expr.Access m2),
              op,
              expr))) when List.mem op li &&
                           Mutable.equals Expr.equals m m2
            ->
            acc, Instr.SelfAffect (m, op, expr) |> Instr.Fixed.fixa (Instr.Fixed.annot i)
          | _ -> acc, i) acc i
    ) acc li
