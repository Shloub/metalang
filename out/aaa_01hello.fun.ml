module IntSet = Map.Make (struct
  type t = int
  let compare : int -> int -> int = Pervasives.compare
end)

let main =
  ((fun a ->
       Printf.printf "%s" a;
       ()) "Hello World");;

