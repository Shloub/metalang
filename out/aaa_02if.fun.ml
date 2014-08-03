module IntSet = Map.Make (struct
  type t = int
  let compare : int -> int -> int = Pervasives.compare
end)

let main =
  ((fun c ->
       ((if c
         then (fun () -> ((fun a ->
                              Printf.printf "%s" a;
                              ((fun () -> ()) ())) "true <-\n ->\n"))
         else (fun () -> ((fun b ->
                              Printf.printf "%s" b;
                              ((fun () -> ()) ())) "false <-\n ->\n"))) ())) true);;

