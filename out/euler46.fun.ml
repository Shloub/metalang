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
  let c = 2 in
  let d = (max0 - 1) in
  let rec a i n =
    (if (i <= d)
     then let n = (if (t.(i) = i)
                   then let n = (n + 1) in
                   (
                     (if ((max0 / i) > i)
                      then let j = (i * i) in
                      let rec b j =
                        (if ((j < max0) && (j > 0))
                         then (
                                t.(j) <- 0;
                                let j = (j + i) in
                                (b j)
                                )
                         
                         else ()) in
                        (b j)
                      else ());
                     n
                     )
                   
                   else n) in
     (a (i + 1) n)
     else n) in
    (a c n)
let main =
  let maximumprimes = 6000 in
  ((fun  (f, era) -> (
                       f;
                       let nprimes = (eratostene era maximumprimes) in
                       ((fun  (h, primes) -> (
                                               h;
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
                                                         ((fun  (q, canbe) -> (
                                                                                q;
                                                                                let z = 0 in
                                                                                let ba = (nprimes - 1) in
                                                                                let rec v i =
                                                                                (if (i <= ba)
                                                                                then let x = 0 in
                                                                                let y = (maximumprimes - 1) in
                                                                                let rec w j =
                                                                                (if (j <= y)
                                                                                then let n = (primes.(i) + ((2 * j) * j)) in
                                                                                (
                                                                                (if (n < maximumprimes)
                                                                                then canbe.(n) <- true
                                                                                else ());
                                                                                (w (j + 1))
                                                                                )
                                                                                
                                                                                else (v (i + 1))) in
                                                                                (w x)
                                                                                else let s = 1 in
                                                                                let u = maximumprimes in
                                                                                let rec r m =
                                                                                (if (m <= u)
                                                                                then let m2 = ((m * 2) + 1) in
                                                                                (
                                                                                (if ((m2 < maximumprimes) && (not canbe.(m2)))
                                                                                then 
                                                                                (
                                                                                (Printf.printf "%d\n" m2)
                                                                                )
                                                                                
                                                                                else ());
                                                                                (r (m + 1))
                                                                                )
                                                                                
                                                                                else ()) in
                                                                                (r s)) in
                                                                                (v z)
                                                                                )
                                                         ) (Array.init_withenv maximumprimes (fun  i_ () -> let p = false in
                                                         ((), p)) ()))
                                                         )
                                                  ) in
                                                 (bb bc l)
                                               )
                       ) (Array.init_withenv nprimes (fun  o () -> let g = 0 in
                       ((), g)) ()))
                       )
  ) (Array.init_withenv maximumprimes (fun  j_ () -> let e = j_ in
  ((), e)) ()))

