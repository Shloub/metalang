module IntSet = Map.Make (struct
  type t = int
  let compare : int -> int -> int = Pervasives.compare
end)

let main =
  ((fun sum ->
       (((fun e f ->
             let rec g i h =
               (if (i <= f)
                then (g (i + 1) (((fun i ->
                                      (fun (sum) ->
                                          ((fun c ->
                                               ((if c
                                                 then (fun () -> ((fun
                                                  sum ->
                                                 ((fun sum ->
                                                      ((fun sum ->
                                                           (sum)) sum)) sum)) (sum + i)))
                                                 else (fun () -> ((fun
                                                  sum ->
                                                 ((fun sum ->
                                                      (sum)) sum)) sum))) ())) (((i mod 3) = 0) || ((i mod 5) = 0))))) i) h))
                else ((fun (sum) ->
                          ((fun b ->
                               Printf.printf "%d" b;
                               ((fun a ->
                                    Printf.printf "%s" a;
                                    ()) "\n")) sum)) h)) in
               (g e (sum))) 0) 999)) 0);;

