let max2 a b =
  (max a b)
let rec chiffre c m =
  let g () = () in
  (if (c = 0)
   then (m mod 10)
   else (chiffre (c - 1) (m / 10)))
let main =
  let m = 1 in
  let y = 0 in
  let z = 9 in
  let rec h a m =
    (if (a <= z)
     then let w = 1 in
     let x = 9 in
     let rec i f m =
       (if (f <= x)
        then let u = 0 in
        let v = 9 in
        let rec j d m =
          (if (d <= v)
           then let s = 1 in
           let t = 9 in
           let rec k c m =
             (if (c <= t)
              then let q = 0 in
              let r = 9 in
              let rec l b m =
                (if (b <= r)
                 then let o = 0 in
                 let p = 9 in
                 let rec n e m =
                   (if (e <= p)
                    then let mul = (((((a * d) + (10 * ((a * e) + (b * d)))) + (100 * (((a * f) + (b * e)) + (c * d)))) + (1000 * ((c * e) + (b * f)))) + ((10000 * c) * f)) in
                    let m = (if ((((chiffre 0 mul) = (chiffre 5 mul)) && ((chiffre 1 mul) = (chiffre 4 mul))) && ((chiffre 2 mul) = (chiffre 3 mul)))
                             then let m = (max2 mul m) in
                             m
                             else m) in
                    (n (e + 1) m)
                    else (l (b + 1) m)) in
                   (n o m)
                 else (k (c + 1) m)) in
                (l q m)
              else (j (d + 1) m)) in
             (k s m)
           else (i (f + 1) m)) in
          (j u m)
        else (h (a + 1) m)) in
       (i w m)
     else (
            (Printf.printf "%d\n" m)
            )
     ) in
    (h y m)

