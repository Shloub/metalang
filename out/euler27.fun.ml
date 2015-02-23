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
  let m = 2 in
  let p = (max0 - 1) in
  let rec g i n =
    (if (i <= p)
     then let n = (if (t.(i) = i)
                   then let n = (n + 1) in
                   let j = (i * i) in
                   let rec h j =
                     (if ((j < max0) && (j > 0))
                      then (
                             t.(j) <- 0;
                             let j = (j + i) in
                             (h j)
                             )
                      
                      else n) in
                     (h j)
                   else n) in
     (g (i + 1) n)
     else n) in
    (g m n)
let isPrime n primes len =
  let i = 0 in
  let n = (if (n < 0)
           then let n = (- n) in
           n
           else n) in
  let rec f i =
    (if ((primes.(i) * primes.(i)) < n)
     then (if ((n mod primes.(i)) = 0)
           then false
           else let i = (i + 1) in
           (f i))
     else true) in
    (f i)
let test a b primes len =
  let d = 0 in
  let e = 200 in
  let rec c n =
    (if (n <= e)
     then let j = (((n * n) + (a * n)) + b) in
     (if (not (isPrime j primes len))
      then n
      else (c (n + 1)))
     else 200) in
    (c d)
let main =
  let maximumprimes = 1000 in
  ((fun  (r, era) -> (
                       r;
                       let result = 0 in
                       let max0 = 0 in
                       let nprimes = (eratostene era maximumprimes) in
                       ((fun  (u, primes) -> (
                                               u;
                                               let l = 0 in
                                               let bc = 2 in
                                               let bd = (maximumprimes - 1) in
                                               let rec bb k l =
                                                 (if (k <= bd)
                                                  then let l = (if (era.(k) = k)
                                                                then (
                                                                       primes.(l) <- k;
                                                                       let l = (l + 1) in
                                                                       l
                                                                       )
                                                                
                                                                else l) in
                                                  (bb (k + 1) l)
                                                  else (
                                                         (Printf.printf "%d == %d\n" l nprimes);
                                                         let ma = 0 in
                                                         let mb = 0 in
                                                         let z = 3 in
                                                         let ba = 999 in
                                                         let rec v b ma max0 mb result =
                                                           (if (b <= ba)
                                                            then ((fun  (ma, max0, mb, result) -> (v (b + 1) ma max0 mb result)) (
                                                            if (era.(b) = b)
                                                            then let x = (- 999) in
                                                            let y = 999 in
                                                            let rec w a ma max0 mb result =
                                                              (if (a <= y)
                                                               then let n1 = (test a b primes nprimes) in
                                                               let n2 = (test a (- b) primes nprimes) in
                                                               ((fun  (ma, max0, mb, result) -> ((fun  (ma, max0, mb, result) -> (w (a + 1) ma max0 mb result)) (
                                                               if (n2 > max0)
                                                               then let max0 = n2 in
                                                               let result = ((- a) * b) in
                                                               let ma = a in
                                                               let mb = (- b) in
                                                               (ma, max0, mb, result)
                                                               else (ma, max0, mb, result)))) (
                                                               if (n1 > max0)
                                                               then let max0 = n1 in
                                                               let result = (a * b) in
                                                               let ma = a in
                                                               let mb = b in
                                                               (ma, max0, mb, result)
                                                               else (ma, max0, mb, result)))
                                                               else (ma, max0, mb, result)) in
                                                              (w x ma max0 mb result)
                                                            else (ma, max0, mb, result)))
                                                            else (
                                                                   (Printf.printf "%d %d\n%d\n%d\n" ma mb max0 result)
                                                                   )
                                                            ) in
                                                           (v z ma max0 mb result)
                                                         )
                                                  ) in
                                                 (bb bc l)
                                               )
                       ) (Array.init_withenv nprimes (fun  o () -> let s = 0 in
                       ((), s)) ()))
                       )
  ) (Array.init_withenv maximumprimes (fun  j () -> let q = j in
  ((), q)) ()))

