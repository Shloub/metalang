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

let rec main =
  ((fun n ->
       (*  normalement on doit mettre 20 mais là on se tape un overflow  *)
       ((fun n ->
            ((fun tab ->
                 ((fun z ba ->
                      let rec y l n =
                        (if (l <= ba)
                         then (tab.((n - 1)).(l) <- 1; (tab.(l).((n - 1)) <- 1; (y (l + 1) n)))
                         else ((fun w x ->
                                   let rec s o n =
                                     (if (o <= x)
                                      then ((fun r ->
                                                ((fun u v ->
                                                     let rec t p r n =
                                                       (if (p <= v)
                                                        then ((fun q ->
                                                                  (tab.(r).(q) <- (tab.((r + 1)).(q) + tab.(r).((q + 1))); (t (p + 1) r n))) (n - p))
                                                        else (s (o + 1) n)) in
                                                       (t u r n)) 2 n)) (n - o))
                                      else ((fun g h ->
                                                let rec c m n =
                                                  (if (m <= h)
                                                   then ((fun e f ->
                                                             let rec d k n =
                                                               (if (k <= f)
                                                                then (Printf.printf "%d" tab.(m).(k);
                                                                (Printf.printf "%s" " ";
                                                                (d (k + 1) n)))
                                                                else (Printf.printf "%s" "\n";
                                                                (c (m + 1) n))) in
                                                               (d e n)) 0 (n - 1))
                                                   else (Printf.printf "%d" tab.(0).(0);
                                                   (Printf.printf "%s" "\n";
                                                   ()))) in
                                                  (c g n)) 0 (n - 1))) in
                                     (s w n)) 2 n)) in
                        (y z n)) 0 (n - 1))) ((Array.init_withenv n (fun
             i ->
            (fun (n) ->
                ((fun tab2 ->
                     ((fun a ->
                          ((n), a)) tab2)) ((Array.init_withenv n (fun
                 j ->
                (fun (i, n) ->
                    ((fun b ->
                         ((i, n), b)) 0))) ) (i, n))))) ) (n)))) (n + 1))) 10);;

