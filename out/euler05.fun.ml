let primesfactors n =
  let tab = (Array.init (n + 1) (fun  i -> 0)) in
  let d = 2 in
  let rec c d n =
    (if ((n <> 1) && ((d * d) <= n))
     then (if ((n mod d) = 0)
           then (
                  tab.(d) <- (tab.(d) + 1);
                  let n = (n / d) in
                  (c d n)
                  )
           
           else let d = (d + 1) in
           (c d n))
     else (
            tab.(n) <- (tab.(n) + 1);
            tab
            )
     ) in
    (c d n)
let main =
  let lim = 20 in
  let o = (Array.init (lim + 1) (fun  m -> 0)) in
  let rec e i =
    (if (i <= lim)
     then let t = (primesfactors i) in
     let rec f j =
       (if (j <= i)
        then (
               o.(j) <- ((max (o.(j)) (t.(j))));
               (f (j + 1))
               )
        
        else (e (i + 1))) in
       (f 1)
     else let product = 1 in
     let rec g k product =
       (if (k <= lim)
        then let h = o.(k) in
        let rec p l product =
          (if (l <= h)
           then let product = (product * k) in
           (p (l + 1) product)
           else (g (k + 1) product)) in
          (p 1 product)
        else (Printf.printf "%d\n" product)) in
       (g 1 product)) in
    (e 1)

