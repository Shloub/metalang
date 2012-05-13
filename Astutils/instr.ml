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
* @see http://prologin.org
* @author Prologin <info@prologin.org>
* @author Maxime Audouin <coucou747@gmail.com>
*
*)

open Stdlib
open Ast


let mutable_var varname = Mutable.Var varname |> Mutable.fix
let mutable_array m indexes = Mutable.Array (m, indexes) |> Mutable.fix
let mutable_dot m field = Mutable.Dot (m, field) |> Mutable.fix

type 'a tofix =
    Declare of varname * Type.t * Expr.t
  | Affect of Expr.t Mutable.t * Expr.t
  | Loop of varname * Expr.t * Expr.t * 'a list
  | While of Expr.t * 'a list
  | Comment of string
  | Return of Expr.t
  | AllocArray of varname * Type.t * Expr.t * (varname * 'a list) option
  | AllocRecord of varname * Type.t * (fieldname * Expr.t) list
  | If of Expr.t * 'a list * 'a list
  | Call of funname * Expr.t list
  | Print of Type.t * Expr.t
  | Read of Type.t * Expr.t Mutable.t
  | DeclRead of Type.t * varname
  | StdinSep

type t = F of t tofix
let unfix = function F x -> x
let fix x = F x
let stdin_sep = StdinSep |> fix
let print t v = Print (t, v) |> fix
let read t v = Read (t, v) |> fix
let readdecl t v = DeclRead (t, v) |> fix
let call v p = Call (v, p) |> fix
let declare v t e =  Declare (v, t, e) |> fix
let affect v e = Affect (v, e) |> fix
let loop v e1 e2 li = Loop (v, e1, e2, li) |> fix
let while_ e li = While (e, li) |> fix
let comment s = Comment s |> fix
let return e = Return e |> fix
let alloc_array binding t len =
  AllocArray(binding, t, len, None) |> fix
let alloc_record binding t fields =
  AllocRecord(binding, t, fields) |> fix
let alloc_array_lambda binding t len b e=
  AllocArray(binding, t, len, Some ( (b, e) ) ) |> fix
let if_ e cif celse =
  If (e, cif, celse) |> fix

let map_bloc ( f : 'a list -> 'b list) (t : 'a tofix) : 'b tofix = match t with
  | Declare (_, _, _) -> t
  | Affect (var, e) -> t
  | Comment s -> t
  | Loop (var, e1, e2, li) ->
      Loop (var, e1, e2, f li)
  | While (e, li) -> While (e, f li)
  | If (e, cif, celse) ->
      If (e, f cif, f celse)
  | Return e -> Return e
  | AllocArray (b, t, l, Some ((b2, li))) ->
    AllocArray (b, t, l, Some((b2, f li)))
  | AllocArray (_, _, _, None) ->
    t
  | AllocRecord (_, _, _) ->
    t
  | Print _ -> t
  | Read _ -> t
  | DeclRead _ -> t
  | Call _ -> t
  | StdinSep -> t

let map (f : 'a -> 'b) (t : 'a tofix) : 'b tofix =
  map_bloc (List.map f) t

module Writer = AstWriter.F (struct
  type alias = t;;
  type t = alias;;
  let foldmap f acc t =
    match unfix t with
      | StdinSep -> acc, t
      | Declare (_, _, _) -> acc, t
      | Affect (_, _) -> acc, t
      | Comment _ -> acc, t
      | Loop (var, e1, e2, li) ->
	let acc, li = List.fold_left_map f acc li in
	acc, fix (Loop(var, e1, e2, li))
      | While (e, li) ->
	let acc, li = List.fold_left_map f acc li in
	acc, fix (While (e, li))
      | If (e, cif, celse) ->
	let acc, cif = List.fold_left_map f acc cif in
	let acc, celse = List.fold_left_map f acc celse in
	acc, fix (If(e, cif, celse))
      | Return e -> acc, t
      | AllocArray (_, _, _, None) -> acc, t
      | AllocArray (b, t, l, Some (b2, li)) ->
	let acc, li = List.fold_left_map f acc li in
	acc, fix(AllocArray (b, t, l, Some (b2, li)) )
      | AllocRecord (_, _, _) ->
	acc, t
      | Print _ -> acc, t
      | Read _ -> acc, t
      | DeclRead _ -> acc, t
      | Call _ -> acc, t
end)

let foldmap_expr
    (f : 'acc -> Expr.t -> 'acc * Expr.t)
    (acc:'acc)
    (instruction:t) =
  Writer.Deep.foldmap
    (fun acc i ->
      let out, i =
	match unfix i with
	  | Declare (v, t, e) ->
	    let acc, e = f acc e in
	    acc, Declare (v, t, e)
	  | Affect (m, e) ->
	    let acc, e = f acc e in
	    acc, Affect (m, e)
	  | Loop (v, e1, e2, li) ->
	    let acc, e1 = f acc e1 in
	    let acc, e2 = f acc e2 in
	    acc, Loop(v, e1, e2, li)
	  | While (e, li) ->
	    let acc, e = f acc e in
	    acc, While (e, li)
	  | Comment s -> acc, Comment s
	  | Return e ->
	    let acc, e = f acc e in
	    acc, Return e
	  | AllocArray (v, t, e, liopt) ->
	    let acc, e = f acc e in
	    acc, AllocArray (v, t, e, liopt)
	  | AllocRecord (v, t, el) ->
	    let acc, el = List.fold_left_map
	      (fun acc (field, e) ->
		let acc, e = f acc e
		in acc, (field, e))
	      acc el
	    in acc, AllocRecord (v, t, el)
	  | If (e, li1, li2) ->
	    let acc, e = f acc e in
	    acc, If (e, li1, li2)
	  | Call (funname, li) ->
	    let acc, li = List.fold_left_map f acc li in
	    acc, Call (funname, li)
	  | Print (t, e) ->
	    let acc, e = f acc e in
	    acc, Print (t, e)
	  | Read (t, m) -> acc, Read (t, m)
	  | DeclRead (t, m) -> acc, DeclRead (t, m)
	  | StdinSep -> acc, StdinSep
      in out, fix i
    ) acc instruction

let map_expr f i =
  let f2 () e = (), (f e) in
  let (), i = foldmap_expr f2 () i
  in i

let fold_expr f acc i =
  let f2 acc e = (f acc e), e in
  let acc, _ = foldmap_expr f2 acc i
  in acc
