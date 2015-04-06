let fact n =
  let prod = 1 in
  let rec a i prod =
    (if (i <= n)
     then let prod = (prod * i) in
     (a (i + 1) prod)
     else prod) in
    (a 2 prod)
let show lim nth =
  let t = (Array.init lim (fun  i -> i)) in
  let pris = (Array.init lim (fun  j -> false)) in
  let rec b k nth =
    (if (k <= (lim - 1))
     then let n = (fact (lim - k)) in
     let nchiffre = (nth / n) in
     let nth = (nth mod n) in
     let rec c l nchiffre =
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
                     (c (l + 1) nchiffre)
                     )
              
              else (c (l + 1) nchiffre))
        else (b (k + 1) nth)) in
       (c 0 nchiffre)
     else let rec d m =
            (if (m <= (lim - 1))
             then (if (not pris.(m))
                   then (
                          (Printf.printf "%d" m);
                          (d (m + 1))
                          )
                   
                   else (d (m + 1)))
             else (Printf.printf "\n")) in
            (d 0)) in
    (b 1 nth)
let main =
  (
    (show 10 999999);
    ()
    )
  

