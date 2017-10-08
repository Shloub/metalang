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

(** Cette passe collecte les types utilisés.
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ext

open Ast
open Fresh
open PassesUtils

type acc0 = Typer.env
type 'a acc = Typer.env * TypeSet.t

let init_acc tyenv = tyenv, TypeSet.empty

let rec collect_type acc t =
  let loc = Ast.PosMap.get (Type.Fixed.annot t) in
  let f orig t (tyenv, acc) =
    if TypeSet.mem orig acc then (tyenv, acc) else
      match t with
      | Type.Named n ->
        let acc = TypeSet.add orig acc in
        collect_type (tyenv, acc) (Typer.expand tyenv orig loc)
      | _ ->
        let acc =TypeSet.add orig acc in
        Type.Fixed.Surface.fold (fun acc f -> f acc) (tyenv, acc) t
  in Type.Fixed.Deep.foldorig f t acc

let collect_instr acc i =
  let f acc i =
    match Instr.unfix i with
    | Instr.Declare (_, ty, _, _)
    | Instr.AllocRecord (_, ty, _, _)
    | Instr.AllocArray (_, ty, _, _, _)
    | Instr.AllocArrayConst (_, ty, _, _, _)
      -> collect_type acc ty
    | Instr.Read li ->
      List.fold_left (fun acc -> function
          | Instr.DeclRead (ty, _, _) -> collect_type acc ty
          | _ -> acc ) acc li
    | _ -> acc
  in Instr.Writer.Deep.fold f acc i

let process_main acc m = (List.fold_left collect_instr acc m), m

let process acc p =
  let acc = match p with
    | Prog.DeclarFun (_funname, t, params, instrs, _) ->
      let acc = collect_type acc t in
      let acc = List.fold_left (fun acc (_, t) -> collect_type acc t)
          acc params in
      List.fold_left collect_instr acc instrs
    | _ -> acc
  in acc, p
