let eratostene t max0 =
  let n = 0 in
  let rec c i n =
    if i <= max0 - 1
    then if t.(i) = i
         then let j = i * i in
         let n = n + 1 in
         let rec e j =
           if j < max0 && j > 0
           then ( t.(j) <- 0;
                  let j = j + i in
                  e j)
           else c (i + 1) n in
           e j
         else c (i + 1) n
    else n in
    c 2 n

let fillPrimesFactors t n primes nprimes =
  let rec f i n =
    if i <= nprimes - 1
    then let d = primes.(i) in
    let rec g n =
      if n mod d = 0
      then ( t.(d) <- t.(d) + 1;
             let n = n / d in
             g n)
      else if n = 1
           then primes.(i)
           else f (i + 1) n in
      g n
    else n in
    f 0 n

let find ndiv2 =
  let maximumprimes = 110 in
  let era = Array.init maximumprimes (fun j -> j) in
  let nprimes = eratostene era maximumprimes in
  let primes = Array.init nprimes (fun o -> 0) in
  let l = 0 in
  let rec h k l =
    if k <= maximumprimes - 1
    then if era.(k) = k
         then ( primes.(l) <- k;
                let l = l + 1 in
                h (k + 1) l)
         else h (k + 1) l
    else let rec p n =
           if n <= 10000
           then let primesFactors = Array.init (n + 2) (fun m -> 0) in
           let max0 = (max (fillPrimesFactors primesFactors n primes nprimes) (fillPrimesFactors primesFactors (n + 1) primes nprimes)) in
           ( primesFactors.(2) <- primesFactors.(2) - 1;
             let ndivs = 1 in
             let rec q i ndivs =
               if i <= max0
               then if primesFactors.(i) <> 0
                    then let ndivs = ndivs * (1 + primesFactors.(i)) in
                    q (i + 1) ndivs
                    else q (i + 1) ndivs
               else if ndivs > ndiv2
                    then n * (n + 1) / 2
                    else (*  print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n"  *)
                    p (n + 1) in
               q 0 ndivs)
           else 0 in
           p 1 in
    h 2 l

let main =
  Printf.printf "%d\n" (find 500)

