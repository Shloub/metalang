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


(** Passe de suppression des tuples
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Warner

open Stdlib

open Ast
open Fresh
open PassesUtils

type acc0 = unit

let locate loc instr =
  PosMap.add (Instr.Fixed.annot instr) loc; instr

let rec rewrite (i : Utils.instr) : Utils.instr list = match Instr.unfix i with
    | Instr.Untuple (li, e) ->
      let loc = PosMap.get (Instr.Fixed.annot i) in
      let t = Type.tuple (List.map fst li) in
      let b = fresh () in
      let vb = Mutable.var b in
      let access = List.mapi (fun i (t, name) ->
	Instr.Declare (name, t, Expr.access (Mutable.dot vb ("f"^(string_of_int i)))) |> Instr.fix |> locate loc
      ) li in
      (Instr.Declare (b, t, e) |> Instr.fix |> locate loc)::access
    | j -> [ Instr.deep_map_bloc (List.flatten @* List.map rewrite) j |> Instr.fixa (Instr.Fixed.annot i) ]
      
type 'lex acc = unit
let init_acc _ = ()
let process acc p =
  match p with
  | Prog.DeclarFun (x, y, z, instrs)->
    acc, Prog.DeclarFun (x, y, z, List.collect rewrite instrs)
  | _ -> acc, p
let process_main acc i = acc, List.collect rewrite i

