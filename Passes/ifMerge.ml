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

(**
    Cette passe de compilation permet d'ajouter un else là ou on peut :
    exemple ::

    if ... then
    ...
    return ...
    end
    ...

    On peut facilement ajouter un else :

    if ... then
    ...
    return ...
    else
    ...
    end

    En ocaml, le code généré sera beaucoup plus propre.

    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open Fresh
open PassesUtils

let rec returns instrs =
  List.fold_left
    returns_i false instrs
and returns_i acc i = match Instr.unfix i with
  | Instr.Return _ -> true
  | Instr.If (_, li1, li2) ->
    acc || ( (returns li1) && returns li2 )
  | _ -> acc

type acc0 = unit
type 'a acc = unit;;
let init_acc () = ();;
let process () i =
  let rec f acc = function
    | [] -> List.rev acc
    | [i] ->
      let i = g i in
      List.rev (i :: acc)
    | hd::tl ->
      let hd = g hd in
      match Instr.unfix hd with
      | Instr.If (e, l1, l2) ->
        let l1 = f [] l1 in
        let l2 = f [] l2 in
        if returns l1 then
          let l2 = l2 @ tl in
          let l2 = f [] l2 in
          (Instr.if_ e l1 l2 ) :: acc |> List.rev
        else if returns l2 then
          let l1 = l1 @ tl in
          let l1 = f [] l1 in
          (Instr.if_ e l1 l2 ) :: acc |> List.rev
        else f (hd :: acc) tl
      | _ -> f (hd :: acc) tl
  and g instr =
    let annot = Instr.Fixed.annot instr in
    let instr = Instr.Fixed.Surface.mapt g instr
    in
    match Instr.unfix instr with
    | Instr.AllocArray (var, ty, e, Some (var2, li), opt) ->
      let li = f [] li in
      let unfixed = Instr.alloc_array_lambda var ty e var2 li opt |> Instr.unfix
      in Instr.fixa annot unfixed
    | i -> instr
  in
  (), f [] i
