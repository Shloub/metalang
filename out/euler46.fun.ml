let eratostene t max0 =
  let n = 0 in
  let c = (max0 - 1) in
  let rec a i n =
    (if (i <= c)
     then (if (t.(i) = i)
           then let n = (n + 1) in
           (if ((max0 / i) > i)
            then let j = (i * i) in
            let rec b j =
              (if ((j < max0) && (j > 0))
               then (
                      t.(j) <- 0;
                      let j = (j + i) in
                      (b j)
                      )
               
               else (a (i + 1) n)) in
              (b j)
            else (a (i + 1) n))
           else (a (i + 1) n))
     else n) in
    (a 2 n)
let main =
  let maximumprimes = 6000 in
  let era = (Array.init maximumprimes (fun  j_ -> j_)) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init nprimes (fun  o -> 0)) in
  let l = 0 in
  let x = (maximumprimes - 1) in
  let rec w k l =
    (if (k <= x)
     then (if (era.(k) = k)
           then (
                  primes.(l) <- k;
                  let l = (l + 1) in
                  (w (k + 1) l)
                  )
           
           else (w (k + 1) l))
     else (
            (Printf.printf "%d == %d\n" l nprimes);
            let canbe = (Array.init maximumprimes (fun  i_ -> false)) in
            let v = (nprimes - 1) in
            let rec r i =
              (if (i <= v)
               then let u = (maximumprimes - 1) in
               let rec s j =
                 (if (j <= u)
                  then let n = (primes.(i) + ((2 * j) * j)) in
                  (if (n < maximumprimes)
                   then (
                          canbe.(n) <- true;
                          (s (j + 1))
                          )
                   
                   else (s (j + 1)))
                  else (r (i + 1))) in
                 (s 0)
               else let rec q m =
                      (if (m <= maximumprimes)
                       then let m2 = ((m * 2) + 1) in
                       (if ((m2 < maximumprimes) && (not canbe.(m2)))
                        then (
                               (Printf.printf "%d\n" m2);
                               (q (m + 1))
                               )
                        
                        else (q (m + 1)))
                       else ()) in
                      (q 1)) in
              (r 0)
            )
     ) in
    (w 2 l)

