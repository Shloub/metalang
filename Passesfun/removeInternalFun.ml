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

open Stdlib
open AstFun

(**
   remplace les noms de variables internes par des noms affichables
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

module BindingMap = Ast.BindingMap

let rec tr acc e =
  let process_name acc n = match n with
  | Ast.UserName _ -> acc, n
  | Ast.InternalName _ ->
      let newname = Ast.UserName (Fresh.fresh_user ())  in
      let acc = BindingMap.add n newname acc in
      acc, newname in
  let process_names names acc = 
    List.fold_left_map process_name acc names in
  let fix e0 = Expr.Fixed.fixa (Expr.Fixed.annot e) e0 in
  match Expr.unfix e with
  | Expr.Lief (Expr.Binding ( (Ast.InternalName _) as n)) ->
      let newname = BindingMap.find n acc in
      Expr.Lief (Expr.Binding newname) |> fix
  | Expr.LetIn ( (Ast.InternalName _) as n, v, in_) ->
      let newname = Ast.UserName (Fresh.fresh_user ())  in
      let v = tr acc v in
      let acc = BindingMap.add n newname acc in
      let in_ = tr acc in_ in
      Expr.LetIn (newname, v, in_) |> fix
  | Expr.LetRecIn (name, names, e1, e2) ->
      let acc, newname = process_name acc name in
      let e2 = tr acc e2 in
      let acc, names = process_names names acc in
      let e1 = tr acc e1 in
      Expr.LetRecIn (newname, names, e1, e2) |> fix
  | Expr.Fun (names, in_) ->
      let acc, names = process_names names acc in
      let in_ = tr acc in_ in
      Expr.Fun (names, in_) |> fix
  | Expr.FunTuple (names, in_) ->
      let acc, names = process_names names acc in
      let in_ = tr acc in_ in
      Expr.FunTuple (names, in_) |> fix
  | _ -> Expr.Fixed.Surface.mapt (tr acc) e


let apply p =
  let declarations = List.map (function
  | Declaration (name, e) -> Declaration (name, tr BindingMap.empty e)
  | x -> x
  ) p.declarations
  in {p with declarations = declarations }

