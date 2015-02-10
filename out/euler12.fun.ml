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
  let bh = 2 in
  let bi = (max0 - 1) in
  let rec bf i n =
    (if (i <= bi)
     then let n = (if (t.(i) = i)
                   then let j = (i * i) in
                   let n = (n + 1) in
                   let rec bg j =
                     (if ((j < max0) && (j > 0))
                      then (
                             t.(j) <- 0;
                             let j = (j + i) in
                             (bg j)
                             )
                      
                      else n) in
                     (bg j)
                   else n) in
     (bf (i + 1) n)
     else n) in
    (bf bh n)
let fillPrimesFactors t n primes nprimes =
  let bd = 0 in
  let be = (nprimes - 1) in
  let rec bb i n =
    (if (i <= be)
     then let d = primes.(i) in
     let rec bc n =
       (if ((n mod d) = 0)
        then (
               t.(d) <- (t.(d) + 1);
               let n = (n / d) in
               (bc n)
               )
        
        else (if (n = 1)
              then primes.(i)
              else (bb (i + 1) n))) in
       (bc n)
     else n) in
    (bb bd n)
let find ndiv2 =
  let maximumprimes = 110 in
  let era = (Array.init_withenv maximumprimes (fun  j () -> let h = j in
  ((), h)) ()) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun  o () -> let p = 0 in
  ((), p)) ()) in
  let l = 0 in
  let z = 2 in
  let ba = (maximumprimes - 1) in
  let rec y k l =
    (if (k <= ba)
     then let l = (if (era.(k) = k)
                   then (
                          primes.(l) <- k;
                          let l = (l + 1) in
                          l
                          )
                   
                   else l) in
     (y (k + 1) l)
     else let w = 1 in
     let x = 10000 in
     let rec q n =
       (if (n <= x)
        then let primesFactors = (Array.init_withenv (n + 2) (fun  m () -> let r = 0 in
        ((), r)) ()) in
        let max0 = ((max ((fillPrimesFactors primesFactors n primes nprimes)) ((fillPrimesFactors primesFactors (n + 1) primes nprimes)))) in
        (
          primesFactors.(2) <- (primesFactors.(2) - 1);
          let ndivs = 1 in
          let u = 0 in
          let v = max0 in
          let rec s i ndivs =
            (if (i <= v)
             then let ndivs = (if (primesFactors.(i) <> 0)
                               then let ndivs = (ndivs * (1 + primesFactors.(i))) in
                               ndivs
                               else ndivs) in
             (s (i + 1) ndivs)
             else (if (ndivs > ndiv2)
                   then ((n * (n + 1)) / 2)
                   else (*  print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n"  *)
                   (q (n + 1)))) in
            (s u ndivs)
          )
        
        else 0) in
       (q w)) in
    (y z l)
let main =
  (
    (Printf.printf "%d\n" (find 500));
    ()
    )
  

