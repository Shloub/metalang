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
 *)

(** Cette passe compte le nombre de constructions qui n'ont pas de position attachée. Elle est utile pour débuguer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open Fresh
open PassesUtils

type acc0 = unit
type 'a acc = int

let init_acc () = 0

let count_type e =
  Type.Fixed.Deep.foldmap2i_topdown (fun i _ acc ->
    (if Ast.PosMap.mem i then acc else acc + 1), ())
    (fun b acc -> acc, b) e 0 |> fst

let fmut m = Mutable.Fixed.Deep.folda (fun i m ->
  let acc = if Ast.PosMap.mem i then 0 else 1
  in match m with
  | Mutable.Array (_, li) -> List.fold_left (+) acc li
  | _ -> acc ) m

let fexpr e = Expr.Fixed.Deep.folda (fun i e ->
  let acc = if Ast.PosMap.mem i then 0
  else 1
  in match e with
  | Expr.Access mut -> acc + fmut mut
  | _ -> Expr.Fixed.Surface.fold (+) acc e) e

let count_tys e = List.fold_left (fun acc e -> acc + count_type e) 0 e


let finstr i =
  Instr.Fixed.Deep.fold2i_bottomup
    (fun annot instr ->
      let acc = if Ast.PosMap.mem annot then 0
      else 1
      in match instr with
      | Instr.Affect (m, e) -> acc + e + fmut m
      | Instr.Read li ->
          List.fold_left (fun acc -> function
            | Instr.Separation -> acc
            | Instr.DeclRead (t, _, _) -> acc + count_type t
            | Instr.ReadExpr (t, e) ->
                acc + count_type t + fmut e ) acc li
      | Instr.Declare (_, t, e, _) -> acc + count_type t + e
      | Instr.AllocArray (_, t, e, _, _) -> acc + count_type t + e
      | Instr.AllocArrayConst (_, t, e, _, _) -> acc + count_type t + e
      | Instr.AllocRecord (_, t, li, _) -> count_type t + List.fold_left (fun acc (_, e) -> acc + e) acc li
      | Instr.Print li ->
          List.fold_left (fun acc -> function
            | Instr.StringConst _str -> acc
            | Instr.PrintExpr (t, e) -> acc + count_type t + e) acc li
      | _ -> Instr.Fixed.Surface.fold (+) acc instr
    )
    fexpr i

let count (li: 'a Ast.Expr.t Ast.Instr.t list) =
  List.fold_left (fun acc i -> acc + finstr i) 0 li

let process acc p =
  match p with
  | Prog.DeclarFun (funname, t, params, instrs, opt) ->
    (acc + count instrs +
       count_type t +
       count_tys (List.map snd params)
    ), Prog.DeclarFun (funname, t, params, instrs, opt)
  | _ -> acc, p

let process_main acc m = acc + count m, m
