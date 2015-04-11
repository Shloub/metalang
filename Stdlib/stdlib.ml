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


(** {2 Standard Operators } *)
let ( $ ) f x = f x
let ( <| ) f x = f x
let ( |> ) x f = f x
let ( @* ) f g x = f (g x)
let ( @$ ) f x = f x
let ( @** ) f g x y = f (g x y)

(** {2 Utils functions } *)
let id x = x
let curry f a b = f (a, b)
let uncurry f (a, b) = f a b

let map_fst f (a, b) = f a, b
let map_snd f (a, b) = a, f b

let const x _ = x
let flip f x y = f y x

let cons x xs = x::xs
let snoc xs x = x::xs

(** {2 type conversion functions } *)
let int = int_of_float
let float = float_of_int
let int_of_bool b = if b then 1 else 0
let float_of_char = float_of_int @* int_of_char
let float_of_bool = float_of_int @* int_of_bool

(** {2 Standard modules } *)

module Int = struct
  type t = int
  let compare : int -> int -> int = Pervasives.compare
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

(**
   Option module
*)
module Option = struct

  let iter f = function
    | None -> ()
    | Some a -> f a

  (**
     Renvoie une exception quand on lui passe None en argument
     Renvoie la valeur x contenue dans Some x
  *)
  let extract = function
    | None -> invalid_arg "Option.get"
    | Some value -> value

  (**
     Si None, renvoie default
     Si Some x, renvoie f x
  *)
  let map_default default f = function
    | None -> default
    | Some value -> f value

  (** renvoie true si la valeur passée en argument est none *)
  let is_none x = map_default true (const false) x
  (** renvoie true si la valeur passée en argument est Some _ *)
  let is_some x = not (is_none x)
  (** renvoie d si None, x si Some x *)
  let default d = map_default d id
  (** crée Some x a partir de x *)
  let return x = Some x
  (** renvoie None si le second argument est None, renvoie f x si le
      second argument est Some x *)
  let bind f = map_default None f
  (** renvoie None si le second argument est None, renvoie Some (f
      x) si le second argument est Some x*)
  let map f = bind (return @* f)

  let catch f x = try Some (f x) with _ -> None
  let snoc xs = map_default xs (snoc xs)
end

(**
   Either module
*)
module Either = struct
  type ('a, 'b) t =
  | A of 'a
  | B of 'b
end

(**
   List module
*)
module List = struct
  include List

  let pack n li =
    let rec f acc1 acc2 i = function
      | [] -> List.rev (List.rev acc1 :: acc2)
      | hd::tl -> if i = 1 then
          f [hd] (List.rev acc1::acc2) n tl
      else f (hd::acc1) acc2 (i - 1) tl
    in f [] [] (n +1) li

  (* TODO faire plus efficace*)
  let collect f li = map f li |> flatten

  let indexof item li =
    fold_left
      (fun (found, index) i ->
        if i = item then index, index + 1
        else (found, index + 1)
      ) (-1, 0) li |> fst

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

  let split_last xs =
    let rec go ys = function
      | [] -> invalid_arg "List.split_last"
      | [x] -> x, List.rev ys
      | y :: xs -> go (y::ys) xs
    in go [] xs

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

  let mapi f li = snd (fold_left_map (fun i x -> i + 1, f i x) 0 li)

  let find_opt l = Option.catch (find l)

  let rec join sep = function
    | [] | [_] as li -> li
    | hd :: tl -> hd :: sep :: join sep tl

end

(**
   String module
*)

module String = struct
  include String

  let join li = List.fold_left (^) "" li

  let rec split s c =
    try
      let index = String.index s c in
      (String.sub s 0 index) :: (split (String.sub s (index +1) ((String.length s) - index - 1)) c)
    with Not_found -> [s]

  let from_char c = make 1 c
  let of_string (s:string) = (s:t)
  let equals a b = 0 = compare a b
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

  let ends_with s s' =
    let l = String.length s in
    let l' = String.length s' in
    if l' > l then false else
    let s = String.sub s (l - l') l' in
    s = s'

  let starts_with s s' =
    let l = String.length s in
    let l' = String.length s' in
    if l' > l then false else
    let s = String.sub s 0 l' in
    s = s'

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

  let for_all f s = fold_left (fun acc c -> acc && f c) true s
  let exists f s = fold_left (fun acc c -> acc || f c) false s

  let of_list li =
    let len = List.length li in
    let s = String.create len in
    List.iteri (String.set s) li ;
    s

  let of_char c =
    let s = String.create 1 in
    String.set s 0 c; s

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

  let replace a b c =
    let b = Str.global_replace (Str.regexp_string "\\") "\\\\\\\\" b in
    (*    Format.printf "replace %S %S %S\n%!" a b c; *)
    Str.global_replace (Str.regexp_string a) b c

  let chararray s =
    let len = length s in
    Array.init len (String.get s)

end

(** {2 Collections} *)

module MakeSet (K : Set.OrderedType)= struct
  include Set.Make (K)
  let of_list = List.fold_left (flip add) empty
end

module MakeMap (K : Map.OrderedType) = struct
  include Map.Make (K)
  let to_list map = fold (curry cons) map []
  let from_list xs = List.fold_left (flip (uncurry add)) empty xs
  let find_opt key = Option.catch (find key)
end

(** {3 Collections prédéfinies} *)
module IntSet = MakeSet (Int)
module IntMap = MakeMap (Int)
module StringMap = MakeMap (String)
module StringSet = MakeSet (String)

(** {2 Fix module} *)
(** les modules dérécursivés *)
module type Fixable = sig
  type ('a, 'b) tofix
  val map : ('a -> 'b) -> ('a, 'c) tofix -> ('b, 'c) tofix

  val next : unit -> int
end

module Fix (F : Fixable) = struct
  type 'a t = F of int * ('a t, 'a) F.tofix
  let annot = function F (i, _) -> i
  let unfix = function F (_, x) -> x
  let fix x = F (F.next (), x)
  let fixa a x = F (a, x)
  let map = F.map
  let rec dmap f (F(i, x)) = F (i, F.map (fun x -> f (dmap f x)) x)
  let rec dfold f (F(i, x))  = f (F.map (dfold f) x)
end

module type Fixable2 = sig
  type ('a, 'b) tofix
  val foldmap : ('a -> 'b -> 'a * 'd) -> ('b, 'c) tofix -> 'a -> 'a * ('d, 'c) tofix
  val next : unit -> int
end

module Fix2 (F : Fixable2) = struct
  type 'a t = F of int * ('a t, 'a) F.tofix
  let annot = function F (i, _) -> i
  let unfix = function F (_, x) -> x
  let fix x = F (F.next (), x)
  let fixa a x = F (a, x)

  module Surface = struct
    let foldmap = F.foldmap
    let foldmapt f (F (i, x)) acc = let acc, x = foldmap f x acc in acc, F (i, x)
    let map f x = snd (foldmap (fun () x -> (), f x) x ())
    let mapt f (F(i, x)) = F (i, map f x)
    let fold f acc t = fst ( foldmap (fun acc t -> f acc t, t) t acc)
  end

  module Deep = struct
    let rec map f (F(i, x)) = F (i, Surface.map (fun x -> f (map f x)) x)
    let map f x = f (map f x)
    let rec fold f (F(i, x))  = f (Surface.map (fold f) x)
  end

end
