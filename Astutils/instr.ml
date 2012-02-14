open Stdlib
open Ast

type 'a tofix =
    Declare of varname * Type.t * Expr.t
  | Affect of varname * Expr.t
  | AffectArray of varname * Expr.t * Expr.t
  | Loop of varname * Expr.t * Expr.t * Expr.t * 'a list
  | Comment of string
  | Return of Expr.t
  | AllocArray of varname * Type.t * Expr.t
  | If of Expr.t * 'a list * 'a list

type t = F of t tofix
let unfix = function F x -> x
let fix x = F x

let declare v t e =  Declare (v, t, e) |> fix
let affect v e = Affect (v, e) |> fix
let affect_array v e1 e2 = AffectArray (v, e1, e2) |> fix
let loop v e1 e2 e3 li = Loop (v, e1, e2, e3, li) |> fix
let comment s = Comment s |> fix
let return e = Return e |> fix
let alloc_array binding t len =
  AllocArray(binding, t, len) |> fix
let if_ e cif celse =
  If (e, cif, celse) |> fix


let map f acc t = match t with
  | Declare (_, _, _) -> t
  | Affect (var, e) -> t
  | AffectArray (var, e1, e2) -> t
  | Comment s -> t
  | Loop (var, e1, e2, e3, li) ->
      Loop (var, e1, e2, e3,
	    List.map ( fix @* f @* unfix ) li)
  | If (e, cif, celse) ->
      let cif = List.map (fix @* f @* unfix) cif in
      let celse = List.map (fix @* f @* unfix) celse in
      If (e, cif, celse)
  | Return e -> Return e
  | AllocArray (_, _, _) -> t
