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
  let v = 2 in
  let w = n in
  let rec u i prod =
    (if (i <= w)
     then let prod = (prod * i) in
     (u (i + 1) prod)
     else prod) in
    (u v prod)
let show lim nth =
  ((fun  (b, t) -> (
                     b;
                     ((fun  (d, pris) -> (
                                           d;
                                           let r = 1 in
                                           let s = (lim - 1) in
                                           let rec h k nth =
                                             (if (k <= s)
                                              then let n = (fact (lim - k)) in
                                              let nchiffre = (nth / n) in
                                              let nth = (nth mod n) in
                                              let p = 0 in
                                              let q = (lim - 1) in
                                              let rec o l nchiffre =
                                                (if (l <= q)
                                                 then let nchiffre = (if (not pris.(l))
                                                                      then (
                                                                             (if (nchiffre = 0)
                                                                              then 
                                                                              (
                                                                                (Printf.printf "%d" l);
                                                                                pris.(l) <- true
                                                                                )
                                                                              
                                                                              else ());
                                                                             let nchiffre = (nchiffre - 1) in
                                                                             nchiffre
                                                                             )
                                                                      
                                                                      else nchiffre) in
                                                 (o (l + 1) nchiffre)
                                                 else (h (k + 1) nth)) in
                                                (o p nchiffre)
                                              else let f = 0 in
                                              let g = (lim - 1) in
                                              let rec e m =
                                                (if (m <= g)
                                                 then (
                                                        (if (not pris.(m))
                                                         then (Printf.printf "%d" m)
                                                         else ());
                                                        (e (m + 1))
                                                        )
                                                 
                                                 else (Printf.printf "\n")) in
                                                (e f)) in
                                             (h r nth)
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
  

