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
  let ba = (max0 - 1) in
  let rec y i n =
    (if (i <= ba)
     then (if (t.(i) = i)
           then let j = (i * i) in
           let n = (n + 1) in
           let rec z j =
             (if ((j < max0) && (j > 0))
              then (
                     t.(j) <- 0;
                     let j = (j + i) in
                     (z j)
                     )
              
              else (y (i + 1) n)) in
             (z j)
           else (y (i + 1) n))
     else n) in
    (y 2 n)
let fillPrimesFactors t n primes nprimes =
  let x = (nprimes - 1) in
  let rec v i n =
    (if (i <= x)
     then let d = primes.(i) in
     let rec w n =
       (if ((n mod d) = 0)
        then (
               t.(d) <- (t.(d) + 1);
               let n = (n / d) in
               (w n)
               )
        
        else (if (n = 1)
              then primes.(i)
              else (v (i + 1) n))) in
       (w n)
     else n) in
    (v 0 n)
let find ndiv2 =
  let maximumprimes = 110 in
  ((fun  (e, era) -> (
                       e;
                       let nprimes = (eratostene era maximumprimes) in
                       ((fun  (g, primes) -> (
                                               g;
                                               let l = 0 in
                                               let u = (maximumprimes - 1) in
                                               let rec s k l =
                                                 (if (k <= u)
                                                  then (if (era.(k) = k)
                                                        then (
                                                               primes.(l) <- k;
                                                               let l = (l + 1) in
                                                               (s (k + 1) l)
                                                               )
                                                        
                                                        else (s (k + 1) l))
                                                  else let rec h n =
                                                         (if (n <= 10000)
                                                          then ((fun  (q, primesFactors) -> 
                                                          (
                                                            q;
                                                            let max0 = ((max ((fillPrimesFactors primesFactors n primes nprimes)) ((fillPrimesFactors primesFactors (n + 1) primes nprimes)))) in
                                                            (
                                                              primesFactors.(2) <- (primesFactors.(2) - 1);
                                                              let ndivs = 1 in
                                                              let rec r i ndivs =
                                                                (if (i <= max0)
                                                                 then (if (primesFactors.(i) <> 0)
                                                                       then let ndivs = (ndivs * (1 + primesFactors.(i))) in
                                                                       (r (i + 1) ndivs)
                                                                       else (r (i + 1) ndivs))
                                                                 else (if (ndivs > ndiv2)
                                                                       then ((n * (n + 1)) / 2)
                                                                       else (*  print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n"  *)
                                                                       (h (n + 1)))) in
                                                                (r 0 ndivs)
                                                              )
                                                            
                                                            )
                                                          ) (Array.init_withenv (n + 2) (fun  m () -> let p = 0 in
                                                          ((), p)) ()))
                                                          else 0) in
                                                         (h 1)) in
                                                 (s 2 l)
                                               )
                       ) (Array.init_withenv nprimes (fun  o () -> let f = 0 in
                       ((), f)) ()))
                       )
  ) (Array.init_withenv maximumprimes (fun  j () -> let c = j in
  ((), c)) ()))
let main =
  (
    (Printf.printf "%d\n" (find 500));
    ()
    )
  

