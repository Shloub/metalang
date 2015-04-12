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

module BindingMap = Ast.BindingMap


let rec tr annot e =
  let fix = Expr.Fixed.fixa annot in
  let default acc = Expr.Fixed.Surface.map (fun (_, e) -> e acc) e |> fix in
  match e with
  | Expr.Lief (Expr.Binding b) -> true, (fun acc -> begin match BindingMap.find_opt b acc with
    | None -> default acc
    | Some n -> fix n
  end)
  | Expr.Lief _ -> true, default
  | Expr.LetIn (name, (true, l), (inlinein, in_)) -> inlinein, (fun acc ->
     in_ $ BindingMap.add name (Expr.unfix (l acc)) acc)
  | Expr.LetIn (name, (_, expr), (_, in_)) -> false, (fun acc ->
     let acc2 = BindingMap.remove name acc in
     fix $ Expr.LetIn (name, expr acc, in_ acc2))
  | Expr.LetRecIn (name, names, (_, e1), (_, e2)) -> false, (fun acc ->
     let acc = BindingMap.remove name acc in
     let acc2 = List.fold_left (fun acc n -> BindingMap.remove n acc) acc names in
     fix $ Expr.LetRecIn (name, names, e1 acc2, e2 acc))
  | Expr.Fun (names, (_, in_)) -> false, (fun acc ->
     let acc = List.fold_left (fun acc n -> BindingMap.remove n acc) acc names in
     fix $ Expr.Fun (names, in_ acc))
  | Expr.FunTuple (names, (_, in_)) -> false, (fun acc ->
     let acc = List.fold_left (fun acc n -> BindingMap.remove n acc) acc names in
     fix $ Expr.FunTuple (names, in_ acc))
  | _ -> false, default

let apply p =
  let declarations = List.map (function
  | Declaration (name, e) -> Declaration (name, (snd (Expr.Fixed.Deep.folda tr e)) BindingMap.empty)
  | x -> x
  ) p.declarations
  in {p with declarations = declarations }

