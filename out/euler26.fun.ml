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

let rec periode =
  (fun restes len a b ->
      let rec e restes len a b =
        (if (a <> 0)
         then ((fun chiffre ->
                   ((fun reste ->
                        ((fun h k ->
                             let rec f i reste chiffre restes len a b =
                               (if (i <= k)
                                then ((fun g ->
                                          (if (restes.(i) = reste)
                                           then (len - i)
                                           else (g reste chiffre restes len a b))) (fun
                                 reste chiffre restes len a b ->
                                (f (i + 1) reste chiffre restes len a b)))
                                else (restes.(len) <- reste; ((fun len ->
                                                                  ((fun
                                                                   a ->
                                                                  (e restes len a b)) (reste * 10))) (len + 1)))) in
                               (f h reste chiffre restes len a b)) 0 (len - 1))) (a mod b))) (a / b))
         else 0) in
        (e restes len a b));;
let rec main =
  ((fun c ->
       ((fun t ->
            ((fun m ->
                 ((fun mi ->
                      ((fun q r ->
                           let rec n i mi m c =
                             (if (i <= r)
                              then ((fun p ->
                                        ((fun o ->
                                             (if (p > m)
                                              then ((fun mi ->
                                                        ((fun m ->
                                                             (o p mi m c)) p)) i)
                                              else (o p mi m c))) (fun
                                         p mi m c ->
                                        (n (i + 1) mi m c)))) (periode t 0 1 i))
                              else (Printf.printf "%d" mi;
                              (Printf.printf "%s" "\n";
                              (Printf.printf "%d" m;
                              (Printf.printf "%s" "\n";
                              ()))))) in
                             (n q mi m c)) 1 1000)) 0)) 0)) ((Array.init_withenv c (fun
        j ->
       (fun (c) ->
           ((fun l ->
                ((c), l)) 0))) ) (c)))) 1000);;

