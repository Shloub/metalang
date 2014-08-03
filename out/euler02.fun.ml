module IntSet = Map.Make (struct
  type t = int
  let compare : int -> int -> int = Pervasives.compare
end)

let main =
  ((fun a ->
       ((fun b ->
            ((fun sum ->
                 let rec i j =
                   ((fun (sum, b, a) ->
                        ((fun h ->
                             (if h
                              then (i ((fun (sum, b, a) ->
                                           ((fun g f ->
                                                ((if g
                                                  then (fun () -> ((fun
                                                   sum ->
                                                  ((f sum b a) sum b a)) (sum + a)))
                                                  else (fun () -> ((f sum b a) sum b a))) (fun
                                                 sum b a ->
                                                (f sum b a)))) ((a mod 2) = 0))) (sum, b, a)))
                              else ((fun (sum, b, a) ->
                                        ((fun e ->
                                             Printf.printf "%d" e;
                                             ((fun d ->
                                                  Printf.printf "%s" d;
                                                  ()) "\n")) sum)) (sum, b, a)))) (a < 4000000))) j) in
                   (i (sum, b, a))) 0)) 2)) 1);;

