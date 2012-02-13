open Stdlib
open Ast
open Expr

module Instruction = struct
  type expr = Expr.t
  type 'a tofix =
      Declare of varname
    | Affect of varname * expr
    | Loop of varname * expr * expr * expr * 'a list
    | Comment of string
  type t = F of t tofix
  let unfix = function F x -> x
  let fix x = F x

  let map f acc t = match t with
    | Declare var -> t
    | Affect (var, e) -> t
    | Comment s -> t
    | Loop (var, e1, e2, e3, li) ->
	Loop (var, e1, e2, e3,
	      List.map ( fix @* f @* unfix ) li)
end
