open Stdlib
open Ast

type t =
    DeclarFun of varname * Type.t * ( varname * Type.t ) list * Instr.t list


let declarefun var t li1 li2 = DeclarFun (var, t, li1, li2)
