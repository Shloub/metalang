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

let transform e = match Expr.unfix e with
  | Expr.Tuple [] -> Expr.unit
  | Expr.Tuple ([e]) -> e
  | Expr.Block [hd] -> hd
  | Expr.Block [
    Expr.Fixed.F (_, Expr.Print (e, ty)) ;
    Expr.Fixed.F (_, Expr.Lief (Expr.Unit))
  ] ->
    Expr.print_ e ty
  | Expr.Block li when (List.exists (fun e -> match Expr.unfix e with
    | Expr.Block _ -> true
    | _ -> false
  ) li)->
    let li = List.flatten (List.map (fun e -> match Expr.unfix e with
      | Expr.Block li -> li
      | _ -> [e]
    ) li) in
    Expr.block li
  | Expr.FunTuple ([param], e) -> Expr.fun_ [param] e
  | Expr.Fun (params, ( Expr.Fixed.F (_, Expr.Fun (params2, expr)))) ->
    Expr.fun_ (List.append params params2) expr
  | Expr.Apply ( Expr.Fixed.F (_, Expr.FunTuple (params, expr)), [Expr.Fixed.F (_, Expr.Tuple values)]) ->
    Expr.letand (List.combine params values) expr
  | Expr.Apply ( (Expr.Fixed.F (_, Expr.Fun (params, expr) ), values)) ->
    let rec f expr = function
      | ([], []) -> expr
      | (li, []) -> Expr.fun_ li expr
      | ([], li) -> Expr.apply expr li
      | (param::tl1, value::tl2) ->
	let in_ = f expr (tl1, tl2) in
	Expr.letin param value in_
    in f expr (params, values)
  | _ -> e

let rec tr e =
  let e2 = Expr.Writer.Deep.map transform (transform e)
  in if e = e2 then e
    else tr e2

let apply p =
  List.map (function
  | Declaration (name, e) -> Declaration (name, tr e)
  | x -> x
  ) p

