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
     let rec p j =
       (if (j <= i)
        then (
               o.(j) <- ((max (o.(j)) (t.(j))));
               (p (j + 1))
               )
        
        else (e (i + 1))) in
       (p 1)
     else let product = 1 in
     let rec f k product =
       (if (k <= lim)
        then let g = o.(k) in
        let rec h l product =
          (if (l <= g)
           then let product = (product * k) in
           (h (l + 1) product)
           else (f (k + 1) product)) in
          (h 1 product)
        else (Printf.printf "%d\n" product)) in
       (f 1 product)) in
    (e 1)

