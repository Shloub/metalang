module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let eratostene t max0 =
  let n = 0 in
  let g = (max0 - 1) in
  let rec e i n =
    (if (i <= g)
     then (if (t.(i) = i)
           then let n = (n + 1) in
           let j = (i * i) in
           let rec f j =
             (if ((j < max0) && (j > 0))
              then (
                     t.(j) <- 0;
                     let j = (j + i) in
                     (f j)
                     )
              
              else (e (i + 1) n)) in
             (f j)
           else (e (i + 1) n))
     else n) in
    (e 2 n)
let isPrime n primes len =
  let i = 0 in
  let n = (if (n < 0)
           then let n = (- n) in
           n
           else n) in
  let rec d i =
    (if ((primes.(i) * primes.(i)) < n)
     then (if ((n mod primes.(i)) = 0)
           then false
           else let i = (i + 1) in
           (d i))
     else true) in
    (d i)
let test a b primes len =
  let rec c n =
    (if (n <= 200)
     then let j = (((n * n) + (a * n)) + b) in
     (if (not (isPrime j primes len))
      then n
      else (c (n + 1)))
     else 200) in
    (c 0)
let main =
  let maximumprimes = 1000 in
  ((fun  (m, era) -> (
                       m;
                       let result = 0 in
                       let max0 = 0 in
                       let nprimes = (eratostene era maximumprimes) in
                       ((fun  (q, primes) -> (
                                               q;
                                               let l = 0 in
                                               let v = (maximumprimes - 1) in
                                               let rec u k l =
                                                 (if (k <= v)
                                                  then (if (era.(k) = k)
                                                        then (
                                                               primes.(l) <- k;
                                                               let l = (l + 1) in
                                                               (u (k + 1) l)
                                                               )
                                                        
                                                        else (u (k + 1) l))
                                                  else (
                                                         (Printf.printf "%d == %d\n" l nprimes);
                                                         let ma = 0 in
                                                         let mb = 0 in
                                                         let rec r b ma max0 mb result =
                                                           (if (b <= 999)
                                                            then (if (era.(b) = b)
                                                                  then let rec s a ma max0 mb result =
                                                                         (if (a <= 999)
                                                                          then let n1 = (test a b primes nprimes) in
                                                                          let n2 = (test a (- b) primes nprimes) in
                                                                          ((fun  (ma, max0, mb, result) -> (
                                                                          if (n2 > max0)
                                                                          then let max0 = n2 in
                                                                          let result = ((- a) * b) in
                                                                          let ma = a in
                                                                          let mb = (- b) in
                                                                          (s (a + 1) ma max0 mb result)
                                                                          else (s (a + 1) ma max0 mb result))) (
                                                                          if (n1 > max0)
                                                                          then let max0 = n1 in
                                                                          let result = (a * b) in
                                                                          let ma = a in
                                                                          let mb = b in
                                                                          (ma, max0, mb, result)
                                                                          else (ma, max0, mb, result)))
                                                                          else (r (b + 1) ma max0 mb result)) in
                                                                         (s (- 999) ma max0 mb result)
                                                                  else (r (b + 1) ma max0 mb result))
                                                            else (
                                                                   (Printf.printf "%d %d\n%d\n%d\n" ma mb max0 result)
                                                                   )
                                                            ) in
                                                           (r 3 ma max0 mb result)
                                                         )
                                                  ) in
                                                 (u 2 l)
                                               )
                       ) (Array.init_withenv nprimes (fun  o () -> let p = 0 in
                       ((), p)) ()))
                       )
  ) (Array.init_withenv maximumprimes (fun  j () -> let h = j in
  ((), h)) ()))

