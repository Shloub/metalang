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


(** Cette passe effectue une normalisation du printing de booleans
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)


open Stdlib

open Ast
open Fresh
open PassesUtils

type acc0 = unit

let write_bool e =
  Instr.if_ e
    [ Instr.print Type.string (Expr.string "True") ]
    [ Instr.print Type.string (Expr.string "False") ]

let rewrite (i: Utils.instr) = match Instr.unfix i with
  | Instr.Print li ->
    let li, last_print = List.fold_left
        (fun (liacc, lip) -> function
           | Instr.StringConst s -> liacc, (Instr.StringConst s) :: lip
           | Instr.PrintExpr (Type.Fixed.F (_, Type.Bool), b) ->
             let ni = write_bool b
             in begin match lip with
               | [] ->ni :: liacc, []
               | _ -> ni :: (Instr.Print (List.rev lip) |> Instr.fix)::liacc, []
             end
           | Instr.PrintExpr (t, e) ->
             liacc, (Instr.PrintExpr (t, e)) :: lip
        ) ([], []) li in
    let li = match last_print with
      | [] -> li
      | _ -> (Instr.Print (List.rev last_print) |> Instr.fix) :: li
    in List.rev li
  | _ -> [i]

let rewrite_li l = List.map rewrite l |> List.flatten

type 'lex acc = unit
let init_acc _ = ()
let process () (li:Utils.instr list) =
  (),
  let li = rewrite_li li in
  List.map (fun i ->
      let i0 = Instr.deep_map_bloc rewrite_li (Instr.unfix i)
      in Instr.fixa (Instr.Fixed.annot i) i0 ) li


