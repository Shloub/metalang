module IntSet = Map.Make (struct
  type t = int
  let compare : int -> int -> int = Pervasives.compare
end)

let main =
  ((fun j ->
       (((fun n o ->
             let rec p k q =
               (if (k <= o)
                then (p (k + 1) (((fun k ->
                                      (fun (j) ->
                                          ((fun j ->
                                               ((fun l ->
                                                    Printf.printf "%d" l;
                                                    ((fun h ->
                                                         Printf.printf "%s" h;
                                                         ((fun () -> (j)) ())) "\n")) j)) (j + k)))) k) q))
                else ((fun (j) ->
                          ((fun i ->
                               let rec f g =
                                 ((fun (i, j) ->
                                      ((fun e ->
                                           (if e
                                            then (f ((fun (i, j) ->
                                                         ((fun d ->
                                                              Printf.printf "%d" d;
                                                              ((fun i ->
                                                                   ((fun
                                                                    j ->
                                                                   ((fun () -> (i, j)) ())) (j + i))) (i + 1))) i)) (i, j)))
                                            else ((fun (i, j) ->
                                                      ((fun c ->
                                                           Printf.printf "%d" c;
                                                           ((fun b ->
                                                                Printf.printf "%d" b;
                                                                ((fun
                                                                 a ->
                                                                Printf.printf "%s" a;
                                                                ()) "FIN TEST\n")) i)) j)) (i, j)))) (i < 10))) g) in
                                 (f (i, j))) 4)) q)) in
               (p n (j))) 0) 10)) 0);;

