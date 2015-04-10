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
   Passes de transformations sur l'ast fonctionnel :
   on transforme (fun x -> ...a) ...b en let x = ...b in ...a
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

let transform curry e = match Expr.unfix e with
  | Expr.Tuple [] -> Expr.unit
  | Expr.Tuple ([e]) -> e
  | Expr.Block [hd] -> hd
  | Expr.Block [
    Expr.Fixed.F (_, (
      (Expr.Print _) | (Expr.RecordAffect _) | (Expr.ArrayAffect _))) as e ;
    Expr.Fixed.F (_, Expr.Lief (Expr.Unit))
  ] -> e
  | Expr.Block li when (List.exists (fun e -> match Expr.unfix e with
    | Expr.Block _ -> true
    | _ -> false
  ) li)->
    let li = List.flatten (List.map (fun e -> match Expr.unfix e with
      | Expr.Block li -> li
      | _ -> [e]
    ) li) in
    Expr.block li
  | Expr.Block li when List.exists (fun e -> match Expr.unfix e with
    | Expr.LetIn _ -> true | _ -> false) (List.tl (List.rev li)) ->
    let rec f acc = function
      | [] -> assert false
      | hd::tl -> match Expr.unfix hd with
	| Expr.LetIn (name, v, e) -> List.rev ( (Expr.letin name v (Expr.block (e::tl))) :: acc)
	| _ -> f (hd::acc) tl
    in Expr.block (f [] li)
  | Expr.Apply (Expr.Fixed.F (_, Expr.FunTuple ([], e1)), [e2]) -> Expr.block [e2; e1]
  | Expr.FunTuple ([param], e) -> Expr.fun_ [param] e
  | Expr.Fun (params, ( Expr.Fixed.F (_, Expr.Fun (params2, expr)))) when curry ->
    Expr.fun_ (List.append params params2) expr
  | Expr.Apply ( Expr.Fixed.F (_, Expr.FunTuple (params, expr)), [Expr.Fixed.F (_, Expr.Tuple values)]) ->
    List.fold_left (fun acc (name, v) -> Expr.letin name v acc) expr (List.combine params values)
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

let rec tr curry e =
  let e2 = Expr.Fixed.Deep.map (transform curry) e
  in if e = e2 then e
    else tr curry e2

let apply curry p =
  let declarations = List.map (function
  | Declaration (name, e) -> Declaration (name, tr curry e)
  | x -> x
  ) p.declarations
  in {p with declarations = declarations }

