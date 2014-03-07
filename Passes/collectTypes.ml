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

(** Some passes
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open Fresh
open PassesUtils

  type acc0 = Typer.env
  type 'a acc = Typer.env * TypeSet.t

  let init_acc tyenv = tyenv, TypeSet.empty

  let rec collect_type acc t =
    let loc = Ast.PosMap.get (Type.Fixed.annot t) in
    let f (tyenv, acc) t =
      if TypeSet.mem t acc then (tyenv, acc) else
      match Type.Fixed.unfix t with
      | Type.Named n ->
	let acc = TypeSet.add t acc in
	collect_type (tyenv, acc) (Typer.expand tyenv t loc)
      | x -> tyenv, TypeSet.add t acc
    in Type.Writer.Deep.fold f acc t

  let rec process_mutable acc m =
    let f acc m = match Mutable.Fixed.unfix m with
(*       | Mutable.Dot (m, f) -> *)
      | Mutable.Array (m, li) ->
	List.fold_left process_expr acc li
      | e -> acc
    in Mutable.Writer.Deep.fold f acc m
  and process_expr acc e =
    let f acc e = match Expr.Fixed.unfix e with
(*      | Expr.Enum s -> TODO *)
      | Expr.Access m -> process_mutable acc m
      | e -> acc
    in Expr.Writer.Deep.fold f acc e

  let collect_instr acc i =
    let f acc i =
      match Instr.unfix i with
        | Instr.Declare (_, ty, _) -> collect_type acc ty
	| Instr.AllocRecord (_, ty, _) -> collect_type acc ty
	| Instr.AllocArray (_, ty, _, _) -> collect_type acc ty
        | _ -> acc
    in
    let acc = Instr.Writer.Deep.fold f acc i
    in Instr.fold_expr process_expr acc i

  let process_main acc m = (List.fold_left collect_instr acc m), m

  let process acc p =
    let acc = match p with
      | Prog.DeclarFun (_funname, t, params, instrs) ->
	let acc = collect_type acc t in
	let acc = List.fold_left (fun acc (_, t) -> collect_type acc t)
	  acc params in
        List.fold_left collect_instr acc instrs
      | _ -> acc
    in acc, p
