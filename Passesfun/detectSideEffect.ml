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

  type acc = effect IntMap.t -> effect IntMap.t
module A = Expr.Fixed.Apply(Applicatives.Accumule(struct
  type t = effect IntMap.t -> effect IntMap.t
  let zero acc = acc
  let merge acc1 acc2 map = acc1 (acc2 map)
end))

let add i v acc a = IntMap.add i v (acc a)

let side_effects : int -> (acc * effect Expr.tofix) -> (acc * effect) = fun i (acc, e) ->
  let v = match e with
  | Expr.Fun _ -> EPure
  | Expr.FunTuple _ -> EPure
  | Expr.Lief (Expr.Binding (Ast.UserName a)) when Tags.is_taged ("macro_" ^ a ^ "_pure") -> EMacro
  | Expr.Lief _ -> EPure
  | Expr.Apply (EMacro, _)
  | Expr.LetRecIn _
  | Expr.UnOp _
  | Expr.BinOp _
  | Expr.Tuple _
  | Expr.Comment _
  | Expr.LetIn _
  | Expr.If _
  | Expr.Block _ -> Expr.Fixed.Surface.fold  (||) EPure e
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
    EEffect
  in add i v acc, v

let tr e = fst (A.fm2i side_effects (fun x y -> assert false) e)

let apply p =
  let side_effects = List.fold_left (fun acc e -> match e with
  | Declaration (name, e) -> tr e acc
  | _ -> acc
  ) IntMap.empty p.declarations
  in {p with side_effects = side_effects }

