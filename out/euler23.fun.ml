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
           ((fun bh bi ->
                let rec bd i n t max_ =
                  (if (i <= bi)
                   then ((fun be ->
                             (if (t.(i) = i)
                              then ((fun n ->
                                        ((fun j ->
                                             let rec bg j n t max_ =
                                               (if ((j < max_) && (j > 0))
                                                then (t.(j) <- 0; ((fun
                                                 j ->
                                                (bg j n t max_)) (j + i)))
                                                else (be n t max_)) in
                                               (bg j n t max_)) (i * i))) (n + 1))
                              else (be n t max_))) (fun n t max_ ->
                                                       (bd (i + 1) n t max_)))
                   else n) in
                  (bd bh n t max_)) 2 (max_ - 1))) 0));;
let rec fillPrimesFactors =
  (fun t n primes nprimes ->
      ((fun bb bc ->
           let rec x i t n primes nprimes =
             (if (i <= bc)
              then ((fun d ->
                        let rec ba d t n primes nprimes =
                          (if ((n mod d) = 0)
                           then (t.(d) <- (t.(d) + 1); ((fun n ->
                                                            (ba d t n primes nprimes)) (n / d)))
                           else ((fun y ->
                                     (if (n = 1)
                                      then primes.(i)
                                      else (y d t n primes nprimes))) (fun
                            d t n primes nprimes ->
                           (x (i + 1) t n primes nprimes)))) in
                          (ba d t n primes nprimes)) primes.(i))
              else n) in
             (x bb t n primes nprimes)) 0 (nprimes - 1)));;
let rec sumdivaux2 =
  (fun t n i ->
      let rec w t n i =
        (if ((i < n) && (t.(i) = 0))
         then ((fun i ->
                   (w t n i)) (i + 1))
         else i) in
        (w t n i));;
let rec sumdivaux =
  (fun t n i ->
      ((fun f ->
           (if (i > n)
            then 1
            else ((fun g ->
                      (if (t.(i) = 0)
                       then (sumdivaux t n (sumdivaux2 t n (i + 1)))
                       else ((fun o ->
                                 ((fun out_ ->
                                      ((fun p ->
                                           ((fun m u ->
                                                let rec h j p out_ o t n i =
                                                  (if (j <= u)
                                                   then ((fun out_ ->
                                                             ((fun p ->
                                                                  (h (j + 1) p out_ o t n i)) (p * i))) (out_ + p))
                                                   else ((out_ + 1) * o)) in
                                                  (h m p out_ o t n i)) 1 t.(i))) i)) 0)) (sumdivaux t n (sumdivaux2 t n (i + 1)))))) (fun
             t n i ->
            (f t n i))))) (fun t n i ->
                              ())));;
let rec sumdiv =
  (fun nprimes primes n ->
      ((fun a ->
           ((fun t ->
                ((fun max_ ->
                     (sumdivaux t max_ 0)) (fillPrimesFactors t n primes nprimes))) ((Array.init_withenv a (fun
            i ->
           (fun (a, nprimes, primes, n) ->
               ((fun e ->
                    ((a, nprimes, primes, n), e)) 0))) ) (a, nprimes, primes, n)))) (n + 1)));;
let rec main =
  ((fun maximumprimes ->
       ((fun era ->
            ((fun nprimes ->
                 ((fun primes ->
                      ((fun l ->
                           ((fun ce cf ->
                                let rec cc k l nprimes maximumprimes =
                                  (if (k <= cf)
                                   then ((fun cd ->
                                             (if (era.(k) = k)
                                              then (primes.(l) <- k; ((fun
                                               l ->
                                              (cd l nprimes maximumprimes)) (l + 1)))
                                              else (cd l nprimes maximumprimes))) (fun
                                    l nprimes maximumprimes ->
                                   (cc (k + 1) l nprimes maximumprimes)))
                                   else ((fun n ->
                                             (*  28124 ça prend trop de temps mais on arrive a passer le test  *)
                                             ((fun b ->
                                                  ((fun abondant ->
                                                       ((fun c ->
                                                            ((fun summable ->
                                                                 ((fun
                                                                  sum ->
                                                                 ((fun
                                                                  ca cb ->
                                                                 let rec by r sum c b n l nprimes maximumprimes =
                                                                   (if (r <= cb)
                                                                    then ((fun
                                                                     other ->
                                                                    ((fun
                                                                     bz ->
                                                                    (
                                                                    if (other > r)
                                                                    then (abondant.(r) <- true; (bz other sum c b n l nprimes maximumprimes))
                                                                    else (bz other sum c b n l nprimes maximumprimes))) (fun
                                                                     other sum c b n l nprimes maximumprimes ->
                                                                    (by (r + 1) sum c b n l nprimes maximumprimes)))) ((sumdiv nprimes primes r) - r))
                                                                    else ((fun
                                                                     bw bx ->
                                                                    let rec br i sum c b n l nprimes maximumprimes =
                                                                    (if (i <= bx)
                                                                    then ((fun
                                                                     bu bv ->
                                                                    let rec bs j sum c b n l nprimes maximumprimes =
                                                                    (if (j <= bv)
                                                                    then ((fun
                                                                     bt ->
                                                                    (
                                                                    if ((abondant.(i) && abondant.(j)) && ((i + j) <= n))
                                                                    then (summable.((i + j)) <- true; (bt sum c b n l nprimes maximumprimes))
                                                                    else (bt sum c b n l nprimes maximumprimes))) (fun
                                                                     sum c b n l nprimes maximumprimes ->
                                                                    (bs (j + 1) sum c b n l nprimes maximumprimes)))
                                                                    else (br (i + 1) sum c b n l nprimes maximumprimes)) in
                                                                    (bs bu sum c b n l nprimes maximumprimes)) 1 n)
                                                                    else ((fun
                                                                     bp bq ->
                                                                    let rec bn o sum c b n l nprimes maximumprimes =
                                                                    (if (o <= bq)
                                                                    then ((fun
                                                                     bo ->
                                                                    (
                                                                    if (not summable.(o))
                                                                    then ((fun
                                                                     sum ->
                                                                    (bo sum c b n l nprimes maximumprimes)) (sum + o))
                                                                    else (bo sum c b n l nprimes maximumprimes))) (fun
                                                                     sum c b n l nprimes maximumprimes ->
                                                                    (bn (o + 1) sum c b n l nprimes maximumprimes)))
                                                                    else (Printf.printf "%s" "\n";
                                                                    (Printf.printf "%d" sum;
                                                                    (Printf.printf "%s" "\n";
                                                                    ())))) in
                                                                    (bn bp sum c b n l nprimes maximumprimes)) 1 n)) in
                                                                    (br bw sum c b n l nprimes maximumprimes)) 1 n)) in
                                                                   (by ca sum c b n l nprimes maximumprimes)) 2 n)) 0)) ((Array.init_withenv c (fun
                                                             q ->
                                                            (fun (c, b, n, l, nprimes, maximumprimes) ->
                                                                ((fun
                                                                 bm ->
                                                                ((c, b, n, l, nprimes, maximumprimes), bm)) false))) ) (c, b, n, l, nprimes, maximumprimes)))) (n + 1))) ((Array.init_withenv b (fun
                                                   p ->
                                                  (fun (b, n, l, nprimes, maximumprimes) ->
                                                      ((fun bl ->
                                                           ((b, n, l, nprimes, maximumprimes), bl)) false))) ) (b, n, l, nprimes, maximumprimes)))) (n + 1))) 100)) in
                                  (cc ce l nprimes maximumprimes)) 2 (maximumprimes - 1))) 0)) ((Array.init_withenv nprimes (fun
                  t ->
                 (fun (nprimes, maximumprimes) ->
                     ((fun bk ->
                          ((nprimes, maximumprimes), bk)) 0))) ) (nprimes, maximumprimes)))) (eratostene era maximumprimes))) ((Array.init_withenv maximumprimes (fun
        s ->
       (fun (maximumprimes) ->
           ((fun bj ->
                ((maximumprimes), bj)) s))) ) (maximumprimes)))) 30001);;

