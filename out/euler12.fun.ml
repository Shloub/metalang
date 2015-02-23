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
  let bg = 2 in
  let bh = (max0 - 1) in
  let rec be i n =
    (if (i <= bh)
     then let n = (if (t.(i) = i)
                   then let j = (i * i) in
                   let n = (n + 1) in
                   let rec bf j =
                     (if ((j < max0) && (j > 0))
                      then (
                             t.(j) <- 0;
                             let j = (j + i) in
                             (bf j)
                             )
                      
                      else n) in
                     (bf j)
                   else n) in
     (be (i + 1) n)
     else n) in
    (be bg n)
let fillPrimesFactors t n primes nprimes =
  let bc = 0 in
  let bd = (nprimes - 1) in
  let rec ba i n =
    (if (i <= bd)
     then let d = primes.(i) in
     let rec bb n =
       (if ((n mod d) = 0)
        then (
               t.(d) <- (t.(d) + 1);
               let n = (n / d) in
               (bb n)
               )
        
        else (if (n = 1)
              then primes.(i)
              else (ba (i + 1) n))) in
       (bb n)
     else n) in
    (ba bc n)
let find ndiv2 =
  let maximumprimes = 110 in
  ((fun  (e, era) -> (
                       e;
                       let nprimes = (eratostene era maximumprimes) in
                       ((fun  (g, primes) -> (
                                               g;
                                               let l = 0 in
                                               let y = 2 in
                                               let z = (maximumprimes - 1) in
                                               let rec x k l =
                                                 (if (k <= z)
                                                  then let l = (if (era.(k) = k)
                                                                then (
                                                                       primes.(l) <- k;
                                                                       let l = (l + 1) in
                                                                       l
                                                                       )
                                                                
                                                                else l) in
                                                  (x (k + 1) l)
                                                  else let v = 1 in
                                                  let w = 10000 in
                                                  let rec h n =
                                                    (if (n <= w)
                                                     then ((fun  (q, primesFactors) -> 
                                                     (
                                                       q;
                                                       let max0 = ((max ((fillPrimesFactors primesFactors n primes nprimes)) ((fillPrimesFactors primesFactors (n + 1) primes nprimes)))) in
                                                       (
                                                         primesFactors.(2) <- (primesFactors.(2) - 1);
                                                         let ndivs = 1 in
                                                         let s = 0 in
                                                         let u = max0 in
                                                         let rec r i ndivs =
                                                           (if (i <= u)
                                                            then let ndivs = (if (primesFactors.(i) <> 0)
                                                                              then let ndivs = (ndivs * (1 + primesFactors.(i))) in
                                                                              ndivs
                                                                              else ndivs) in
                                                            (r (i + 1) ndivs)
                                                            else (if (ndivs > ndiv2)
                                                                  then ((n * (n + 1)) / 2)
                                                                  else (*  print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n"  *)
                                                                  (h (n + 1)))) in
                                                           (r s ndivs)
                                                         )
                                                       
                                                       )
                                                     ) (Array.init_withenv (n + 2) (fun  m () -> let p = 0 in
                                                     ((), p)) ()))
                                                     else 0) in
                                                    (h v)) in
                                                 (x y l)
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
  

