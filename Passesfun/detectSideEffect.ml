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
   Cette passe renvoie une map qui permet de déterminer si une expression effectue des
   effets de bords.
   Elle est très utilisée par le printer Haskell.
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

let (||) a b = match a, b with
  | EEffect, _ -> EEffect
  | _, EEffect -> EEffect
  | _ -> EPure

let empty acc = acc
let add i v acc a = IntMap.add i v (acc a)
let merge acc1 acc2 map = acc1 (acc2 map)

let side_effects i e =
  let v, acc = match e with
  | Expr.Fun (_, (_, acc)) -> EPure, acc
  | Expr.FunTuple (_, (_, acc)) -> EPure, acc
  | Expr.Lief (Expr.Binding (Ast.UserName a)) when Tags.is_taged ("macro_" ^ a ^ "_pure") -> EMacro, empty
  | Expr.Lief _ -> EPure, empty
  | Expr.Apply ((EMacro, _), _)
  | Expr.LetRecIn _
  | Expr.UnOp _
  | Expr.BinOp _
  | Expr.Tuple _
  | Expr.Comment _
  | Expr.LetIn _
  | Expr.If _
  | Expr.Block _ -> Expr.Fixed.Surface.fold
		      (fun (has, acc) (has2, acc2) ->
		       has || has2,
		       merge acc acc2) (EPure, empty) e
  | Expr.Skip
  | Expr.Apply _
  | Expr.MultiPrint _
  | Expr.RecordAffect _
  | Expr.RecordAccess _
  | Expr.ArrayInit _
  | Expr.ArrayMake _
  | Expr.ArrayAccess _
  | Expr.ArrayAffect _
  | Expr.Print _
  | Expr.ReadIn _
  | Expr.Record _ ->
     let acc = Expr.Fixed.Surface.fold (fun acc2 (_, acc) -> merge acc acc2) empty e in
    EEffect, acc
  in v, add i v acc

let tr e = snd (Expr.Fixed.Deep.folda side_effects e)

let apply p =
  let side_effects = List.fold_left (fun acc e -> match e with
  | Declaration (name, e) -> tr e acc
  | _ -> acc
  ) IntMap.empty p.declarations
  in {p with side_effects = side_effects }

