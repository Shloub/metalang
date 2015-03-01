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

open Stdlib
open AstFun

(**
   Passes de transformations sur l'ast fonctionnel
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

let has_side_effects acc e = IntMap.find (Expr.Fixed.annot e) acc

let side_effects acc e =
  let has = match Expr.unfix e with
    | Expr.Skip -> true
    | Expr.LetRecIn (_, _, e1, e2) ->
      has_side_effects acc e1 || has_side_effects acc e2
    | Expr.UnOp (e, _) -> has_side_effects acc e
    | Expr.BinOp (a, _, b) ->
      has_side_effects acc a || has_side_effects acc b
    | Expr.Fun _ -> false
    | Expr.FunTuple _ -> false
    | Expr.Apply (a, li) ->
        begin match Expr.unfix a with
        | Expr.Lief (Expr.Binding a) ->
            if Tags.is_taged ("macro_" ^ a ^ "_pure")
            then
              List.exists (has_side_effects acc) li
            else true
        | _ -> true
        end
(*
      List.exists (has_side_effects acc) li || has_side_effects acc a (* TODO sur l'application de a ... on devrait faire un typage a effets... *) *)
    | Expr.Tuple li ->
      List.exists (has_side_effects acc) li
    | Expr.Lief _ -> false
    | Expr.Comment (_, e) -> has_side_effects acc e
    | Expr.If (a, b, c) ->
      has_side_effects acc a ||
        has_side_effects acc b ||
        has_side_effects acc c
    | Expr.Print _ -> true
    | Expr.ReadIn _ -> true
    | Expr.Block li ->
      List.exists (has_side_effects acc) li
    | Expr.Record li ->
			true
(*
      List.exists (fun (e, name) -> has_side_effects acc e) li *)
    | Expr.RecordAffect _ -> true
    | Expr.RecordAccess _ -> true
    | Expr.ArrayInit _ -> true
    | Expr.ArrayMake (a, b, c) -> true
    | Expr.ArrayAccess _ -> true
    | Expr.ArrayAffect _ -> true
    | Expr.LetIn (binding, e1, e) -> has_side_effects acc e || has_side_effects acc e1
    | Expr.MultiPrint (_, _) -> true
		| Expr.Tuple (li) ->
			List.exists (has_side_effects acc) li

  in IntMap.add (Expr.Fixed.annot e) has acc

let tr acc e = Expr.Writer.Deep.fold side_effects acc e

let apply p =
  let side_effects = List.fold_left (fun acc e -> match e with
  | Declaration (name, e) -> tr acc e
	| _ -> acc
  ) p.side_effects p.declarations
  in {p with side_effects = side_effects }

