module IntSet = Map.Make (struct
  type t = int
  let compare : int -> int -> int = Pervasives.compare
end)

let main =
  (((fun b e ->
        ((if e
          then (fun () -> ((fun c ->
                               Printf.printf "%s" c;
                               (b ())) "true <-\n ->\n"))
          else (fun () -> ((fun d ->
                               Printf.printf "%s" d;
                               (b ())) "false <-\n ->\n"))) ())) (fun () -> ((fun
   a ->
  Printf.printf "%s" a;
  ()) "small test end\n"))) true);;

