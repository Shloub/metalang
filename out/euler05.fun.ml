module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let primesfactors n =
  ((fun  (e, tab) -> let d = 2 in
  let rec f d n =
    (if ((n <> 1) && ((d * d) <= n))
     then (if ((n mod d) = 0)
           then (
                  tab.(d) <- (tab.(d) + 1);
                  let n = (n / d) in
                  (f d n)
                  )
           
           else let d = (d + 1) in
           (f d n))
     else (
            tab.(n) <- (tab.(n) + 1);
            tab
            )
     ) in
    (f d n)) (Array.init_withenv (n + 1) (fun  i e -> let c = 0 in
  ((), c)) ()))
let main =
  let lim = 20 in
  ((fun  (h, o) -> let rec s i =
                     (if (i <= lim)
                      then let t = (primesfactors i) in
                      let rec u j =
                        (if (j <= i)
                         then (
                                o.(j) <- ((max (o.(j)) (t.(j))));
                                (u (j + 1))
                                )
                         
                         else (s (i + 1))) in
                        (u 1)
                      else let product = 1 in
                      let rec p k product =
                        (if (k <= lim)
                         then let r = o.(k) in
                         let rec q l product =
                           (if (l <= r)
                            then let product = (product * k) in
                            (q (l + 1) product)
                            else (p (k + 1) product)) in
                           (q 1 product)
                         else (
                                (Printf.printf "%d\n" product)
                                )
                         ) in
                        (p 1 product)) in
                     (s 1)) (Array.init_withenv (lim + 1) (fun  m h -> let g = 0 in
  ((), g)) ()))

