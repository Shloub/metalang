open Stdlib
open Ast
type 'a tofix =
  | Integer
  | Float
  | String
  | Char
  | Array of 'a
  | Void
  | Bool

type t = F of t tofix
let unfix = function F x -> x
let fix x = F x

let bool = Bool |> fix
let integer = Integer |> fix
let void = Void |> fix
let float = Float |> fix
let string = String |> fix
let char = Char |> fix
let array t = Array t |> fix
