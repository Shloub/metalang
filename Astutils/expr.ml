open Stdlib
open Ast

type unop = Neg | Not | BNot

type binop =
  | Add | Sub | Mul | Div | Mod | Or | And
  | Lower | LowerEq | Higher | HigherEq
  | Eq | Diff
  | BinOr | BinAnd | RShift | LShift

type 'a tofix =
(*operations numeriques*)
    BinOp of 'a * binop * 'a
  | UnOp of 'a * unop
(* liefs *)
  | String of string
  | Float of float
  | Integer of int
  | Binding of varname
  | Bool of bool
  | AccessArray of varname * 'a
  | Length of varname
  | Call of funname * 'a list

type t = F of int * t tofix
let annot = function F (i, _) -> i
let unfix = function F (_, x) -> x
let fix x = F ((next ()), x)

let map f = function
  | BinOp (a, op, b) -> BinOp ((f a), op, f b)
  | UnOp (a, op) -> UnOp((f a), op)
  | Integer i -> Integer i
  | Float f -> Float f
  | String s -> String s
  | Binding b -> Binding b
  | Bool b -> Bool b
  | AccessArray (i, a) -> AccessArray (i, f a)
  | Call (n, li) -> Call (n, List.map f li)

let bool b = fix (Bool b)

let unop op a = fix (UnOp (a, op))
let binop op a b = fix (BinOp (a, op, b))

let integer i = fix (Integer i)
let float f = fix (Float f)
let string f = fix (String f)
let binding b = fix (Binding b)
let access_array i a = fix (AccessArray (i, a) )
let call name li = fix ( Call(name, li))
let length name = fix ( Length name)

module Writer = AstWriter.F (struct
  type alias = t;;
  type t = alias;;
  let foldmap f acc t =
    let annot = annot t in
    match unfix t with
    | UnOp (a, op) ->
	let acc, a = f acc a in
	(acc, F(annot, UnOp(a, op)))
    | BinOp (a, op, b) ->
	let acc, a = f acc a in
	let acc, b = f acc b in
	(acc, F (annot, BinOp (a, op, b) ) )
    | Integer _ -> acc, t
    | Float _ -> acc, t
    | String _ -> acc, t
    | Binding _ -> acc, t
    | Bool _ -> acc, t
    | AccessArray (arr, index) ->
	let acc, index = f acc index in
	(acc, F (annot, AccessArray(arr, index) ) )
    | Call (name, li) ->
	let acc, li = List.fold_left_map f acc li in
	(acc, F (annot, Call(name, li)) )
end)

module Eval = struct
  type result =
    | RInteger of int
    | RFloat of float
    | RBool of bool

  let print p = function
    | RInteger i -> Format.fprintf p "%i" i
    | RFloat f -> Format.fprintf p "%f" f
    | RBool false -> Format.fprintf p "False"
    | RBool true -> Format.fprintf p "True"

  let add a b =
    match (a, b) with
    | RFloat i, RFloat j -> RFloat (i +. j)
    | RInteger i, RInteger j -> RInteger (i + j)
    | RInteger i, RFloat j -> RFloat ((float_of_int i) +. j)
    | RFloat i, RInteger j -> RFloat (i +. (float_of_int j))
    | RBool _, _ -> assert false
    | _, RBool _ -> assert false

  let sub a b =
    match (a, b) with
    | RFloat i, RFloat j -> RFloat (i -. j)
    | RInteger i, RInteger j -> RInteger (i - j)
    | RInteger i, RFloat j -> RFloat ((float_of_int i) -. j)
    | RFloat i, RInteger j -> RFloat (i -. (float_of_int j))
    | RBool _, _ -> assert false
    | _, RBool _ -> assert false

  let modulo a b =
    match (a, b) with
    | RInteger i, RInteger j -> RInteger (i mod j)
    | _ -> assert false

  let mul a b =
    match (a, b) with
    | RFloat i, RFloat j -> RFloat (i *. j)
    | RInteger i, RInteger j -> RInteger (i * j)
    | RInteger i, RFloat j -> RFloat ((float_of_int i) *. j)
    | RFloat i, RInteger j -> RFloat (i *. (float_of_int j))
    | RBool _, _ -> assert false
    | _, RBool _ -> assert false

  let div a b =
    match (a, b) with
    | RFloat i, RFloat j -> RFloat (i /. j)
    | RInteger i, RInteger j -> RInteger (i / j)
    | RInteger i, RFloat j -> RFloat ((float_of_int i) /. j)
    | RFloat i, RInteger j -> RFloat (i /. (float_of_int j))
    | _ -> assert false

  let calc_lower_eq a b = match (a, b) with
    | RFloat i, RFloat j -> RBool (i <= j)
    | RInteger i, RInteger j -> RBool (i <= j)
    | RInteger i, RFloat j -> RBool ((float_of_int i) <= j)
    | RFloat i, RInteger j -> RBool (i <= (float_of_int j))
    | _ -> assert false

  let calc_lower a b = match (a, b) with
    | RFloat i, RFloat j -> RBool (i < j)
    | RInteger i, RInteger j -> RBool (i < j)
    | RInteger i, RFloat j -> RBool ((float_of_int i) < j)
    | RFloat i, RInteger j -> RBool (i < (float_of_int j))
    | _ -> assert false

  let calc_higher_eq a b = match (a, b) with
    | RFloat i, RFloat j -> RBool (i >= j)
    | RInteger i, RInteger j -> RBool (i >= j)
    | RInteger i, RFloat j -> RBool ((float_of_int i) >= j)
    | RFloat i, RInteger j -> RBool (i >= (float_of_int j))
    | _ -> assert false

  let calc_higher a b = match (a, b) with
    | RFloat i, RFloat j -> RBool (i > j)
    | RInteger i, RInteger j -> RBool (i > j)
    | RInteger i, RFloat j -> RBool ((float_of_int i) > j)
    | RFloat i, RInteger j -> RBool (i > (float_of_int j))
    | _ -> assert false

let calc_eq a b = match (a, b) with
    | RFloat i, RFloat j -> RBool (i = j)
    | RInteger i, RInteger j -> RBool (i = j)
    | RInteger i, RFloat j -> RBool ((float_of_int i) = j)
    | RFloat i, RInteger j -> RBool (i = (float_of_int j))
    | _ -> assert false

let calc_diff a b = match (a, b) with
    | RFloat i, RFloat j -> RBool (i <> j)
    | RInteger i, RInteger j -> RBool (i <> j)
    | RInteger i, RFloat j -> RBool ((float_of_int i) <> j)
    | RFloat i, RInteger j -> RBool (i <> (float_of_int j))
    | _ -> assert false

let calc_binor a b = match (a, b) with
    | RInteger i, RInteger j -> RInteger (i lor j)
    | _ -> assert false

let calc_binand a b = match (a, b) with
    | RInteger i, RInteger j -> RInteger (i land j)
    | _ -> assert false

let calc_rshift a b = match (a, b) with
    | RInteger i, RInteger j -> RInteger (i lsr j)
    | _ -> assert false

let calc_lshift a b = match (a, b) with
    | RInteger i, RInteger j -> RInteger (i lsl j)
    | _ -> assert false


let calc_or a b = match (a, b) with
    | RBool i, RBool j -> RBool (i or j)
    | _ -> assert false

let calc_and a b = match (a, b) with
    | RBool i, RBool j -> RBool (i && j)
    | _ -> assert false

  let rec eval t = match map eval (unfix t) with
  | UnOp (RInteger i, Neg) -> RInteger (-i)
  | UnOp (RBool i, Not) -> RBool (not i)
  | UnOp (RInteger i, BNot) -> RInteger (lnot i)
  | UnOp (RFloat i, Neg) -> RFloat (-.i)
  | UnOp (_, _) -> assert false

      | BinOp (a, Add, b) -> add a b
      | BinOp (a, Sub, b) -> sub a b
      | BinOp (a, Mul, b) -> mul a b
      | BinOp (a, Div, b) -> div a b
      | BinOp (a, Mod, b) -> modulo a b

      | BinOp (a, And, b) -> calc_and a b
      | BinOp (a, Or, b) -> calc_or a b

      | BinOp (a, Lower, b) -> calc_lower a b
      | BinOp (a, LowerEq, b) -> calc_lower_eq a b
      | BinOp (a, Higher, b) -> calc_higher a b
      | BinOp (a, HigherEq, b) -> calc_higher_eq a b
      | BinOp (a, Eq, b) -> calc_eq a b
      | BinOp (a, Diff, b) -> calc_diff a b

      | BinOp (a, BinOr, b) -> calc_binor a b
      | BinOp (a, BinAnd, b) -> calc_binand a b
      | BinOp (a, RShift, b) -> calc_rshift a b
      | BinOp (a, LShift, b) -> calc_lshift a b

      | Integer i -> RInteger i
      | Float f -> RFloat f
      | AccessArray (arr, index) -> assert false (* TODO *)
      | Binding b -> RInteger 0
(*
	  assert false (*TODO*) *)
      | String f -> assert false
      | Bool b -> assert false (* TODO *)
end
