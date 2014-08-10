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
           ((fun v w ->
                let rec q i n t max_ =
                  (if (i <= w)
                   then ((fun r ->
                             (if (t.(i) = i)
                              then ((fun n ->
                                        ((fun j ->
                                             let rec u j n t max_ =
                                               (if ((j < max_) && (j > 0))
                                                then (t.(j) <- 0; ((fun
                                                 j ->
                                                (u j n t max_)) (j + i)))
                                                else (r n t max_)) in
                                               (u j n t max_)) (i * i))) (n + 1))
                              else (r n t max_))) (fun n t max_ ->
                                                      (q (i + 1) n t max_)))
                   else n) in
                  (q v n t max_)) 2 (max_ - 1))) 0));;
let rec isPrime =
  (fun n primes len ->
      ((fun i ->
           ((fun p ->
                (if (n < 0)
                 then ((fun n ->
                           (p i n primes len)) (- n))
                 else (p i n primes len))) (fun i n primes len ->
                                               let rec h i n primes len =
                                                 (if ((primes.(i) * primes.(i)) < n)
                                                  then ((fun m ->
                                                            (if ((n mod primes.(i)) = 0)
                                                             then false
                                                             else (m i n primes len))) (fun
                                                   i n primes len ->
                                                  ((fun i ->
                                                       (h i n primes len)) (i + 1))))
                                                  else true) in
                                                 (h i n primes len)))) 0));;
let rec test =
  (fun a b primes len ->
      ((fun e f ->
           let rec c n a b primes len =
             (if (n <= f)
              then ((fun j ->
                        ((fun d ->
                             (if (not (isPrime j primes len))
                              then n
                              else (d j a b primes len))) (fun j a b primes len ->
                                                              (c (n + 1) a b primes len)))) (((n * n) + (a * n)) + b))
              else 200) in
             (c e a b primes len)) 0 200));;
let rec main =
  ((fun maximumprimes ->
       ((fun era ->
            ((fun result ->
                 ((fun max_ ->
                      ((fun nprimes ->
                           ((fun primes ->
                                ((fun l ->
                                     ((fun bk bl ->
                                          let rec bi k l nprimes max_ result maximumprimes =
                                            (if (k <= bl)
                                             then ((fun bj ->
                                                       (if (era.(k) = k)
                                                        then (primes.(l) <- k; ((fun
                                                         l ->
                                                        (bj l nprimes max_ result maximumprimes)) (l + 1)))
                                                        else (bj l nprimes max_ result maximumprimes))) (fun
                                              l nprimes max_ result maximumprimes ->
                                             (bi (k + 1) l nprimes max_ result maximumprimes)))
                                             else (Printf.printf "%d" l;
                                             (Printf.printf "%s" " == ";
                                             (Printf.printf "%d" nprimes;
                                             (Printf.printf "%s" "\n";
                                             ((fun ma ->
                                                  ((fun mb ->
                                                       ((fun bg bh ->
                                                            let rec z b mb ma l nprimes max_ result maximumprimes =
                                                              (if (b <= bh)
                                                               then ((fun
                                                                ba ->
                                                               (if (era.(b) = b)
                                                                then ((fun
                                                                 be bf ->
                                                                let rec bb a mb ma l nprimes max_ result maximumprimes =
                                                                  (if (a <= bf)
                                                                   then ((fun
                                                                    n1 ->
                                                                   ((fun
                                                                    n2 ->
                                                                   ((fun
                                                                    bd ->
                                                                   (if (n1 > max_)
                                                                    then ((fun
                                                                     max_ ->
                                                                    ((fun
                                                                     result ->
                                                                    ((fun
                                                                     ma ->
                                                                    ((fun
                                                                     mb ->
                                                                    (bd n2 n1 mb ma l nprimes max_ result maximumprimes)) b)) a)) (a * b))) n1)
                                                                    else (bd n2 n1 mb ma l nprimes max_ result maximumprimes))) (fun
                                                                    n2 n1 mb ma l nprimes max_ result maximumprimes ->
                                                                   ((fun
                                                                    bc ->
                                                                   (if (n2 > max_)
                                                                    then ((fun
                                                                     max_ ->
                                                                    ((fun
                                                                     result ->
                                                                    ((fun
                                                                     ma ->
                                                                    ((fun
                                                                     mb ->
                                                                    (bc n2 n1 mb ma l nprimes max_ result maximumprimes)) (- b))) a)) ((- a) * b))) n2)
                                                                    else (bc n2 n1 mb ma l nprimes max_ result maximumprimes))) (fun
                                                                    n2 n1 mb ma l nprimes max_ result maximumprimes ->
                                                                   (bb (a + 1) mb ma l nprimes max_ result maximumprimes)))))) (test a (- b) primes nprimes))) (test a b primes nprimes))
                                                                   else (ba mb ma l nprimes max_ result maximumprimes)) in
                                                                  (bb be mb ma l nprimes max_ result maximumprimes)) (- 999) 999)
                                                                else (ba mb ma l nprimes max_ result maximumprimes))) (fun
                                                                mb ma l nprimes max_ result maximumprimes ->
                                                               (z (b + 1) mb ma l nprimes max_ result maximumprimes)))
                                                               else (Printf.printf "%d" ma;
                                                               (Printf.printf "%s" " ";
                                                               (Printf.printf "%d" mb;
                                                               (Printf.printf "%s" "\n";
                                                               (Printf.printf "%d" max_;
                                                               (Printf.printf "%s" "\n";
                                                               (Printf.printf "%d" result;
                                                               (Printf.printf "%s" "\n";
                                                               ()))))))))) in
                                                              (z bg mb ma l nprimes max_ result maximumprimes)) 3 999)) 0)) 0)))))) in
                                            (bi bk l nprimes max_ result maximumprimes)) 2 (maximumprimes - 1))) 0)) ((Array.init_withenv nprimes (fun
                            o ->
                           (fun (nprimes, max_, result, maximumprimes) ->
                               ((fun y ->
                                    ((nprimes, max_, result, maximumprimes), y)) 0))) ) (nprimes, max_, result, maximumprimes)))) (eratostene era maximumprimes))) 0)) 0)) ((Array.init_withenv maximumprimes (fun
        j ->
       (fun (maximumprimes) ->
           ((fun x ->
                ((maximumprimes), x)) j))) ) (maximumprimes)))) 1000);;

