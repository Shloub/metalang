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
      ((fun h ->
           (if (a > b)
            then a
            else b)) (fun a b ->
                         ())));;
let rec main =
  ((fun i ->
       ((fun g ->
            ((fun last ->
                 ((fun max_ ->
                      ((fun index ->
                           ((fun nskipdiv ->
                                ((fun p q ->
                                     let rec m k nskipdiv index max_ g i =
                                       (if (k <= q)
                                        then Scanf.scanf "%c" (fun e ->
                                                                  ((fun
                                                                   f ->
                                                                  ((fun
                                                                   n ->
                                                                  (if (f = 0)
                                                                   then ((fun
                                                                    i ->
                                                                   ((fun
                                                                    nskipdiv ->
                                                                   (n f e nskipdiv index max_ g i)) 4)) 1)
                                                                   else ((fun
                                                                    i ->
                                                                   ((fun
                                                                    o ->
                                                                   (if (nskipdiv < 0)
                                                                    then ((fun
                                                                     i ->
                                                                    (o f e nskipdiv index max_ g i)) (i / last.(index)))
                                                                    else (o f e nskipdiv index max_ g i))) (fun
                                                                    f e nskipdiv index max_ g i ->
                                                                   ((fun
                                                                    nskipdiv ->
                                                                   (n f e nskipdiv index max_ g i)) (nskipdiv - 1))))) (i * f)))) (fun
                                                                   f e nskipdiv index max_ g i ->
                                                                  (last.(index) <- f; ((fun
                                                                   index ->
                                                                  ((fun
                                                                   max_ ->
                                                                  (m (k + 1) nskipdiv index max_ g i)) (max2 max_ i))) ((index + 1) mod 5)))))) ((int_of_char (e)) - (int_of_char ('0')))))
                                        else (Printf.printf "%d" max_;
                                        (Printf.printf "%s" "\n";
                                        ()))) in
                                       (m p nskipdiv index max_ g i)) 1 995)) 0)) 0)) i)) ((Array.init_withenv g (fun
             j ->
            (fun (g, i) ->
                Scanf.scanf "%c" (fun c ->
                                     ((fun d ->
                                          ((fun i ->
                                               ((fun l ->
                                                    ((g, i), l)) d)) (i * d))) ((int_of_char (c)) - (int_of_char ('0'))))))) ) (g, i)))) 5)) 1);;

