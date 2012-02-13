module Either = struct
  type ('a, 'b) t =
    | A of 'a
    | B of 'b

end

let ($) f x = f x
let (<|) f x = f x
let (|>) x f = f x
let (@*) f g x = f ( g x )

let curry f a b = f (a, b)
let uncurry f (a, b) = f a b

let const x _ = x
let flip f x y = f y x

module Option = struct
  let is_none = function None -> true | _ -> false
  let is_some = function None -> false | _ -> true

  let get = function
    | None -> invalid_arg "Option.get"
    | Some value -> value

  let default d = function
    | None -> d
    | Some s -> s

  let map f = function
    | None -> None
    | Some s -> Some (f s)

  let map_default default f = function
    | None -> default
    | Some value -> f value

  let bind f = function
    | None -> None
    | Some s -> f s
end

module MakeSet ( K : Set.OrderedType)= struct
  include Set.Make(K)
  let from_list li =
    List.fold_left (fun acc k -> add k acc) empty li
end

module MakeMap ( K : Map.OrderedType) = struct
  include Map.Make(K)

  let merge a b = (fun k v acc -> add k v acc) a b

  let to_list map =
    fold (fun k v acc -> (k, v) :: acc) map []

  let from_list li =
    List.fold_left (fun acc (k, v) -> add k v acc) empty li

  let find_opt key map =
    try Some (find key map)
    with Not_found -> None
end

module List = struct
  include List

  let zip = combine
  let unzip = split

  let forall f li =
    not ( exists (not @* f) li)

  let split n li =
    if n < 0 then failwith "List.split" else
    let rec aux n acc li =
      if n = 0 then ((rev acc), li) else
        match li with
        | [] -> failwith "List.take"
        | hd::tl -> aux (n-1) (hd::acc) tl
    in aux n [] li
  let take n li = fst (split n li)
  let init f n =
    let rec aux li = function
      | 0 -> (f 0)::li
      | n -> aux ( (f n) :: li) (n - 1)
    in aux [] (n-1)

  let rec seq a b =
    if a <= b then a :: (seq (a + 1) b)
    else []

  let ( -- ) = seq

  let rec insert n item li =
    if n = 0 then item :: li
    else match li with
      | hd::tl ->
          hd :: (insert (n - 1) item tl)
      | [] -> failwith "insert"

  let random_insert n item li =
    if n = 0 then n :: li
    else insert (Random.int n) item li

  let rec last = function
    | [] -> invalid_arg "List.last"
    | [x] -> x
    | _ :: xs -> last xs

  let rec take n l = match (n, l) with
    | 0, li -> [], li
    | _, t :: q ->
        let li, li' = take (n-1) q in
          t :: li, li'
    | _, [] -> [], []

  let rec take_while f = function
    | [] -> []
    | t :: _ when not $ f t -> []
    | t :: q -> t :: take_while f q

  let shuffle li =
    let rec f n li = function
      | [] -> li
      | hd::tl ->
          let li = random_insert n hd li
          in f (n + 1) li tl
    in f 0 [] li

  let iteri f li =
    let rec aux i = function
      | [] -> ()
      | hd::tl -> let () = f i hd in aux (i+1) tl
    in aux 0 li

  let filter_map f l =
    List.fold_right (fun x acc ->
      match f x with
      | Some k -> k :: acc
      | None -> acc) l []

  let fold_left_map (f : ('acc -> 'item -> 'acc * 'item2)) (acc:'acc) (li:'item list) : ('acc * 'item2 list) =
    let (acc, li) = fold_left
      (fun (acc0, li) item ->
         let acc0, nitem = f acc0 item in
           (acc0, nitem :: li)
      )
      (acc, [])
      li
    in acc, (rev li)

  let fold_left_filter_map f acc li =
    let (acc, li) = fold_left
      (fun (acc0, li) item ->
         let acc0, nitem = f acc0 item in
           (acc0, match nitem with
	      | Some nitem -> nitem :: li
	      | None -> li
	   )
      )
      (acc, [])
      li
    in acc, (rev li)

  let find_opt l x =
    try Some (find l x)
    with Not_found -> None

  let join sep = function
    | [] -> []
    | hd :: tl -> hd :: List.concat ( List.map (fun x -> [sep ; x]) tl)

  let rec zip_with f l1 l2 = match l1, l2 with
    | [], [] -> []
    | _, [] | [], _ -> invalid_arg "List.zip_with"
    | x::xs, y::ys -> f x y :: zip_with f xs ys
end

module String = struct
  include String

  let lines = Str.split $ Str.regexp "\n+"
  let unlines = String.concat "\n"
  let words = Str.split $ Str.regexp "[ \t]+"
  let unwords = String.concat " "

  let is_substring sub str start_pos =
    if start_pos < 0 then invalid_arg "String.is_substring"
    else
      let len, len' = length sub, length str in
      let rec aux p =
        p = len or (
          let p' = start_pos + p in
          p' < len' && sub.[p] = str.[p'] && aux (succ p)
        )
      in aux 0

  let is_sub s s' =
    let rec aux n =
      if n > (length s' - length s) then false
      else (is_substring s s' n || aux $ succ n)
    in aux 0

  let is_prefix s s' = is_substring s s' 0

  let is_capitalised s = s.[0] >= 'A' && s.[0] <= 'Z'

  let map (f: char -> 'a) (s:string) : 'a list =
    let out = ref [] in
    let () = String.iter
      (fun c ->
         out := (f c) :: !out;
      ) s
    in List.rev !out

  let from_list li =
    let len = List.length li in
    let s = String.create len in
    begin
      List.iteri (fun i c -> String.set s i c) li;
      s
    end

  let fold_map (f: 'acc -> char -> 'acc * 'a) (s:string) (acc:'acc) : ('acc * 'a list) =
    let acc = ref acc in
    let li = map
      (fun c ->
         let acc', out = f !acc c in
         let () = acc := acc' in
         out
      ) s
    in !acc, li

  let unescape s =
    fold_map
      (fun opt c ->
         match opt, c with
         | false, '\\' -> true, []
         | false, _ -> false, [c]
         | true, 'n' -> false, ['\n']
         | true, 't' -> false, ['\t']
         | true, '\\' -> false, ['\\']
         | true, '"' -> false, ['"']
         | _ -> assert false
      )
      s
      false |> snd |> List.flatten |> from_list

  let rec concat sep li =
    match li with
    | [] -> ""
    | [a] -> a
    | [a;b] -> a^sep^b
    | li ->
        let len = List.length li in
        let (a, b) = List.split (len / 2) li in
        (concat sep a)^sep^(concat sep b)
end

module IntSet = MakeSet
  (struct
     type t = int
     let compare:(t -> t -> int) = compare
   end)

module IntSetIntSet = MakeSet(IntSet)


let sqrt_i i =
float_of_int i |> int_of_float @* sqrt

let abs_i t = if t > 0 then t else -t

let rec exp_i a b =
  if b = 0 then 1
  else
    if b mod 2 = 1 then
      let c = exp_i a (b - 1) in c * a
    else
      let c = exp_i a (b  / 2) in c * c

