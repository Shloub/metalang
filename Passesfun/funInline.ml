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
   Passes de transformations sur l'ast fonctionnel. on inline les expressions de type Lief.
   à l'avenir, on pourrait le faire sur des expressions plus complexes comme les opérations élémentaires.
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)



let rec tr acc e =
  let fix e0 = Expr.Fixed.fixa (Expr.Fixed.annot e) e0 in
  match Expr.unfix e with
  | Expr.Lief (Expr.Binding b) -> begin match StringMap.find_opt b acc with
					| None -> e
					| Some n -> fix n
				  end
  | Expr.LetIn (name, ((Expr.Fixed.F (_, Expr.Lief _)) as l), in_) ->
     let l = tr acc l in
     let acc = StringMap.add name (Expr.unfix l) acc in
     tr acc in_
  | Expr.LetIn (name, expr, in_) ->
     let expr = tr acc expr in
     let acc = StringMap.remove name acc in
     let in_ = tr acc in_ in
     fix (Expr.LetIn (name, expr, in_))
  | Expr.LetRecIn (name, names, e1, e2) ->
     let acc = StringMap.remove name acc in
     let e2 = tr acc e2 in
     let acc = List.fold_left (fun acc n -> StringMap.remove n acc) acc names in
     let e1 = tr acc e1 in
     fix (Expr.LetRecIn (name, names, e1, e2))
  | Expr.Fun (names, in_) ->
     let acc = List.fold_left (fun acc n -> StringMap.remove n acc) acc names in
     let in_ = tr acc in_
     in fix (Expr.Fun (names, in_))
  | Expr.FunTuple (names, in_) ->
     let acc = List.fold_left (fun acc n -> StringMap.remove n acc) acc names in
     let in_ = tr acc in_ in
     fix ( Expr.FunTuple (names, in_))
  | _ -> Expr.Writer.Surface.map (tr acc) e

let apply p =
  let declarations = List.map (function
  | Declaration (name, e) -> Declaration (name, tr StringMap.empty e)
  | x -> x
  ) p.declarations
  in {p with declarations = declarations }

