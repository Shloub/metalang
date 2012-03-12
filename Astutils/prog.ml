open Stdlib
open Ast

type t_fun =
    DeclarFun of varname * Type.t * ( varname * Type.t ) list * Instr.t list
  | DeclareType of typename * Type.t
  | Comment of string


let comment s = Comment s
let declarefun var t li1 li2 = DeclarFun (var, t, li1, li2)

type t =
    string * t_fun list * Instr.t list
