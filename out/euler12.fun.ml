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

let rec max2 =
  (fun a b ->
      let bn = (fun a b ->
                   ()) in
      (if (a > b)
       then a
       else b));;
let rec eratostene =
  (fun t max_ ->
      let n = 0 in
      let bl = 2 in
      let bm = (max_ - 1) in
      let rec bh i n t max_ =
        (if (i <= bm)
         then let bi = (fun n t max_ ->
                           (bh (i + 1) n t max_)) in
         (if (t.(i) = i)
          then let j = (i * i) in
          let n = (n + 1) in
          let rec bk j n t max_ =
            (if ((j < max_) && (j > 0))
             then (t.(j) <- 0; let j = (j + i) in
             (bk j n t max_))
             else (bi n t max_)) in
            (bk j n t max_)
          else (bi n t max_))
         else n) in
        (bh bl n t max_));;
let rec fillPrimesFactors =
  (fun t n primes nprimes ->
      let bf = 0 in
      let bg = (nprimes - 1) in
      let rec bb i t n primes nprimes =
        (if (i <= bg)
         then let d = primes.(i) in
         let rec be d t n primes nprimes =
           (if ((n mod d) = 0)
            then (t.(d) <- (t.(d) + 1); let n = (n / d) in
            (be d t n primes nprimes))
            else let bc = (fun d t n primes nprimes ->
                              (bb (i + 1) t n primes nprimes)) in
            (if (n = 1)
             then primes.(i)
             else (bc d t n primes nprimes))) in
           (be d t n primes nprimes)
         else n) in
        (bb bf t n primes nprimes));;
let rec find =
  (fun ndiv2 ->
      let maximumprimes = 110 in
      let era = (Array.init_withenv maximumprimes (fun j ->
                                                      (fun (maximumprimes, ndiv2) ->
                                                          let e = j in
                                                          ((maximumprimes, ndiv2), e))) (maximumprimes, ndiv2)) in
      let nprimes = (eratostene era maximumprimes) in
      let primes = (Array.init_withenv nprimes (fun o ->
                                                   (fun (nprimes, maximumprimes, ndiv2) ->
                                                       let f = 0 in
                                                       ((nprimes, maximumprimes, ndiv2), f))) (nprimes, maximumprimes, ndiv2)) in
      let l = 0 in
      let z = 2 in
      let ba = (maximumprimes - 1) in
      let rec x k l nprimes maximumprimes ndiv2 =
        (if (k <= ba)
         then let y = (fun l nprimes maximumprimes ndiv2 ->
                          (x (k + 1) l nprimes maximumprimes ndiv2)) in
         (if (era.(k) = k)
          then (primes.(l) <- k; let l = (l + 1) in
          (y l nprimes maximumprimes ndiv2))
          else (y l nprimes maximumprimes ndiv2))
         else let v = 1 in
         let w = 10000 in
         let rec g n l nprimes maximumprimes ndiv2 =
           (if (n <= w)
            then let c = (n + 2) in
            let primesFactors = (Array.init_withenv c (fun m ->
                                                          (fun (c, l, nprimes, maximumprimes, ndiv2) ->
                                                              let h = 0 in
                                                              ((c, l, nprimes, maximumprimes, ndiv2), h))) (c, l, nprimes, maximumprimes, ndiv2)) in
            let max_ = (max2 (fillPrimesFactors primesFactors n primes nprimes) (fillPrimesFactors primesFactors (n + 1) primes nprimes)) in
            (primesFactors.(2) <- (primesFactors.(2) - 1); let ndivs = 1 in
            let s = 0 in
            let u = max_ in
            let rec q i ndivs max_ c l nprimes maximumprimes ndiv2 =
              (if (i <= u)
               then let r = (fun ndivs max_ c l nprimes maximumprimes ndiv2 ->
                                (q (i + 1) ndivs max_ c l nprimes maximumprimes ndiv2)) in
               (if (primesFactors.(i) <> 0)
                then let ndivs = (ndivs * (1 + primesFactors.(i))) in
                (r ndivs max_ c l nprimes maximumprimes ndiv2)
                else (r ndivs max_ c l nprimes maximumprimes ndiv2))
               else let p = (fun ndivs max_ c l nprimes maximumprimes ndiv2 ->
                                (*  print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n"  *)
                                (g (n + 1) l nprimes maximumprimes ndiv2)) in
               (if (ndivs > ndiv2)
                then ((n * (n + 1)) / 2)
                else (p ndivs max_ c l nprimes maximumprimes ndiv2))) in
              (q s ndivs max_ c l nprimes maximumprimes ndiv2))
            else 0) in
           (g v l nprimes maximumprimes ndiv2)) in
        (x z l nprimes maximumprimes ndiv2));;
let rec main =
  begin
    (Printf.printf "%d" (find 500));
    (Printf.printf "%s" "\n");
    ()
    end
  ;;

