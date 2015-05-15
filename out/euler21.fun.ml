let eratostene t max0 =
  let n = 0 in
  let rec a i n =
    if i <= max0 - 1
    then if t.(i) = i
         then let n = n + 1 in
         let j = i * i in
         let rec b j =
           if j < max0 && j > 0
           then ( t.(j) <- 0;
                  let j = j + i in
                  b j)
           else a (i + 1) n in
           b j
         else a (i + 1) n
    else n in
    a 2 n
let fillPrimesFactors t n primes nprimes =
  let rec c i n =
    if i <= nprimes - 1
    then let d = primes.(i) in
    let rec e n =
      if n mod d = 0
      then ( t.(d) <- t.(d) + 1;
             let n = n / d in
             e n)
      else if n = 1
           then primes.(i)
           else c (i + 1) n in
      e n
    else n in
    c 0 n
let sumdivaux2 t n i =
  let rec f i =
    if i < n && t.(i) = 0
    then let i = i + 1 in
    f i
    else i in
    f i
let rec sumdivaux t n i =
  if i > n
  then 1
  else if t.(i) = 0
       then sumdivaux t n (sumdivaux2 t n (i + 1))
       else let o = sumdivaux t n (sumdivaux2 t n (i + 1)) in
       let out0 = 0 in
       let p = i in
       let g = t.(i) in
       let rec h j out0 p =
         if j <= g
         then let out0 = out0 + p in
         let p = p * i in
         h (j + 1) out0 p
         else (out0 + 1) * o in
         h 1 out0 p
let sumdiv nprimes primes n =
  let t = Array.init (n + 1) (fun i -> 0) in
  let max0 = fillPrimesFactors t n primes nprimes in
  sumdivaux t max0 0
let main =
  let maximumprimes = 1001 in
  let era = Array.init maximumprimes (fun j -> j) in
  let nprimes = eratostene era maximumprimes in
  let primes = Array.init nprimes (fun o -> 0) in
  let l = 0 in
  let rec m k l =
    if k <= maximumprimes - 1
    then if era.(k) = k
         then ( primes.(l) <- k;
                let l = l + 1 in
                m (k + 1) l)
         else m (k + 1) l
    else ( Printf.printf "%d == %d\n" l nprimes;
           let sum = 0 in
           let rec q n sum =
             if n <= 1000
             then let other = sumdiv nprimes primes n - n in
             if other > n
             then let othersum = sumdiv nprimes primes other - other in
             if othersum = n
             then ( Printf.printf "%d & %d\n" other n;
                    let sum = sum + other + n in
                    q (n + 1) sum)
             else q (n + 1) sum
             else q (n + 1) sum
             else Printf.printf "\n%d\n" sum in
             q 2 sum) in
    m 2 l

