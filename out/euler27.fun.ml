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

let eratostene t max_ =
  let n = 0 in
  let q = 2 in
  let r = (max_ - 1) in
  let rec h i n =
    (if (i <= r)
     then let n = (if (t.(i) = i)
                   then let n = (n + 1) in
                   let j = (i * i) in
                   let rec p j =
                     (if ((j < max_) && (j > 0))
                      then (
                             t.(j) <- 0;
                             let j = (j + i) in
                             (p j)
                             )
                      
                      else n) in
                     (p j)
                   else n) in
     (h (i + 1) n)
     else n) in
    (h q n)
let isPrime n primes len =
  let i = 0 in
  let n = (if (n < 0)
           then let n = (- n) in
           n
           else n) in
  let rec g i =
    (if ((primes.(i) * primes.(i)) < n)
     then (if ((n mod primes.(i)) = 0)
           then false
           else let i = (i + 1) in
           (g i))
     else true) in
    (g i)
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
  let era = (Array.init_withenv maximumprimes (fun  j () -> let s = j in
  ((), s)) ()) in
  let result = 0 in
  let max_ = 0 in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun  o () -> let u = 0 in
  ((), u)) ()) in
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
            (Printf.printf "%d" l);
            (Printf.printf "%s" " == ");
            (Printf.printf "%d" nprimes);
            (Printf.printf "%s" "\n");
            let ma = 0 in
            let mb = 0 in
            let z = 3 in
            let ba = 999 in
            let rec v b ma max_ mb result =
              (if (b <= ba)
               then ((fun  (ma, max_, mb, result) -> (v (b + 1) ma max_ mb result)) (
               if (era.(b) = b)
               then let x = (- 999) in
               let y = 999 in
               let rec w a ma max_ mb result =
                 (if (a <= y)
                  then let n1 = (test a b primes nprimes) in
                  let n2 = (test a (- b) primes nprimes) in
                  ((fun  (ma, max_, mb, result) -> ((fun  (ma, max_, mb, result) -> (w (a + 1) ma max_ mb result)) (
                  if (n2 > max_)
                  then let max_ = n2 in
                  let result = ((- a) * b) in
                  let ma = a in
                  let mb = (- b) in
                  (ma, max_, mb, result)
                  else (ma, max_, mb, result)))) (if (n1 > max_)
                                                  then let max_ = n1 in
                                                  let result = (a * b) in
                                                  let ma = a in
                                                  let mb = b in
                                                  (ma, max_, mb, result)
                                                  else (ma, max_, mb, result)))
                  else (ma, max_, mb, result)) in
                 (w x ma max_ mb result)
               else (ma, max_, mb, result)))
               else (
                      (Printf.printf "%d" ma);
                      (Printf.printf "%s" " ");
                      (Printf.printf "%d" mb);
                      (Printf.printf "%s" "\n");
                      (Printf.printf "%d" max_);
                      (Printf.printf "%s" "\n");
                      (Printf.printf "%d" result);
                      (Printf.printf "%s" "\n")
                      )
               ) in
              (v z ma max_ mb result)
            )
     ) in
    (bb bc l)

