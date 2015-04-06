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
   Cette passe permet de supprimer la ré-affectation d'une variable.
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

module BindingMap = Ast.BindingMap

let mapname rename name =
	if BindingMap.mem name rename then
		let name2 = Fresh.fresh_internal () in
		BindingMap.add name name2 rename, name2
	else
    BindingMap.add name name rename, name

let mapfun f rename transform annot params e =
    let rename, params = List.fold_left_map mapname rename params
    in let e = transform rename e
    in Expr.Fixed.fixa annot (f params e)

let rec transform rename e =
  let annot = Expr.Fixed.annot e in
  match Expr.unfix e with
  | Expr.Fun (params, e) -> mapfun (fun params e -> Expr.Fun (params, e)) rename transform annot params e
	| Expr.FunTuple (params, e) -> mapfun (fun params e -> Expr.FunTuple (params, e)) rename transform annot params e
  | Expr.LetIn (name, v, e) ->
    let rename2, name=
      if BindingMap.mem name rename then
        let name2 = Fresh.fresh_internal () in
        BindingMap.add name name2 rename, name2
      else
        BindingMap.add name name rename, name in
		let v = transform rename v in
    let e = transform rename2 e
    in Expr.Fixed.fixa annot (Expr.LetIn (name, v, e))
  | Expr.LetRecIn (name, params, v, e) ->
    let rename2, name = mapname rename name in
		let rename3, params = List.fold_left_map mapname rename2 params in
		let v = transform rename3 v in
    let e = transform rename2 e
    in Expr.Fixed.fixa annot (Expr.LetRecIn (name, params, v, e))

  | Expr.Lief (Expr.Binding name) ->
    begin match BindingMap.find_opt name rename with
    | None -> e
    | Some name2 -> Expr.Fixed.fixa annot (Expr.Lief (Expr.Binding name2))
    end
	| _ -> Expr.Writer.Surface.map (transform rename) e

let tr e = transform BindingMap.empty e

let apply p =
  let declarations = List.map (function
  | Declaration (name, e) ->
    let e = tr e in Declaration (name, e)
  | x -> x
  ) p.declarations
  in {p with declarations = declarations }

