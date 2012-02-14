open Stdlib
open Ast

type 'a tofix =
    Add of 'a * 'a
  | Sub of 'a * 'a
  | Mul of 'a * 'a
  | Div of 'a * 'a
  | String of string
  | Float of float
  | Integer of int
  | Binding of varname
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
  | Integer i -> Integer i
  | Float f -> Float f
  | String s -> String s
  | Binding b -> Binding b
  | AccessArray (i, a) -> AccessArray (i, f a)

let add a b = fix (Add (a, b))
let sub a b = fix (Sub (a, b))
let mul a b = fix (Mul (a, b))
let div a b = fix (Div (a, b))
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
    | Integer _ -> acc, t
    | Float _ -> acc, t
    | String _ -> acc, t
    | Binding _ -> acc, t
    | AccessArray (arr, index) ->
	let acc, index = f acc index in
	(acc, F (annot, AccessArray(arr, index) ) )
end)

module Eval = struct
  type result =
    | RInteger of int
    | RFloat of float

  let print p = function
    | RInteger i -> Format.fprintf p "%i" i
    | RFloat f -> Format.fprintf p "%f" f

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
end
