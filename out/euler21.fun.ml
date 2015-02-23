module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let eratostene t max0 =
  let n = 0 in
  let s = (max0 - 1) in
  let rec q i n =
    (if (i <= s)
     then (if (t.(i) = i)
           then let n = (n + 1) in
           let j = (i * i) in
           let rec r j =
             (if ((j < max0) && (j > 0))
              then (
                     t.(j) <- 0;
                     let j = (j + i) in
                     (r j)
                     )
              
              else (q (i + 1) n)) in
             (r j)
           else (q (i + 1) n))
     else n) in
    (q 2 n)
let fillPrimesFactors t n primes nprimes =
  let m = (nprimes - 1) in
  let rec g i n =
    (if (i <= m)
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
  ((fun  (b, t) -> (
                     b;
                     let max0 = (fillPrimesFactors t n primes nprimes) in
                     (sumdivaux t max0 0)
                     )
  ) (Array.init_withenv (n + 1) (fun  i () -> let a = 0 in
  ((), a)) ()))
let main =
  let maximumprimes = 1001 in
  ((fun  (v, era) -> (
                       v;
                       let nprimes = (eratostene era maximumprimes) in
                       ((fun  (x, primes) -> (
                                               x;
                                               let l = 0 in
                                               let ba = (maximumprimes - 1) in
                                               let rec z k l =
                                                 (if (k <= ba)
                                                  then (if (era.(k) = k)
                                                        then (
                                                               primes.(l) <- k;
                                                               let l = (l + 1) in
                                                               (z (k + 1) l)
                                                               )
                                                        
                                                        else (z (k + 1) l))
                                                  else (
                                                         (Printf.printf "%d == %d\n" l nprimes);
                                                         let sum = 0 in
                                                         let rec y n sum =
                                                           (if (n <= 1000)
                                                            then let other = ((sumdiv nprimes primes n) - n) in
                                                            (if (other > n)
                                                             then let othersum = ((sumdiv nprimes primes other) - other) in
                                                             (if (othersum = n)
                                                              then (
                                                                     (Printf.printf "%d & %d\n" other n);
                                                                     let sum = (sum + (other + n)) in
                                                                     (y (n + 1) sum)
                                                                     )
                                                              
                                                              else (y (n + 1) sum))
                                                             else (y (n + 1) sum))
                                                            else (
                                                                   (Printf.printf "\n%d\n" sum)
                                                                   )
                                                            ) in
                                                           (y 2 sum)
                                                         )
                                                  ) in
                                                 (z 2 l)
                                               )
                       ) (Array.init_withenv nprimes (fun  o () -> let w = 0 in
                       ((), w)) ()))
                       )
  ) (Array.init_withenv maximumprimes (fun  j () -> let u = j in
  ((), u)) ()))

