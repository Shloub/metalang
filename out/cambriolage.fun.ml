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
      ((fun u ->
           (if (a > b)
            then a
            else b)) (fun a b ->
                         ())));;
let rec nbPassePartout =
  (fun n passepartout m serrures ->
      ((fun max_ancient ->
           ((fun max_recent ->
                ((fun s t ->
                     let rec p i max_recent max_ancient n passepartout m serrures =
                       (if (i <= t)
                        then ((fun r ->
                                  (if ((serrures.(i).(0) = (- 1)) && (serrures.(i).(1) > max_ancient))
                                   then ((fun max_ancient ->
                                             (r max_recent max_ancient n passepartout m serrures)) serrures.(i).(1))
                                   else (r max_recent max_ancient n passepartout m serrures))) (fun
                         max_recent max_ancient n passepartout m serrures ->
                        ((fun q ->
                             (if ((serrures.(i).(0) = 1) && (serrures.(i).(1) > max_recent))
                              then ((fun max_recent ->
                                        (q max_recent max_ancient n passepartout m serrures)) serrures.(i).(1))
                              else (q max_recent max_ancient n passepartout m serrures))) (fun
                         max_recent max_ancient n passepartout m serrures ->
                        (p (i + 1) max_recent max_ancient n passepartout m serrures)))))
                        else ((fun max_ancient_pp ->
                                  ((fun max_recent_pp ->
                                       ((fun h o ->
                                            let rec f i max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures =
                                              (if (i <= o)
                                               then ((fun pp ->
                                                         ((fun g ->
                                                              (if ((pp.(0) >= max_ancient) && (pp.(1) >= max_recent))
                                                               then 1
                                                               else (g pp max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures))) (fun
                                                          pp max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures ->
                                                         ((fun max_ancient_pp ->
                                                              ((fun max_recent_pp ->
                                                                   (f (i + 1) max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures)) (max2 max_recent_pp pp.(1)))) (max2 max_ancient_pp pp.(0)))))) passepartout.(i))
                                               else ((fun e ->
                                                         (if ((max_ancient_pp >= max_ancient) && (max_recent_pp >= max_recent))
                                                          then 2
                                                          else 0)) (fun
                                                max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures ->
                                               ()))) in
                                              (f h max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures)) 0 (n - 1))) 0)) 0)) in
                       (p s max_recent max_ancient n passepartout m serrures)) 0 (m - 1))) 0)) 0));;
let rec main =
  Scanf.scanf "%d" (fun n ->
                       (Scanf.scanf "%[\n \010]" (fun _ -> ((fun passepartout ->
                                                                Scanf.scanf "%d" (fun
                                                                 m ->
                                                                (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                                 serrures ->
                                                                (Printf.printf "%d" (nbPassePartout n passepartout m serrures);
                                                                ())) ((Array.init_withenv m (fun
                                                                 k ->
                                                                (fun (m, n) ->
                                                                    ((fun
                                                                     d ->
                                                                    ((fun
                                                                     out1 ->
                                                                    ((fun
                                                                     x ->
                                                                    ((m, n), x)) out1)) ((Array.init_withenv d (fun
                                                                     l ->
                                                                    (fun
                                                                     (d, k, m, n) ->
                                                                    Scanf.scanf "%d" (fun
                                                                     out_ ->
                                                                    (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                                     y ->
                                                                    ((d, k, m, n), y)) out_)))))) ) (d, k, m, n)))) 2))) ) (m, n))))))) ((Array.init_withenv n (fun
                        i ->
                       (fun (n) ->
                           ((fun c ->
                                ((fun out0 ->
                                     ((fun v ->
                                          ((n), v)) out0)) ((Array.init_withenv c (fun
                                 j ->
                                (fun (c, i, n) ->
                                    Scanf.scanf "%d" (fun out__ ->
                                                         (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                          w ->
                                                         ((c, i, n), w)) out__)))))) ) (c, i, n)))) 2))) ) (n))))));;

