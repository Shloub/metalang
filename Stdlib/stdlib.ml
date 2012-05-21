(*
* Copyright (c) 2012, Prologin
* All rights reserved.
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*
* THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

(** Standard library

@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
@author Arthur Wendling (art.wendling\@gmail.com)
*)

let id x = x
let ( $ ) f x = f x
let ( <| ) f x = f x
let ( |> ) x f = f x
let ( @* ) f g x = f (g x)
let ( @** ) f g x y = f (g x y)

let curry f a b = f (a, b)
let uncurry f (a, b) = f a b
let map_fst f (a, b) = f a, b
let map_snd f (a, b) = a, f b

let const x _ = x
let flip f x y = f y x

let cons x xs = x::xs
let snoc xs x = x::xs

let int = int_of_float
let float = float_of_int

(** {2 Standard modules } *)

module Int = struct
	type t = int
	let compare = Pervasives.compare
	let sqrt = int @* sqrt @* float
	let abs t = if t > 0 then t else -t

	let exp =
		let rec go r a b =
			if b = 0
			then r
			else if b mod 2 = 0
			then go r (a * a) (b / 2)
			else go (a * r) a (b - 1)
		in go 1
end

module Option = struct

  let extract = function
    | None -> invalid_arg "Option.get"
    | Some value -> value

  let map_default default f = function
    | None -> default
    | Some value -> f value

  let is_none x = map_default true (const false) x
  let is_some x = not (is_none x)
  let default d = map_default d id
	let return x = Some x
  let bind f = map_default None f
  let map f = bind (return @* f)

	let catch f x = try Some (f x) with _ -> None
	let snoc xs = map_default xs (snoc xs)
end

module Either = struct
  type ('a, 'b) t =
    | A of 'a
    | B of 'b
end

module List = struct
  include List

  let zip = combine
  let zip_with = List.map2
  let unzip = split
  let forall = for_all

  let init f n =
    let rec aux li = function
      | 0 -> f 0 :: li
      | n -> aux (f n :: li) (n - 1)
    in aux [] (n - 1)

  let rec seq a b = init (( + ) a) (b - a + 1)
  let ( -- ) = seq

  let rec insert n item li =
    if n = 0
		then item :: li
    else match li with
      | hd::tl -> hd :: insert (n - 1) item tl
      | [] -> invalid_arg "List.insert"

  let rec last = function
    | [] -> invalid_arg "List.last"
    | [x] -> x
    | _ :: xs -> last xs

  let rec split_at n =
		let rec go n xs ys = match n, ys with
			| 0, _ | _, [] -> List.rev xs, ys
			| _, y::ys -> go (n - 1) (y::ys) ys
		in go n []
	let take n xs = fst (split_at n xs)

  let rec take_while f = function
    | [] -> []
    | t :: _ when not $ f t -> []
    | t :: q -> t :: take_while f q

  let shuffle li =
		let array_shuffle t =
			let len = Array.length t in
			for i = 0 to len - 1 do
				let j = Random.int len in
				let tmp = t.(j) in
				t.(j) <- t.(i) ;
				t.(i) <- tmp
			done in
		let t = Array.of_list li in
		array_shuffle t ;
		Array.to_list t

  let iteri f = ignore @* List.fold_left (fun i x -> f i x ; i + 1) 0

  let filter_map f li =
    List.fold_right (fun x xs -> Option.snoc xs (f x)) li []

  let fold_left_filter_map f a li =
    let acc, li =
			fold_left (fun (a, xs) -> map_snd (Option.snoc xs) @* f a) (a, []) li
    in acc, List.rev li

  let fold_left_map f = fold_left_filter_map (map_snd Option.return @** f)

  let find_opt l = Option.catch (find l)

  let rec join sep = function
    | [] | [_] as li -> li
    | hd :: tl -> hd :: sep :: join sep tl

end

module String = struct
  include String

  let lines = Str.split $ Str.regexp "\n+"
  let unlines = String.concat "\n"
  let words = Str.split $ Str.regexp "[ \t]+"
  let unwords = String.concat " "

  let match_from s s' from =
		try for i = 0 to length s - 1 do
					if s.[i] <> s'.[i + from] then raise Not_found
				done ;
		    true
		with Not_found -> false

  let index s s' from =
		let max = length s' - length s in
    let rec go n =
			if n > max
			then raise Not_found
			else if match_from s s' n
			then n
			else go (n + 1)
    in go from

  let is_sub s s' = try ignore (index s s' 0) ; true with Not_found -> false

  let is_prefix s s' = match_from s s' 0

  let is_capitalised s = let c = s.[0] in c >= 'A' && c <= 'Z'

	let fold_left f x s =
		let len = String.length s in
		let rec go i x =
			if i >= len
			then x
			else go (i + 1) (f x s.[i])
		in go 0 x
	let list_of_map f = fold_left (flip (cons @* f)) []

  let of_list li =
    let len = List.length li in
    let s = String.create len in
		List.iteri (String.set s) li ;
    s

  let list_of_fold_map f s a =
		fold_left (fun (a, xs) -> map_snd (snoc xs) @* f a) (a, []) s

  let unescape s =
		let escape = function
			| 'n' -> '\n'
			| 't' -> '\t'
			| '"' -> '"'
			| '\\' -> '\\'
			| _ -> invalid_arg "String.unescape" in
		let buf = Buffer.create (String.length s) in
		let add c = Buffer.add_char buf c ; false in
		ignore $ fold_left (fun escaped c ->
			if not escaped
			then c = '\\' || add c
			else add (escape c)) false s ;
		Buffer.contents buf

	let replace = Str.global_replace @* Str.regexp @* Str.quote
end

(** {2 Collections} *)

module MakeSet (K : Set.OrderedType)= struct
  include Set.Make (K)
  let of_list = List.fold_left (flip add) empty
end

module MakeMap (K : Map.OrderedType) = struct
  include Map.Make (K)

  let merge a b = (fun k v acc -> add k v acc) a b
  let to_list map = fold (curry cons) map []
  let from_list xs = List.fold_left (flip (uncurry add)) empty xs
  let find_opt key = Option.catch (find key)
end


module IntSet = MakeSet (Int)
module IntSetIntSet = MakeSet (IntSet)
