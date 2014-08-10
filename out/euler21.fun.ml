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

let rec eratostene =
  (fun t max_ ->
      ((fun n ->
           ((fun bc bd ->
                let rec y i n t max_ =
                  (if (i <= bd)
                   then ((fun z ->
                             (if (t.(i) = i)
                              then ((fun n ->
                                        ((fun j ->
                                             let rec bb j n t max_ =
                                               (if ((j < max_) && (j > 0))
                                                then (t.(j) <- 0; ((fun
                                                 j ->
                                                (bb j n t max_)) (j + i)))
                                                else (z n t max_)) in
                                               (bb j n t max_)) (i * i))) (n + 1))
                              else (z n t max_))) (fun n t max_ ->
                                                      (y (i + 1) n t max_)))
                   else n) in
                  (y bc n t max_)) 2 (max_ - 1))) 0));;
let rec fillPrimesFactors =
  (fun t n primes nprimes ->
      ((fun w x ->
           let rec r i t n primes nprimes =
             (if (i <= x)
              then ((fun d ->
                        let rec v d t n primes nprimes =
                          (if ((n mod d) = 0)
                           then (t.(d) <- (t.(d) + 1); ((fun n ->
                                                            (v d t n primes nprimes)) (n / d)))
                           else ((fun s ->
                                     (if (n = 1)
                                      then primes.(i)
                                      else (s d t n primes nprimes))) (fun
                            d t n primes nprimes ->
                           (r (i + 1) t n primes nprimes)))) in
                          (v d t n primes nprimes)) primes.(i))
              else n) in
             (r w t n primes nprimes)) 0 (nprimes - 1)));;
let rec sumdivaux2 =
  (fun t n i ->
      let rec q t n i =
        (if ((i < n) && (t.(i) = 0))
         then ((fun i ->
                   (q t n i)) (i + 1))
         else i) in
        (q t n i));;
let rec sumdivaux =
  (fun t n i ->
      ((fun c ->
           (if (i > n)
            then 1
            else ((fun e ->
                      (if (t.(i) = 0)
                       then (sumdivaux t n (sumdivaux2 t n (i + 1)))
                       else ((fun o ->
                                 ((fun out_ ->
                                      ((fun p ->
                                           ((fun g h ->
                                                let rec f j p out_ o t n i =
                                                  (if (j <= h)
                                                   then ((fun out_ ->
                                                             ((fun p ->
                                                                  (f (j + 1) p out_ o t n i)) (p * i))) (out_ + p))
                                                   else ((out_ + 1) * o)) in
                                                  (f g p out_ o t n i)) 1 t.(i))) i)) 0)) (sumdivaux t n (sumdivaux2 t n (i + 1)))))) (fun
             t n i ->
            (c t n i))))) (fun t n i ->
                              ())));;
let rec sumdiv =
  (fun nprimes primes n ->
      ((fun a ->
           ((fun t ->
                ((fun max_ ->
                     (sumdivaux t max_ 0)) (fillPrimesFactors t n primes nprimes))) ((Array.init_withenv a (fun
            i ->
           (fun (a, nprimes, primes, n) ->
               ((fun b ->
                    ((a, nprimes, primes, n), b)) 0))) ) (a, nprimes, primes, n)))) (n + 1)));;
let rec main =
  ((fun maximumprimes ->
       ((fun era ->
            ((fun nprimes ->
                 ((fun primes ->
                      ((fun l ->
                           ((fun bn bo ->
                                let rec bl k l nprimes maximumprimes =
                                  (if (k <= bo)
                                   then ((fun bm ->
                                             (if (era.(k) = k)
                                              then (primes.(l) <- k; ((fun
                                               l ->
                                              (bm l nprimes maximumprimes)) (l + 1)))
                                              else (bm l nprimes maximumprimes))) (fun
                                    l nprimes maximumprimes ->
                                   (bl (k + 1) l nprimes maximumprimes)))
                                   else (Printf.printf "%d" l;
                                   (Printf.printf "%s" " == ";
                                   (Printf.printf "%d" nprimes;
                                   (Printf.printf "%s" "\n";
                                   ((fun sum ->
                                        ((fun bj bk ->
                                             let rec bg n sum l nprimes maximumprimes =
                                               (if (n <= bk)
                                                then ((fun other ->
                                                          ((fun bh ->
                                                               (if (other > n)
                                                                then ((fun
                                                                 othersum ->
                                                                ((fun
                                                                 bi ->
                                                                (if (othersum = n)
                                                                 then (Printf.printf "%d" other;
                                                                 (Printf.printf "%s" " & ";
                                                                 (Printf.printf "%d" n;
                                                                 (Printf.printf "%s" "\n";
                                                                 ((fun
                                                                  sum ->
                                                                 (bi othersum other sum l nprimes maximumprimes)) (sum + (other + n)))))))
                                                                 else (bi othersum other sum l nprimes maximumprimes))) (fun
                                                                 othersum other sum l nprimes maximumprimes ->
                                                                (bh other sum l nprimes maximumprimes)))) ((sumdiv nprimes primes other) - other))
                                                                else (bh other sum l nprimes maximumprimes))) (fun
                                                           other sum l nprimes maximumprimes ->
                                                          (bg (n + 1) sum l nprimes maximumprimes)))) ((sumdiv nprimes primes n) - n))
                                                else (Printf.printf "%s" "\n";
                                                (Printf.printf "%d" sum;
                                                (Printf.printf "%s" "\n";
                                                ())))) in
                                               (bg bj sum l nprimes maximumprimes)) 2 1000)) 0)))))) in
                                  (bl bn l nprimes maximumprimes)) 2 (maximumprimes - 1))) 0)) ((Array.init_withenv nprimes (fun
                  o ->
                 (fun (nprimes, maximumprimes) ->
                     ((fun bf ->
                          ((nprimes, maximumprimes), bf)) 0))) ) (nprimes, maximumprimes)))) (eratostene era maximumprimes))) ((Array.init_withenv maximumprimes (fun
        j ->
       (fun (maximumprimes) ->
           ((fun be ->
                ((maximumprimes), be)) j))) ) (maximumprimes)))) 1001);;

