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


(** Variable names generator
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)


open Stdlib
open Ast

let var_of_int =
  let alpha = Array.init 26 (fun i -> char_of_int (i + (int_of_char 'a') ) ) in
  let len = 26 in
  let rec f i =
    let s = String.make 1 alpha.(i mod len)  in
    if i / len == 0 then s
    else
      (f (i / len) ) ^ s
  in f;;

let bindings = ref BindingSet.empty

let add s =
  bindings := BindingSet.add s !bindings

let fresh_init prog =
  let addset acc i = Instr.Writer.Deep.fold
    (fun acc i ->
      match Instr.unfix i with
      | Instr.Declare (b, _, _, _)
      | Instr.DeclRead (_, b, _)
      | Instr.AllocRecord(b, _, _)
      | Instr.AllocArray (b, _, _, None)
      | Instr.Loop (b, _, _, _)
        -> BindingSet.add b acc
      | Instr.AllocArray (b1, _, _, Some (b2, _))
        ->
        BindingSet.add b1 (BindingSet.add b2 acc)
      | Instr.Untuple (li, e) ->
        List.fold_left (fun acc (_, name) -> BindingSet.add name acc) acc li
      | _ -> acc
    ) acc i
  in
  let addtop (acc : BindingSet.t) t : BindingSet.t = match t with
    | Prog.DeclarFun (v, t, params, instrs, _) ->
      let acc = BindingSet.add v acc in
      let acc:BindingSet.t = List.fold_left
        (fun acc ((v:string), _ ) -> BindingSet.add v acc)
        acc params in
      let acc:BindingSet.t = List.fold_left addset acc instrs in
      acc
    | _ -> acc
  in
  let set = BindingSet.empty in
  let set = match prog.Prog.main with
    | None -> set
    | Some instrs -> List.fold_left addset set instrs in
  let set = List.fold_left addtop set prog.Prog.funs in
  let () = bindings := set
  in ();;

let fresh =
  let r = ref (-1) in
  let rec gen () =
    r := !r + 1 ;
    let out = var_of_int !r in
    if BindingSet.mem out !bindings then gen () else out
  in gen


