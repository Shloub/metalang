module IntSet = Map.Make (struct
  type t = int
  let compare : int -> int -> int = Pervasives.compare
end)

let g =
  (fun return i ->
      ((fun j ->
           (((fun e f ->
                 ((if f
                   then (fun () -> (return 0))
                   else (fun () -> (e ()))) ())) (fun () -> (return j))) ((j mod 2) = 1))) (i * 4)));;
let h =
  (fun return i ->
      ((fun d ->
           Printf.printf "%d" d;
           ((fun c ->
                Printf.printf "%s" c;
                (return ())) "\n")) i));;
let main =
  ((h (fun () -> ((fun a ->
                      ((fun b ->
                           ((fun l ->
                                Printf.printf "%d" l;
                                (*  main  *) ((h (fun () -> ((fun a ->
                                                                 ((fun
                                                                  b ->
                                                                 ((fun
                                                                  k ->
                                                                 Printf.printf "%d" k;
                                                                 ()) (a + b))) 1)) 2))) 15)) (a + b))) 5)) 4))) 14);;

