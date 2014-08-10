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
let rec chiffre =
  (fun c m ->
      ((fun g ->
           (if (c = 0)
            then (m mod 10)
            else (chiffre (c - 1) (m / 10)))) (fun c m ->
                                                  ())));;
let rec main =
  ((fun m ->
       ((fun ba bb ->
            let rec i a m =
              (if (a <= bb)
               then ((fun y z ->
                         let rec j f m =
                           (if (f <= z)
                            then ((fun w x ->
                                      let rec k d m =
                                        (if (d <= x)
                                         then ((fun u v ->
                                                   let rec l c m =
                                                     (if (c <= v)
                                                      then ((fun s t ->
                                                                let rec n b m =
                                                                  (if (b <= t)
                                                                   then ((fun
                                                                    q r ->
                                                                   let rec o e m =
                                                                    (if (e <= r)
                                                                    then ((fun
                                                                     mul ->
                                                                    ((fun
                                                                     p ->
                                                                    (
                                                                    if ((((chiffre 0 mul) = (chiffre 5 mul)) && ((chiffre 1 mul) = (chiffre 4 mul))) && ((chiffre 2 mul) = (chiffre 3 mul)))
                                                                    then ((fun
                                                                     m ->
                                                                    (p mul m)) (max2 mul m))
                                                                    else (p mul m))) (fun
                                                                     mul m ->
                                                                    (o (e + 1) m)))) (((((a * d) + (10 * ((a * e) + (b * d)))) + (100 * (((a * f) + (b * e)) + (c * d)))) + (1000 * ((c * e) + (b * f)))) + ((10000 * c) * f)))
                                                                    else (n (b + 1) m)) in
                                                                    (o q m)) 0 9)
                                                                   else (l (c + 1) m)) in
                                                                  (n s m)) 0 9)
                                                      else (k (d + 1) m)) in
                                                     (l u m)) 1 9)
                                         else (j (f + 1) m)) in
                                        (k w m)) 0 9)
                            else (i (a + 1) m)) in
                           (j y m)) 1 9)
               else (Printf.printf "%d" m;
               (Printf.printf "%s" "\n";
               ()))) in
              (i ba m)) 0 9)) 1);;

