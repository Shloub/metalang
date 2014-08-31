let rec chiffre c m =
  let h () = () in
  (if (c = 0)
   then (m mod 10)
   else (chiffre (c - 1) (m / 10)))
let main =
  let m = 1 in
  let z = 0 in
  let ba = 9 in
  let rec i a m =
    (if (a <= ba)
     then let x = 1 in
     let y = 9 in
     let rec j f m =
       (if (f <= y)
        then let v = 0 in
        let w = 9 in
        let rec k d m =
          (if (d <= w)
           then let t = 1 in
           let u = 9 in
           let rec l c m =
             (if (c <= u)
              then let r = 0 in
              let s = 9 in
              let rec n b m =
                (if (b <= s)
                 then let p = 0 in
                 let q = 9 in
                 let rec o e m =
                   (if (e <= q)
                    then let mul = (((((a * d) + (10 * ((a * e) + (b * d)))) + (100 * (((a * f) + (b * e)) + (c * d)))) + (1000 * ((c * e) + (b * f)))) + ((10000 * c) * f)) in
                    let m = (if ((((chiffre 0 mul) = (chiffre 5 mul)) && ((chiffre 1 mul) = (chiffre 4 mul))) && ((chiffre 2 mul) = (chiffre 3 mul)))
                             then let g = ((max (mul) (m))) in
                             let m = g in
                             m
                             else m) in
                    (o (e + 1) m)
                    else (n (b + 1) m)) in
                   (o p m)
                 else (l (c + 1) m)) in
                (n r m)
              else (k (d + 1) m)) in
             (l t m)
           else (j (f + 1) m)) in
          (k v m)
        else (i (a + 1) m)) in
       (j x m)
     else (
            (Printf.printf "%d\n" m)
            )
     ) in
    (i z m)

