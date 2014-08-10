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
           ((fun f g ->
                let rec a i n t max_ =
                  (if (i <= g)
                   then ((fun b ->
                             (if (t.(i) = i)
                              then ((fun n ->
                                        ((fun j ->
                                             ((fun c ->
                                                  (if ((j / i) = i)
                                                   then (*  overflow test  *)
                                                   let rec e j n t max_ =
                                                     (if ((j < max_) && (j > 0))
                                                      then (t.(j) <- 0; ((fun
                                                       j ->
                                                      (e j n t max_)) (j + i)))
                                                      else (c j n t max_)) in
                                                     (e j n t max_)
                                                   else (c j n t max_))) (fun
                                              j n t max_ ->
                                             (b n t max_)))) (i * i))) (n + 1))
                              else (b n t max_))) (fun n t max_ ->
                                                      (a (i + 1) n t max_)))
                   else n) in
                  (a f n t max_)) 2 (max_ - 1))) 0));;
let rec main =
  ((fun maximumprimes ->
       ((fun era ->
            ((fun nprimes ->
                 ((fun primes ->
                      ((fun l ->
                           ((fun bf bg ->
                                let rec bd k l nprimes maximumprimes =
                                  (if (k <= bg)
                                   then ((fun be ->
                                             (if (era.(k) = k)
                                              then (primes.(l) <- k; ((fun
                                               l ->
                                              (be l nprimes maximumprimes)) (l + 1)))
                                              else (be l nprimes maximumprimes))) (fun
                                    l nprimes maximumprimes ->
                                   (bd (k + 1) l nprimes maximumprimes)))
                                   else (Printf.printf "%d" l;
                                   (Printf.printf "%s" " == ";
                                   (Printf.printf "%d" nprimes;
                                   (Printf.printf "%s" "\n";
                                   ((fun canbe ->
                                        ((fun bb bc ->
                                             let rec w i l nprimes maximumprimes =
                                               (if (i <= bc)
                                                then ((fun z ba ->
                                                          let rec x j l nprimes maximumprimes =
                                                            (if (j <= ba)
                                                             then ((fun
                                                              n ->
                                                             ((fun y ->
                                                                  (if (n < maximumprimes)
                                                                   then (canbe.(n) <- true; (y n l nprimes maximumprimes))
                                                                   else (y n l nprimes maximumprimes))) (fun
                                                              n l nprimes maximumprimes ->
                                                             (x (j + 1) l nprimes maximumprimes)))) (primes.(i) + ((2 * j) * j)))
                                                             else (w (i + 1) l nprimes maximumprimes)) in
                                                            (x z l nprimes maximumprimes)) 0 (maximumprimes - 1))
                                                else ((fun u v ->
                                                          let rec r m l nprimes maximumprimes =
                                                            (if (m <= v)
                                                             then ((fun
                                                              m2 ->
                                                             ((fun s ->
                                                                  (if ((m2 < maximumprimes) && (not canbe.(m2)))
                                                                   then (Printf.printf "%d" m2;
                                                                   (Printf.printf "%s" "\n";
                                                                   (s m2 l nprimes maximumprimes)))
                                                                   else (s m2 l nprimes maximumprimes))) (fun
                                                              m2 l nprimes maximumprimes ->
                                                             (r (m + 1) l nprimes maximumprimes)))) ((m * 2) + 1))
                                                             else ()) in
                                                            (r u l nprimes maximumprimes)) 1 maximumprimes)) in
                                               (w bb l nprimes maximumprimes)) 0 (nprimes - 1))) ((Array.init_withenv maximumprimes (fun
                                    i_ ->
                                   (fun (l, nprimes, maximumprimes) ->
                                       ((fun q ->
                                            ((l, nprimes, maximumprimes), q)) false))) ) (l, nprimes, maximumprimes)))))))) in
                                  (bd bf l nprimes maximumprimes)) 2 (maximumprimes - 1))) 0)) ((Array.init_withenv nprimes (fun
                  o ->
                 (fun (nprimes, maximumprimes) ->
                     ((fun p ->
                          ((nprimes, maximumprimes), p)) 0))) ) (nprimes, maximumprimes)))) (eratostene era maximumprimes))) ((Array.init_withenv maximumprimes (fun
        j_ ->
       (fun (maximumprimes) ->
           ((fun h ->
                ((maximumprimes), h)) j_))) ) (maximumprimes)))) 6000);;

