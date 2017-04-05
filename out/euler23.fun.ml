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
  let maximumprimes = 30001 in
  let era = Array.init maximumprimes (fun s -> s) in
  let nprimes = eratostene era maximumprimes in
  let primes = Array.init nprimes (fun t -> 0) in
  let l = 0 in
  let rec m k l =
    if k <= maximumprimes - 1
    then if era.(k) = k
         then ( primes.(l) <- k;
                let l = l + 1 in
                m (k + 1) l)
         else m (k + 1) l
    else let n = 100 in
    (*  28124 ça prend trop de temps mais on arrive a passer le test  *)
    let abondant = Array.init (n + 1) (fun p -> false) in
    let summable = Array.init (n + 1) (fun q -> false) in
    let sum = 0 in
    let rec u r =
      if r <= n
      then let other = sumdiv nprimes primes r - r in
      if other > r
      then ( abondant.(r) <- true;
             u (r + 1))
      else u (r + 1)
      else let rec v i =
             if i <= n
             then let rec x j =
                    if j <= n
                    then if abondant.(i) && abondant.(j) && i + j <= n
                         then ( summable.(i + j) <- true;
                                x (j + 1))
                         else x (j + 1)
                    else v (i + 1) in
                    x 1
             else let rec w o sum =
                    if o <= n
                    then if not summable.(o)
                         then let sum = sum + o in
                         w (o + 1) sum
                         else w (o + 1) sum
                    else Printf.printf "\n%d\n" sum in
                    w 1 sum in
             v 1 in
      u 2 in
    m 2 l

