open Stdlib
open Ast

type 'a tofix =
    Declare of varname
  | Affect of varname * Expr.t
  | AffectArray of varname * Expr.t * Expr.t
  | Loop of varname * Expr.t * Expr.t * Expr.t * 'a list
  | Comment of string
  | Return of Expr.t
  | AllocArray of varname * Type.t * Expr.t

type t = F of t tofix
let unfix = function F x -> x
let fix x = F x

let declare v =  Declare v |> fix
let affect v e = Affect (v, e) |> fix
let affect_array v e1 e2 = AffectArray (v, e1, e2) |> fix
let loop v e1 e2 e3 li = Loop (v, e1, e2, e3, li) |> fix
let comment s = Comment s |> fix
let return e = Return e |> fix
let alloc_array binding t len =
  AllocArray(binding, t, len) |> fix

let map f acc t = match t with
  | Declare var -> t
  | Affect (var, e) -> t
  | AffectArray (var, e1, e2) -> t
  | Comment s -> t
  | Loop (var, e1, e2, e3, li) ->
      Loop (var, e1, e2, e3,
	    List.map ( fix @* f @* unfix ) li)
  | Return e -> Return e
  | AllocArray (_, _, _) -> t
