module IntSet = Map.Make (struct
  type t = int
  let compare : int -> int -> int = Pervasives.compare
end)

let g =
  (fun return i ->
      ((fun j ->
           ((fun e ->
                ((if e
                  then (fun () -> (return 0))
                  else (fun () -> ((fun j ->
                                       (return j)) j))) ())) ((j mod 2) = 1))) (i * 4)));;
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
                           ((fun k ->
                                Printf.printf "%d" k;
                                (*  main  *) ((h (fun () -> ((fun a ->
                                                                 ((fun
                                                                  b ->
                                                                 ((fun
                                                                  f ->
                                                                 Printf.printf "%d" f;
                                                                 ()) (a + b))) 1)) 2))) 15)) (a + b))) 5)) 4))) 14);;

