module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    )
end

let rec max2 =
  (fun a b ->
      ((fun q ->
           (if (a > b)
            then a
            else b)) (fun a b ->
                         ())));;
let rec primesfactors =
  (fun n ->
      ((fun c ->
           ((fun tab ->
                ((fun d ->
                     let rec h d c n =
                       (if ((n <> 1) && ((d * d) <= n))
                        then ((fun p ->
                                  (if ((n mod d) = 0)
                                   then (tab.(d) <- (tab.(d) + 1); ((fun
                                    n ->
                                   (p d c n)) (n / d)))
                                   else ((fun d ->
                                             (p d c n)) (d + 1)))) (fun
                         d c n ->
                        (h d c n)))
                        else (tab.(n) <- (tab.(n) + 1); tab)) in
                       (h d c n)) 2)) ((Array.init_withenv c (fun i ->
                                                                 (fun
                                                                  (c, n) ->
                                                                 ((fun
                                                                  f ->
                                                                 ((c, n), f)) 0))) ) (c, n)))) (n + 1)));;
let rec main =
  ((fun lim ->
       ((fun e ->
            ((fun o ->
                 ((fun bd be ->
                      let rec z i e lim =
                        (if (i <= be)
                         then ((fun t ->
                                   ((fun bb bc ->
                                        let rec ba j t e lim =
                                          (if (j <= bc)
                                           then (o.(j) <- (max2 o.(j) t.(j)); (ba (j + 1) t e lim))
                                           else (z (i + 1) e lim)) in
                                          (ba bb t e lim)) 1 i)) (primesfactors i))
                         else ((fun product ->
                                   ((fun x y ->
                                        let rec s k product e lim =
                                          (if (k <= y)
                                           then ((fun v w ->
                                                     let rec u l product e lim =
                                                       (if (l <= w)
                                                        then ((fun product ->
                                                                  (u (l + 1) product e lim)) (product * k))
                                                        else (s (k + 1) product e lim)) in
                                                       (u v product e lim)) 1 o.(k))
                                           else (Printf.printf "%d" product;
                                           (Printf.printf "%s" "\n";
                                           ()))) in
                                          (s x product e lim)) 1 lim)) 1)) in
                        (z bd e lim)) 1 lim)) ((Array.init_withenv e (fun
             m ->
            (fun (e, lim) ->
                ((fun r ->
                     ((e, lim), r)) 0))) ) (e, lim)))) (lim + 1))) 20);;

