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

let fact n =
  let prod = 1 in
  let s = 2 in
  let u = n in
  let rec r i prod =
    (if (i <= u)
     then let prod = (prod * i) in
     (r (i + 1) prod)
     else prod) in
    (r s prod)
let show lim nth =
  let t = (Array.init_withenv lim (fun  i () -> let a = i in
  ((), a)) ()) in
  let pris = (Array.init_withenv lim (fun  j () -> let b = false in
  ((), b)) ()) in
  let p = 1 in
  let q = (lim - 1) in
  let rec f k nth =
    (if (k <= q)
     then let n = (fact (lim - k)) in
     let nchiffre = (nth / n) in
     let nth = (nth mod n) in
     let h = 0 in
     let o = (lim - 1) in
     let rec g l nchiffre =
       (if (l <= o)
        then let nchiffre = (if (not pris.(l))
                             then (
                                    (if (nchiffre = 0)
                                     then (
                                            (Printf.printf "%d" l);
                                            pris.(l) <- true;
                                            ()
                                            )
                                     
                                     else ());
                                    let nchiffre = (nchiffre - 1) in
                                    nchiffre
                                    )
                             
                             else nchiffre) in
        (g (l + 1) nchiffre)
        else (f (k + 1) nth)) in
       (g h nchiffre)
     else let d = 0 in
     let e = (lim - 1) in
     let rec c m =
       (if (m <= e)
        then (
               (if (not pris.(m))
                then (Printf.printf "%d" m)
                else ());
               (c (m + 1))
               )
        
        else (Printf.printf "%s" "\n")) in
       (c d)) in
    (f p nth)
let main =
  (
    (show 10 999999);
    ()
    )
  

