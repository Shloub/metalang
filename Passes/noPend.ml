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


(**
   Cette passe permet de déclarer une variable pour quelques expressions.
   Elle est utilisée dans le but de réduire les ambiguités sur l'ordre d'execution

   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)


open Stdlib

open Ast
open PassesUtils

type acc0 = unit
type 'lex acc = unit

let locate loc instr =
  PosMap.add (Instr.Fixed.annot instr) loc; instr

let locatee loc e =
  PosMap.add (Expr.Fixed.annot e) loc; e

let locatem loc m =
  PosMap.add (Mutable.Fixed.annot m) loc; m

let process () i =
  let inner_map t0 : 'lex Instr.t list =
    match Instr.unfix t0 with
    | Instr.AllocArray(
        _, _,
        Expr.Fixed.F (_,
                      (
                        Expr.Lief _ | Expr.Access (
                          Mutable.Fixed.F
                            (_, Mutable.Var _)))), _, _) ->
      [t0]
(*
    | Instr.Print(_, Expr.Fixed.F
      (_,
       (Expr.Access ( Mutable.Fixed.F
                        (_, Mutable.Var _))
           | Expr.Lief _
       )
      )) ->
      [t0]
    | Instr.Print(t, e) ->
      begin match Type.unfix t with
      | Type.Bool ->
        let annot = Instr.Fixed.annot t0 in
        let loc = PosMap.get (Instr.Fixed.annot t0) in
        let b = Fresh.fresh_internal () in
        [
          Instr.Declare (b, t, e, Instr.default_declaration_option) |> Instr.fixa annot |> locate loc;
          Instr.Print(t, locatee loc (Expr.access (locatem loc (Mutable.var b))))
        |> Instr.fixa annot |> locate loc;
        ]
      | _ -> [t0]
      end *)
    | Instr.AllocArray(b0, t, e, lambdaopt, opt) ->
      let annot = Instr.Fixed.annot t0 in
      let loc = PosMap.get (Instr.Fixed.annot t0) in
      let b = Fresh.fresh_internal () in
      [
        Instr.Declare (b, Type.integer, e, Instr.useless_declaration_option) |> Instr.fixa annot;
        Instr.AllocArray(b0, t,
                         Expr.access (Mutable.var b),
                         lambdaopt, opt) |> Instr.fixa annot  |> locate loc;
      ]
    | _ -> [t0]
  in let fixed_map (t:'lex Instr.t) =
       Instr.deep_map_bloc
         (List.flatten @* (List.map inner_map))
         (Instr.unfix t)
       |> Instr.fixa (Instr.Fixed.annot t)
  in
  let i = List.flatten (List.map (inner_map @* fixed_map) i) in
  (), i

let init_acc () = ()
