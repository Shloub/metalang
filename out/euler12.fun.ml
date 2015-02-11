module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    )
end

let eratostene t max0 =
  let n = 0 in
  let bd = 2 in
  let be = (max0 - 1) in
  let rec bb i n =
    (if (i <= be)
     then let n = (if (t.(i) = i)
                   then let j = (i * i) in
                   let n = (n + 1) in
                   let rec bc j =
                     (if ((j < max0) && (j > 0))
                      then (
                             t.(j) <- 0;
                             let j = (j + i) in
                             (bc j)
                             )
                      
                      else n) in
                     (bc j)
                   else n) in
     (bb (i + 1) n)
     else n) in
    (bb bd n)
let fillPrimesFactors t n primes nprimes =
  let z = 0 in
  let ba = (nprimes - 1) in
  let rec x i n =
    (if (i <= ba)
     then let d = primes.(i) in
     let rec y n =
       (if ((n mod d) = 0)
        then (
               t.(d) <- (t.(d) + 1);
               let n = (n / d) in
               (y n)
               )
        
        else (if (n = 1)
              then primes.(i)
              else (x (i + 1) n))) in
       (y n)
     else n) in
    (x z n)
let find ndiv2 =
  let maximumprimes = 110 in
  let era = (Array.init_withenv maximumprimes (fun  j () -> let c = j in
  ((), c)) ()) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun  o () -> let e = 0 in
  ((), e)) ()) in
  let l = 0 in
  let v = 2 in
  let w = (maximumprimes - 1) in
  let rec u k l =
    (if (k <= w)
     then let l = (if (era.(k) = k)
                   then (
                          primes.(l) <- k;
                          let l = (l + 1) in
                          l
                          )
                   
                   else l) in
     (u (k + 1) l)
     else let r = 1 in
     let s = 10000 in
     let rec f n =
       (if (n <= s)
        then let primesFactors = (Array.init_withenv (n + 2) (fun  m () -> let g = 0 in
        ((), g)) ()) in
        let max0 = ((max ((fillPrimesFactors primesFactors n primes nprimes)) ((fillPrimesFactors primesFactors (n + 1) primes nprimes)))) in
        (
          primesFactors.(2) <- (primesFactors.(2) - 1);
          let ndivs = 1 in
          let p = 0 in
          let q = max0 in
          let rec h i ndivs =
            (if (i <= q)
             then let ndivs = (if (primesFactors.(i) <> 0)
                               then let ndivs = (ndivs * (1 + primesFactors.(i))) in
                               ndivs
                               else ndivs) in
             (h (i + 1) ndivs)
             else (if (ndivs > ndiv2)
                   then ((n * (n + 1)) / 2)
                   else (*  print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n"  *)
                   (f (n + 1)))) in
            (h p ndivs)
          )
        
        else 0) in
       (f r)) in
    (u v l)
let main =
  (
    (Printf.printf "%d\n" (find 500));
    ()
    )
  

