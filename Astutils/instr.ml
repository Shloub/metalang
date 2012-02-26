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
  | Call of funname * Expr.t list
  | Print of Type.t * Expr.t
  | Read of Type.t * varname

type t = F of t tofix
let unfix = function F x -> x
let fix x = F x

let print t v = Print (t, v) |> fix
let read t v = Read (t, v) |> fix
let call v p = Call (v, p) |> fix
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

let map_bloc ( f : 'a list -> 'b list) (t : 'a tofix) : 'b tofix = match t with
  | Declare (_, _, _) -> t
  | Affect (var, e) -> t
  | AffectArray (var, e1, e2) -> t
  | Comment s -> t
  | Loop (var, e1, e2, e3, li) ->
      Loop (var, e1, e2, e3, f li)
  | If (e, cif, celse) ->
      If (e, f cif, f celse)
  | Return e -> Return e
  | AllocArray (_, _, _) -> t
  | Print _ -> t
  | Read _ -> t
  | Call _ -> t

let map (f : 'a -> 'b) (t : 'a tofix) : 'b tofix =
  map_bloc (List.map f) t

module Writer = AstWriter.F (struct
  type alias = t;;
  type t = alias;;
  let foldmap f acc t =
    match unfix t with
      | Declare (_, _, _) -> acc, t
      | Affect (_, _) -> acc, t
      | AffectArray (_, _, _) -> acc, t
      | Comment _ -> acc, t
      | Loop (var, e1, e2, e3, li) ->
	let acc, li = List.fold_left_map f acc li in
	acc, fix (Loop(var, e1, e2, e3, li))
      | If (e, cif, celse) ->
	let acc, cif = List.fold_left_map f acc cif in
	let acc, celse = List.fold_left_map f acc celse in
	acc, fix (If(e, cif, celse))
      | Return e -> acc, t
      | AllocArray (_, _, _) -> acc, t
      | Print _ -> acc, t
      | Read _ -> acc, t
      | Call _ -> acc, t
end)
