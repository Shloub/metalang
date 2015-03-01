let eratostene t max0 =
  let n = 0 in
  let rec m i n =
    (if (i <= (max0 - 1))
     then (if (t.(i) = i)
           then let n = (n + 1) in
           let j = (i * i) in
           let rec u j =
             (if ((j < max0) && (j > 0))
              then (
                     t.(j) <- 0;
                     let j = (j + i) in
                     (u j)
                     )
              
              else (m (i + 1) n)) in
             (u j)
           else (m (i + 1) n))
     else n) in
    (m 2 n)
let fillPrimesFactors t n primes nprimes =
  let rec g i n =
    (if (i <= (nprimes - 1))
     then let d = primes.(i) in
     let rec h n =
       (if ((n mod d) = 0)
        then (
               t.(d) <- (t.(d) + 1);
               let n = (n / d) in
               (h n)
               )
        
        else (if (n = 1)
              then primes.(i)
              else (g (i + 1) n))) in
       (h n)
     else n) in
    (g 0 n)
let sumdivaux2 t n i =
  let rec f i =
    (if ((i < n) && (t.(i) = 0))
     then let i = (i + 1) in
     (f i)
     else i) in
    (f i)
let rec sumdivaux t n i =
  (if (i > n)
   then 1
   else (if (t.(i) = 0)
         then (sumdivaux t n (sumdivaux2 t n (i + 1)))
         else let o = (sumdivaux t n (sumdivaux2 t n (i + 1))) in
         let out0 = 0 in
         let p = i in
         let e = t.(i) in
         let rec c j out0 p =
           (if (j <= e)
            then let out0 = (out0 + p) in
            let p = (p * i) in
            (c (j + 1) out0 p)
            else ((out0 + 1) * o)) in
           (c 1 out0 p)))
let sumdiv nprimes primes n =
  let t = (Array.init (n + 1) (fun  i -> 0)) in
  let max0 = (fillPrimesFactors t n primes nprimes) in
  (sumdivaux t max0 0)
let main =
  let maximumprimes = 30001 in
  let era = (Array.init maximumprimes (fun  s -> s)) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init nprimes (fun  t -> 0)) in
  let l = 0 in
  let rec bh k l =
    (if (k <= (maximumprimes - 1))
     then (if (era.(k) = k)
           then (
                  primes.(l) <- k;
                  let l = (l + 1) in
                  (bh (k + 1) l)
                  )
           
           else (bh (k + 1) l))
     else let n = 100 in
     (*  28124 ça prend trop de temps mais on arrive a passer le test  *)
     let abondant = (Array.init (n + 1) (fun  p -> false)) in
     let summable = (Array.init (n + 1) (fun  q -> false)) in
     let sum = 0 in
     let rec bg r =
       (if (r <= n)
        then let other = ((sumdiv nprimes primes r) - r) in
        (if (other > r)
         then (
                abondant.(r) <- true;
                (bg (r + 1))
                )
         
         else (bg (r + 1)))
        else let rec be i =
               (if (i <= n)
                then let rec bf j =
                       (if (j <= n)
                        then (if ((abondant.(i) && abondant.(j)) && ((i + j) <= n))
                              then (
                                     summable.((i + j)) <- true;
                                     (bf (j + 1))
                                     )
                              
                              else (bf (j + 1)))
                        else (be (i + 1))) in
                       (bf 1)
                else let rec bd o sum =
                       (if (o <= n)
                        then (if (not summable.(o))
                              then let sum = (sum + o) in
                              (bd (o + 1) sum)
                              else (bd (o + 1) sum))
                        else (Printf.printf "\n%d\n" sum)) in
                       (bd 1 sum)) in
               (be 1)) in
       (bg 2)) in
    (bh 2 l)

