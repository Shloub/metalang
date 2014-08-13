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
      let n = 0 in
      let v = 2 in
      let w = (max_ - 1) in
      let rec q i n t max_ =
        (if (i <= w)
         then let r = (fun n t max_ ->
                          (q (i + 1) n t max_)) in
         (if (t.(i) = i)
          then let n = (n + 1) in
          let j = (i * i) in
          let rec u j n t max_ =
            (if ((j < max_) && (j > 0))
             then (t.(j) <- 0; let j = (j + i) in
             (u j n t max_))
             else (r n t max_)) in
            (u j n t max_)
          else (r n t max_))
         else n) in
        (q v n t max_));;
let rec isPrime =
  (fun n primes len ->
      let i = 0 in
      let p = (fun i n primes len ->
                  let rec h i n primes len =
                    (if ((primes.(i) * primes.(i)) < n)
                     then let m = (fun i n primes len ->
                                      let i = (i + 1) in
                                      (h i n primes len)) in
                     (if ((n mod primes.(i)) = 0)
                      then false
                      else (m i n primes len))
                     else true) in
                    (h i n primes len)) in
      (if (n < 0)
       then let n = (- n) in
       (p i n primes len)
       else (p i n primes len)));;
let rec test =
  (fun a b primes len ->
      let e = 0 in
      let f = 200 in
      let rec c n a b primes len =
        (if (n <= f)
         then let j = (((n * n) + (a * n)) + b) in
         let d = (fun j a b primes len ->
                     (c (n + 1) a b primes len)) in
         (if (not (isPrime j primes len))
          then n
          else (d j a b primes len))
         else 200) in
        (c e a b primes len));;
let rec main =
  let maximumprimes = 1000 in
  let era = (Array.init_withenv maximumprimes (fun j maximumprimes ->
                                                  let x = j in
                                                  (maximumprimes, x)) maximumprimes) in
  let result = 0 in
  let max_ = 0 in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun o ->
                                               (fun (nprimes, max_, result, maximumprimes) ->
                                                   let y = 0 in
                                                   ((nprimes, max_, result, maximumprimes), y))) (nprimes, max_, result, maximumprimes)) in
  let l = 0 in
  let bk = 2 in
  let bl = (maximumprimes - 1) in
  let rec bi k l nprimes max_ result maximumprimes =
    (if (k <= bl)
     then let bj = (fun l nprimes max_ result maximumprimes ->
                       (bi (k + 1) l nprimes max_ result maximumprimes)) in
     (if (era.(k) = k)
      then (primes.(l) <- k; let l = (l + 1) in
      (bj l nprimes max_ result maximumprimes))
      else (bj l nprimes max_ result maximumprimes))
     else begin
            (Printf.printf "%d" l);
            (Printf.printf "%s" " == ");
            (Printf.printf "%d" nprimes);
            (Printf.printf "%s" "\n");
            let ma = 0 in
            let mb = 0 in
            let bg = 3 in
            let bh = 999 in
            let rec z b mb ma l nprimes max_ result maximumprimes =
              (if (b <= bh)
               then let ba = (fun mb ma l nprimes max_ result maximumprimes ->
                                 (z (b + 1) mb ma l nprimes max_ result maximumprimes)) in
               (if (era.(b) = b)
                then let be = (- 999) in
                let bf = 999 in
                let rec bb a mb ma l nprimes max_ result maximumprimes =
                  (if (a <= bf)
                   then let n1 = (test a b primes nprimes) in
                   let n2 = (test a (- b) primes nprimes) in
                   let bd = (fun n2 n1 mb ma l nprimes max_ result maximumprimes ->
                                let bc = (fun n2 n1 mb ma l nprimes max_ result maximumprimes ->
                                             (bb (a + 1) mb ma l nprimes max_ result maximumprimes)) in
                                (if (n2 > max_)
                                 then let max_ = n2 in
                                 let result = ((- a) * b) in
                                 let ma = a in
                                 let mb = (- b) in
                                 (bc n2 n1 mb ma l nprimes max_ result maximumprimes)
                                 else (bc n2 n1 mb ma l nprimes max_ result maximumprimes))) in
                   (if (n1 > max_)
                    then let max_ = n1 in
                    let result = (a * b) in
                    let ma = a in
                    let mb = b in
                    (bd n2 n1 mb ma l nprimes max_ result maximumprimes)
                    else (bd n2 n1 mb ma l nprimes max_ result maximumprimes))
                   else (ba mb ma l nprimes max_ result maximumprimes)) in
                  (bb be mb ma l nprimes max_ result maximumprimes)
                else (ba mb ma l nprimes max_ result maximumprimes))
               else begin
                      (Printf.printf "%d" ma);
                      (Printf.printf "%s" " ");
                      (Printf.printf "%d" mb);
                      (Printf.printf "%s" "\n");
                      (Printf.printf "%d" max_);
                      (Printf.printf "%s" "\n");
                      (Printf.printf "%d" result);
                      (Printf.printf "%s" "\n")
                      end
               ) in
              (z bg mb ma l nprimes max_ result maximumprimes)
            end
     ) in
    (bi bk l nprimes max_ result maximumprimes);;

