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

let rec min2 =
  (fun a b ->
      ((fun p ->
           (if (a < b)
            then a
            else b)) (fun a b ->
                         ())));;
let rec eratostene =
  (fun t max_ ->
      ((fun n ->
           ((fun h m ->
                let rec c i n t max_ =
                  (if (i <= m)
                   then ((fun d ->
                             (if (t.(i) = i)
                              then ((fun n ->
                                        ((fun j ->
                                             ((fun e ->
                                                  (if ((j / i) = i)
                                                   then (*  overflow test  *)
                                                   let rec g j n t max_ =
                                                     (if ((j < max_) && (j > 0))
                                                      then (t.(j) <- 0; ((fun
                                                       j ->
                                                      (g j n t max_)) (j + i)))
                                                      else (e j n t max_)) in
                                                     (g j n t max_)
                                                   else (e j n t max_))) (fun
                                              j n t max_ ->
                                             (d n t max_)))) (i * i))) (n + 1))
                              else (d n t max_))) (fun n t max_ ->
                                                      (c (i + 1) n t max_)))
                   else n) in
                  (c h n t max_)) 2 (max_ - 1))) 0));;
let rec main =
  ((fun maximumprimes ->
       ((fun era ->
            ((fun nprimes ->
                 ((fun primes ->
                      ((fun l ->
                           ((fun be bf ->
                                let rec bc k l nprimes maximumprimes =
                                  (if (k <= bf)
                                   then ((fun bd ->
                                             (if (era.(k) = k)
                                              then (primes.(l) <- k; ((fun
                                               l ->
                                              (bd l nprimes maximumprimes)) (l + 1)))
                                              else (bd l nprimes maximumprimes))) (fun
                                    l nprimes maximumprimes ->
                                   (bc (k + 1) l nprimes maximumprimes)))
                                   else (Printf.printf "%d" l;
                                   (Printf.printf "%s" " == ";
                                   (Printf.printf "%d" nprimes;
                                   (Printf.printf "%s" "\n";
                                   ((fun sum ->
                                        ((fun maxl ->
                                             ((fun process ->
                                                  ((fun stop ->
                                                       ((fun len ->
                                                            ((fun resp ->
                                                                 let rec v resp len stop process maxl l nprimes maximumprimes =
                                                                   (if process
                                                                    then ((fun
                                                                     process ->
                                                                    ((fun
                                                                     ba bb ->
                                                                    let rec w i resp len stop process maxl l nprimes maximumprimes =
                                                                    (if (i <= bb)
                                                                    then ((fun
                                                                     x ->
                                                                    (
                                                                    if ((i + len) < nprimes)
                                                                    then (sum.(i) <- (sum.(i) + primes.((i + len))); ((fun
                                                                     y ->
                                                                    (
                                                                    if (maximumprimes > sum.(i))
                                                                    then ((fun
                                                                     process ->
                                                                    ((fun
                                                                     z ->
                                                                    (
                                                                    if (era.(sum.(i)) = sum.(i))
                                                                    then ((fun
                                                                     maxl ->
                                                                    ((fun
                                                                     resp ->
                                                                    (z resp len stop process maxl l nprimes maximumprimes)) sum.(i))) len)
                                                                    else (z resp len stop process maxl l nprimes maximumprimes))) (fun
                                                                     resp len stop process maxl l nprimes maximumprimes ->
                                                                    (y resp len stop process maxl l nprimes maximumprimes)))) true)
                                                                    else ((fun
                                                                     stop ->
                                                                    (y resp len stop process maxl l nprimes maximumprimes)) (min2 stop i)))) (fun
                                                                     resp len stop process maxl l nprimes maximumprimes ->
                                                                    (x resp len stop process maxl l nprimes maximumprimes))))
                                                                    else (x resp len stop process maxl l nprimes maximumprimes))) (fun
                                                                     resp len stop process maxl l nprimes maximumprimes ->
                                                                    (w (i + 1) resp len stop process maxl l nprimes maximumprimes)))
                                                                    else ((fun
                                                                     len ->
                                                                    (v resp len stop process maxl l nprimes maximumprimes)) (len + 1))) in
                                                                    (w ba resp len stop process maxl l nprimes maximumprimes)) 0 stop)) false)
                                                                    else (Printf.printf "%d" resp;
                                                                    (Printf.printf "%s" "\n";
                                                                    (Printf.printf "%d" maxl;
                                                                    (Printf.printf "%s" "\n";
                                                                    ()))))) in
                                                                   (v resp len stop process maxl l nprimes maximumprimes)) 1)) 1)) (maximumprimes - 1))) true)) 0)) ((Array.init_withenv nprimes (fun
                                    i_ ->
                                   (fun (l, nprimes, maximumprimes) ->
                                       ((fun s ->
                                            ((l, nprimes, maximumprimes), s)) primes.(i_)))) ) (l, nprimes, maximumprimes)))))))) in
                                  (bc be l nprimes maximumprimes)) 2 (maximumprimes - 1))) 0)) ((Array.init_withenv nprimes (fun
                  o ->
                 (fun (nprimes, maximumprimes) ->
                     ((fun r ->
                          ((nprimes, maximumprimes), r)) 0))) ) (nprimes, maximumprimes)))) (eratostene era maximumprimes))) ((Array.init_withenv maximumprimes (fun
        j ->
       (fun (maximumprimes) ->
           ((fun q ->
                ((maximumprimes), q)) j))) ) (maximumprimes)))) 1000001);;

