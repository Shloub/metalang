(*
 * Copyright (c) 2015, Prologin
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
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
  
type acc0 = unit
type 'lex acc = unit
let init_acc () = ()

let rec merge_prints = function
  | [] -> []
  | Instr.StringConst s1 :: Instr.StringConst s2 :: tl ->
      merge_prints (Instr.StringConst (s1 ^ s2) :: tl)
  | hd:: tl -> hd :: merge_prints tl

let insert_prints instructions prints =
  match prints with
  | [] -> instructions
  | prints ->
      let prints = List.rev prints in
      let prints = merge_prints prints in
      (Instr.Print prints |> Instr.fix)::instructions
        
let processli is =
  let li, prints =
    List.fold_left (fun (instructions, prints) i ->
      match Instr.unfix i with
      | Instr.Print li -> instructions, List.rev_append li prints
      | _ -> i :: insert_prints instructions prints, []) ([], []) is
  in List.rev (insert_prints li prints)

let process () (li:Utils.instr list) =
  (),
  let li = processli li in
  List.map (fun i ->
    let i0 = Instr.deep_map_bloc processli (Instr.unfix i)
    in Instr.fixa (Instr.Fixed.annot i) i0) li
