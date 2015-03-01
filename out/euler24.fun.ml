let fact n =
  let prod = 1 in
  let rec h i prod =
    (if (i <= n)
     then let prod = (prod * i) in
     (h (i + 1) prod)
     else prod) in
    (h 2 prod)
let show lim nth =
  let t = (Array.init lim (fun  i -> i)) in
  let pris = (Array.init lim (fun  j -> false)) in
  let rec f k nth =
    (if (k <= (lim - 1))
     then let n = (fact (lim - k)) in
     let nchiffre = (nth / n) in
     let nth = (nth mod n) in
     let rec g l nchiffre =
       (if (l <= (lim - 1))
        then (if (not pris.(l))
              then (
                     (if (nchiffre = 0)
                      then (
                             (Printf.printf "%d" l);
                             pris.(l) <- true
                             )
                      
                      else ());
                     let nchiffre = (nchiffre - 1) in
                     (g (l + 1) nchiffre)
                     )
              
              else (g (l + 1) nchiffre))
        else (f (k + 1) nth)) in
       (g 0 nchiffre)
     else let rec e m =
            (if (m <= (lim - 1))
             then (if (not pris.(m))
                   then (
                          (Printf.printf "%d" m);
                          (e (m + 1))
                          )
                   
                   else (e (m + 1)))
             else (Printf.printf "\n")) in
            (e 0)) in
    (f 1 nth)
let main =
  (
    (show 10 999999);
    ()
    )
  

