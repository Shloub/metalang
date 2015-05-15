let eratostene t max0 =
  let n = 0 in
  let rec a i n =
    if i <= max0 - 1
    then if t.(i) = i
         then let n = n + 1 in
         if max0 / i > i
         then let j = i * i in
         let rec b j =
           if j < max0 && j > 0
           then ( t.(j) <- 0;
                  let j = j + i in
                  b j)
           else a (i + 1) n in
           b j
         else a (i + 1) n
         else a (i + 1) n
    else n in
    a 2 n
let main =
  let maximumprimes = 6000 in
  let era = Array.init maximumprimes (fun j_ -> j_) in
  let nprimes = eratostene era maximumprimes in
  let primes = Array.init nprimes (fun o -> 0) in
  let l = 0 in
  let rec c k l =
    if k <= maximumprimes - 1
    then if era.(k) = k
         then ( primes.(l) <- k;
                let l = l + 1 in
                c (k + 1) l)
         else c (k + 1) l
    else ( Printf.printf "%d == %d\n" l nprimes;
           let canbe = Array.init maximumprimes (fun i_ -> false) in
           let rec d i =
             if i <= nprimes - 1
             then let rec f j =
                    if j <= maximumprimes - 1
                    then let n = primes.(i) + 2 * j * j in
                    if n < maximumprimes
                    then ( canbe.(n) <- true;
                           f (j + 1))
                    else f (j + 1)
                    else d (i + 1) in
                    f 0
             else let rec e m =
                    if m <= maximumprimes
                    then let m2 = m * 2 + 1 in
                    if m2 < maximumprimes && not canbe.(m2)
                    then ( Printf.printf "%d\n" m2;
                           e (m + 1))
                    else e (m + 1)
                    else () in
                    e 1 in
             d 0) in
    c 2 l

