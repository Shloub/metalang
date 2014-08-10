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
      ((fun bn ->
           (if (a > b)
            then a
            else b)) (fun a b ->
                         ())));;
let rec eratostene =
  (fun t max_ ->
      ((fun n ->
           ((fun bl bm ->
                let rec bh i n t max_ =
                  (if (i <= bm)
                   then ((fun bi ->
                             (if (t.(i) = i)
                              then ((fun j ->
                                        ((fun n ->
                                             let rec bk j n t max_ =
                                               (if ((j < max_) && (j > 0))
                                                then (t.(j) <- 0; ((fun
                                                 j ->
                                                (bk j n t max_)) (j + i)))
                                                else (bi n t max_)) in
                                               (bk j n t max_)) (n + 1))) (i * i))
                              else (bi n t max_))) (fun n t max_ ->
                                                       (bh (i + 1) n t max_)))
                   else n) in
                  (bh bl n t max_)) 2 (max_ - 1))) 0));;
let rec fillPrimesFactors =
  (fun t n primes nprimes ->
      ((fun bf bg ->
           let rec bb i t n primes nprimes =
             (if (i <= bg)
              then ((fun d ->
                        let rec be d t n primes nprimes =
                          (if ((n mod d) = 0)
                           then (t.(d) <- (t.(d) + 1); ((fun n ->
                                                            (be d t n primes nprimes)) (n / d)))
                           else ((fun bc ->
                                     (if (n = 1)
                                      then primes.(i)
                                      else (bc d t n primes nprimes))) (fun
                            d t n primes nprimes ->
                           (bb (i + 1) t n primes nprimes)))) in
                          (be d t n primes nprimes)) primes.(i))
              else n) in
             (bb bf t n primes nprimes)) 0 (nprimes - 1)));;
let rec find =
  (fun ndiv2 ->
      ((fun maximumprimes ->
           ((fun era ->
                ((fun nprimes ->
                     ((fun primes ->
                          ((fun l ->
                               ((fun z ba ->
                                    let rec x k l nprimes maximumprimes ndiv2 =
                                      (if (k <= ba)
                                       then ((fun y ->
                                                 (if (era.(k) = k)
                                                  then (primes.(l) <- k; ((fun
                                                   l ->
                                                  (y l nprimes maximumprimes ndiv2)) (l + 1)))
                                                  else (y l nprimes maximumprimes ndiv2))) (fun
                                        l nprimes maximumprimes ndiv2 ->
                                       (x (k + 1) l nprimes maximumprimes ndiv2)))
                                       else ((fun v w ->
                                                 let rec g n l nprimes maximumprimes ndiv2 =
                                                   (if (n <= w)
                                                    then ((fun c ->
                                                              ((fun primesFactors ->
                                                                   ((fun
                                                                    max_ ->
                                                                   (primesFactors.(2) <- (primesFactors.(2) - 1); ((fun
                                                                    ndivs ->
                                                                   ((fun
                                                                    s u ->
                                                                   let rec q i ndivs max_ c l nprimes maximumprimes ndiv2 =
                                                                    (if (i <= u)
                                                                    then ((fun
                                                                     r ->
                                                                    (
                                                                    if (primesFactors.(i) <> 0)
                                                                    then ((fun
                                                                     ndivs ->
                                                                    (r ndivs max_ c l nprimes maximumprimes ndiv2)) (ndivs * (1 + primesFactors.(i))))
                                                                    else (r ndivs max_ c l nprimes maximumprimes ndiv2))) (fun
                                                                     ndivs max_ c l nprimes maximumprimes ndiv2 ->
                                                                    (q (i + 1) ndivs max_ c l nprimes maximumprimes ndiv2)))
                                                                    else ((fun
                                                                     p ->
                                                                    (
                                                                    if (ndivs > ndiv2)
                                                                    then ((n * (n + 1)) / 2)
                                                                    else (p ndivs max_ c l nprimes maximumprimes ndiv2))) (fun
                                                                     ndivs max_ c l nprimes maximumprimes ndiv2 ->
                                                                    (*  print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n"  *)
                                                                    (g (n + 1) l nprimes maximumprimes ndiv2)))) in
                                                                    (q s ndivs max_ c l nprimes maximumprimes ndiv2)) 0 max_)) 1))) (max2 (fillPrimesFactors primesFactors n primes nprimes) (fillPrimesFactors primesFactors (n + 1) primes nprimes)))) ((Array.init_withenv c (fun
                                                               m ->
                                                              (fun (c, l, nprimes, maximumprimes, ndiv2) ->
                                                                  ((fun
                                                                   h ->
                                                                  ((c, l, nprimes, maximumprimes, ndiv2), h)) 0))) ) (c, l, nprimes, maximumprimes, ndiv2)))) (n + 2))
                                                    else 0) in
                                                   (g v l nprimes maximumprimes ndiv2)) 1 10000)) in
                                      (x z l nprimes maximumprimes ndiv2)) 2 (maximumprimes - 1))) 0)) ((Array.init_withenv nprimes (fun
                      o ->
                     (fun (nprimes, maximumprimes, ndiv2) ->
                         ((fun f ->
                              ((nprimes, maximumprimes, ndiv2), f)) 0))) ) (nprimes, maximumprimes, ndiv2)))) (eratostene era maximumprimes))) ((Array.init_withenv maximumprimes (fun
            j ->
           (fun (maximumprimes, ndiv2) ->
               ((fun e ->
                    ((maximumprimes, ndiv2), e)) j))) ) (maximumprimes, ndiv2)))) 110));;
let rec main =
  (Printf.printf "%d" (find 500);
  (Printf.printf "%s" "\n";
  ()));;

