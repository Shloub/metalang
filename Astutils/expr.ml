open Stdlib
open Ast

type 'a tofix =
(*operations numeriques*)
    Add of 'a * 'a
  | Sub of 'a * 'a
  | Mul of 'a * 'a
  | Div of 'a * 'a
  | Mod of 'a * 'a
(*operations boolean*)
  | Or of 'a * 'a
  | And of 'a * 'a
  | Not of 'a
(* cmp functions *)
  | Lower of 'a * 'a
  | LowerEq of 'a * 'a
  | Higher of 'a * 'a
  | HigherEq of 'a * 'a
  | Eq of 'a * 'a
  | Neq of 'a * 'a

(*operations binaires*)
  | BinOr of 'a * 'a
  | BinAnd of 'a * 'a
  | BinNot of 'a
  | RShift of 'a * 'a
  | LShift of 'a * 'a
(* liefs *)
  | String of string
  | Float of float
  | Integer of int
  | Binding of varname
  | Bool of bool
  | AccessArray of varname * 'a

type t = F of int * t tofix
let annot = function F (i, _) -> i
let unfix = function F (_, x) -> x
let fix x = F ((next ()), x)

let map f = function
  | Sub (a, b) -> Sub ((f a), f b)
  | Add (a, b) -> Add ((f a), f b)
  | Mul (a, b) -> Mul ((f a), f b)
  | Div (a, b) -> Div ((f a), f b)
  | Mod (a, b) -> Mod ((f a), f b)

  | Or (a, b) -> Or ((f a), f b)
  | And (a, b) -> And ((f a), f b)
  | Not (a) -> Not (f a)

  | BinOr (a, b) -> BinOr ((f a), f b)
  | BinAnd (a, b) -> BinAnd ((f a), f b)
  | BinNot (a) -> BinNot (f a)
  | LShift (a, b) -> LShift ((f a), f b)
  | RShift (a, b) -> RShift ((f a), f b)

  | Integer i -> Integer i
  | Float f -> Float f
  | String s -> String s
  | Binding b -> Binding b
  | Bool b -> Bool b
  | AccessArray (i, a) -> AccessArray (i, f a)


let bool b = fix (Bool b)

let add a b = fix (Add (a, b))
let sub a b = fix (Sub (a, b))
let mul a b = fix (Mul (a, b))
let div a b = fix (Div (a, b))
let modulo a b = fix (Mod (a, b))

let boolor a b = fix (Or (a, b))
let booland a b = fix (And (a, b))
let boolnot a = fix (Not a)

let binand a b = fix (BinAnd (a, b))
let binor a b = fix (BinOr (a, b))
let binnot a = fix (BinNot (a))
let rshift a b = fix (RShift (a, b))
let lshift a b = fix (LShift (a, b))

let integer i = fix (Integer i)
let float f = fix (Float f)
let string f = fix (String f)
let binding b = fix (Binding b)
let access_array i a = fix (AccessArray (i, a) )

module Writer = AstWriter.F (struct
  type alias = t;;
  type t = alias;;
  let foldmap f acc t =
    let annot = annot t in
    match unfix t with
    | Add (a, b) ->
	let acc, a = f acc a in
	let acc, b = f acc b in
	(acc, F (annot, Add (a, b) ) )
    | Sub (a, b) ->
	let acc, a = f acc a in
	let acc, b = f acc b in
	(acc, F (annot, Sub (a, b) ) )
    | Mul (a, b) ->
	let acc, a = f acc a in
	let acc, b = f acc b in
	(acc, F (annot, Mul (a, b) ) )
    | Div (a, b) ->
	let acc, a = f acc a in
	let acc, b = f acc b in
	(acc, F (annot, Div (a, b) ) )
    | Mod (a, b) ->
	let acc, a = f acc a in
	let acc, b = f acc b in
	(acc, F (annot, Mod (a, b) ) )
    | Or (a, b) ->
	let acc, a = f acc a in
	let acc, b = f acc b in
	(acc, F (annot, Or (a, b) ) )
    | And (a, b) ->
	let acc, a = f acc a in
	let acc, b = f acc b in
	(acc, F (annot, And (a, b) ) )
    | Not a ->
	let acc, a = f acc a in
	(acc, F (annot, Not a ) )
    | BinOr (a, b) ->
	let acc, a = f acc a in
	let acc, b = f acc b in
	(acc, F (annot, BinOr (a, b) ) )
    | BinAnd (a, b) ->
	let acc, a = f acc a in
	let acc, b = f acc b in
	(acc, F (annot, BinAnd (a, b) ) )
    | BinNot a ->
	let acc, a = f acc a in
	(acc, F (annot, BinNot a ) )
    | LShift (a, b) ->
	let acc, a = f acc a in
	let acc, b = f acc b in
	(acc, F (annot, LShift (a, b) ) )
    | RShift (a, b) ->
	let acc, a = f acc a in
	let acc, b = f acc b in
	(acc, F (annot, RShift (a, b) ) )
    | Integer _ -> acc, t
    | Float _ -> acc, t
    | String _ -> acc, t
    | Binding _ -> acc, t
    | Bool _ -> acc, t
    | AccessArray (arr, index) ->
	let acc, index = f acc index in
	(acc, F (annot, AccessArray(arr, index) ) )
end)

module Eval = struct
  type result =
    | RInteger of int
    | RFloat of float
    | RBool of bool

  let print p = function
    | RInteger i -> Format.fprintf p "%i" i
    | RFloat f -> Format.fprintf p "%f" f
    | RBool false -> Format.fprintf p "false"
    | RBool true -> Format.fprintf p "true"

  let add a b =
    match (a, b) with
    | RFloat i, RFloat j -> RFloat (i +. j)
    | RInteger i, RInteger j -> RInteger (i + j)
    | RInteger i, RFloat j -> RFloat ((float_of_int i) +. j)
    | RFloat i, RInteger j -> RFloat (i +. (float_of_int j))

  let sub a b =
    match (a, b) with
    | RFloat i, RFloat j -> RFloat (i -. j)
    | RInteger i, RInteger j -> RInteger (i - j)
    | RInteger i, RFloat j -> RFloat ((float_of_int i) -. j)
    | RFloat i, RInteger j -> RFloat (i -. (float_of_int j))

  let mul a b =
    match (a, b) with
    | RFloat i, RFloat j -> RFloat (i *. j)
    | RInteger i, RInteger j -> RInteger (i * j)
    | RInteger i, RFloat j -> RFloat ((float_of_int i) *. j)
    | RFloat i, RInteger j -> RFloat (i *. (float_of_int j))

  let div a b =
    match (a, b) with
    | RFloat i, RFloat j -> RFloat (i /. j)
    | RInteger i, RInteger j -> RInteger (i / j)
    | RInteger i, RFloat j -> RFloat ((float_of_int i) /. j)
    | RFloat i, RInteger j -> RFloat (i /. (float_of_int j))

  let rec eval t = match map eval (unfix t) with
      | Add (a, b) -> add a b
      | Sub (a, b) -> sub a b
      | Mul (a, b) -> mul a b
      | Div (a, b) -> div a b
      | Integer i -> RInteger i
      | Float f -> RFloat f
      | AccessArray (arr, index) -> assert false (* TODO *)
      | Binding b ->
	  assert false (*TODO*)
      | String f -> assert false
      | Bool b -> assert false (* TODO *)
end
