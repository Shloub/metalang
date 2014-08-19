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

let max2 a b =
  let bi () = () in
  (if (a > b)
   then a
   else b)
let eratostene t max_ =
  let n = 0 in
  let bg = 2 in
  let bh = (max_ - 1) in
  let rec bd i n =
    (if (i <= bh)
     then let n = (if (t.(i) = i)
                   then let j = (i * i) in
                   let n = (n + 1) in
                   let rec bf j =
                     (if ((j < max_) && (j > 0))
                      then (
                             t.(j) <- 0;
                             let j = (j + i) in
                             (bf j)
                             )
                      
                      else n) in
                     (bf j)
                   else n) in
     (bd (i + 1) n)
     else n) in
    (bd bg n)
let fillPrimesFactors t n primes nprimes =
  let bb = 0 in
  let bc = (nprimes - 1) in
  let rec y i n =
    (if (i <= bc)
     then let d = primes.(i) in
     let rec ba n =
       (if ((n mod d) = 0)
        then (
               t.(d) <- (t.(d) + 1);
               let n = (n / d) in
               (ba n)
               )
        
        else (if (n = 1)
              then primes.(i)
              else (y (i + 1) n))) in
       (ba n)
     else n) in
    (y bb n)
let find ndiv2 =
  let maximumprimes = 110 in
  let era = (Array.init_withenv maximumprimes (fun  j () -> let e = j in
  ((), e)) ()) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun  o () -> let f = 0 in
  ((), f)) ()) in
  let l = 0 in
  let w = 2 in
  let x = (maximumprimes - 1) in
  let rec v k l =
    (if (k <= x)
     then let l = (if (era.(k) = k)
                   then (
                          primes.(l) <- k;
                          let l = (l + 1) in
                          l
                          )
                   
                   else l) in
     (v (k + 1) l)
     else let s = 1 in
     let u = 10000 in
     let rec g n =
       (if (n <= u)
        then let c = (n + 2) in
        let primesFactors = (Array.init_withenv c (fun  m () -> let h = 0 in
        ((), h)) ()) in
        let max_ = (max2 (fillPrimesFactors primesFactors n primes nprimes) (fillPrimesFactors primesFactors (n + 1) primes nprimes)) in
        (
          primesFactors.(2) <- (primesFactors.(2) - 1);
          let ndivs = 1 in
          let q = 0 in
          let r = max_ in
          let rec p i ndivs =
            (if (i <= r)
             then let ndivs = (if (primesFactors.(i) <> 0)
                               then let ndivs = (ndivs * (1 + primesFactors.(i))) in
                               ndivs
                               else ndivs) in
             (p (i + 1) ndivs)
             else (if (ndivs > ndiv2)
                   then ((n * (n + 1)) / 2)
                   else (*  print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n"  *)
                   (g (n + 1)))) in
            (p q ndivs)
          )
        
        else 0) in
       (g s)) in
    (v w l)
let main =
  (
    (Printf.printf "%d" (find 500));
    (Printf.printf "%s" "\n");
    ()
    )
  

