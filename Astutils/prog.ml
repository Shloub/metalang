open Stdlib
open Ast

type t_fun =
    DeclarFun of varname * Type.t * ( varname * Type.t ) list * Instr.t list
  | DeclareType of typename * Type.t

let declarefun var t li1 li2 = DeclarFun (var, t, li1, li2)

let prog functions main = (functions, main)
