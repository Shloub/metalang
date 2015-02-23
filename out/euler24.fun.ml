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

let fact n =
  let prod = 1 in
  let rec q i prod =
    (if (i <= n)
     then let prod = (prod * i) in
     (q (i + 1) prod)
     else prod) in
    (q 2 prod)
let show lim nth =
  ((fun  (b, t) -> (
                     b;
                     ((fun  (d, pris) -> (
                                           d;
                                           let p = (lim - 1) in
                                           let rec g k nth =
                                             (if (k <= p)
                                              then let n = (fact (lim - k)) in
                                              let nchiffre = (nth / n) in
                                              let nth = (nth mod n) in
                                              let o = (lim - 1) in
                                              let rec h l nchiffre =
                                                (if (l <= o)
                                                 then (if (not pris.(l))
                                                       then (
                                                              (if (nchiffre = 0)
                                                               then (
                                                                      (Printf.printf "%d" l);
                                                                      pris.(l) <- true
                                                                      )
                                                               
                                                               else ());
                                                              let nchiffre = (nchiffre - 1) in
                                                              (h (l + 1) nchiffre)
                                                              )
                                                       
                                                       else (h (l + 1) nchiffre))
                                                 else (g (k + 1) nth)) in
                                                (h 0 nchiffre)
                                              else let f = (lim - 1) in
                                              let rec e m =
                                                (if (m <= f)
                                                 then (if (not pris.(m))
                                                       then (
                                                              (Printf.printf "%d" m);
                                                              (e (m + 1))
                                                              )
                                                       
                                                       else (e (m + 1)))
                                                 else (Printf.printf "\n")) in
                                                (e 0)) in
                                             (g 1 nth)
                                           )
                     ) (Array.init_withenv lim (fun  j () -> let c = false in
                     ((), c)) ()))
                     )
  ) (Array.init_withenv lim (fun  i () -> let a = i in
  ((), a)) ()))
let main =
  (
    (show 10 999999);
    ()
    )
  

