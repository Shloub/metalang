module IntSet = Map.Make (struct
  type t = int
  let compare : int -> int -> int = Pervasives.compare
end)

let main =
  ((fun j ->
       (((fun m n ->
             let rec o k p =
               (if (k <= n)
                then (o (k + 1) (((fun k ->
                                      (fun (j) ->
                                          ((fun j ->
                                               ((fun h ->
                                                    Printf.printf "%d" h;
                                                    ((fun g ->
                                                         Printf.printf "%s" g;
                                                         ((fun j ->
                                                              (j)) j)) "\n")) j)) (j + k)))) k) p))
                else ((fun (j) ->
                          ((fun i ->
                               let rec e f =
                                 ((fun (i, j) ->
                                      ((fun d ->
                                           (if d
                                            then (e ((fun (i, j) ->
                                                         ((fun c ->
                                                              Printf.printf "%d" c;
                                                              ((fun i ->
                                                                   ((fun
                                                                    j ->
                                                                   ((fun
                                                                    i j ->
                                                                   (i, j)) i j)) (j + i))) (i + 1))) i)) (i, j)))
                                            else ((fun (i, j) ->
                                                      ((fun b ->
                                                           Printf.printf "%d" b;
                                                           ((fun a ->
                                                                Printf.printf "%d" a;
                                                                ()) i)) j)) (i, j)))) (i < 10))) f) in
                                 (e (i, j))) 4)) p)) in
               (o m (j))) 0) 10)) 0);;

