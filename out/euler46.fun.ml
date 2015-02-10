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
  let era = (Array.init_withenv maximumprimes (fun  j_ () -> let e = j_ in
  ((), e)) ()) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun  o () -> let f = 0 in
  ((), f)) ()) in
  let l = 0 in
  let z = 2 in
  let ba = (maximumprimes - 1) in
  let rec y k l =
    (if (k <= ba)
     then let l = (if (era.(k) = k)
                   then (
                          primes.(l) <- k;
                          let l = (l + 1) in
                          l
                          )
                   
                   else l) in
     (y (k + 1) l)
     else (
            (Printf.printf "%d == %d\n" l nprimes);
            let canbe = (Array.init_withenv maximumprimes (fun  i_ () -> let g = false in
            ((), g)) ()) in
            let w = 0 in
            let x = (nprimes - 1) in
            let rec r i =
              (if (i <= x)
               then let u = 0 in
               let v = (maximumprimes - 1) in
               let rec s j =
                 (if (j <= v)
                  then let n = (primes.(i) + ((2 * j) * j)) in
                  (
                    (if (n < maximumprimes)
                     then canbe.(n) <- true
                     else ());
                    (s (j + 1))
                    )
                  
                  else (r (i + 1))) in
                 (s u)
               else let p = 1 in
               let q = maximumprimes in
               let rec h m =
                 (if (m <= q)
                  then let m2 = ((m * 2) + 1) in
                  (
                    (if ((m2 < maximumprimes) && (not canbe.(m2)))
                     then (
                            (Printf.printf "%d\n" m2)
                            )
                     
                     else ());
                    (h (m + 1))
                    )
                  
                  else ()) in
                 (h p)) in
              (r w)
            )
     ) in
    (y z l)

