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
  let e = 2 in
  let f = (max0 - 1) in
  let rec c i n =
    (if (i <= f)
     then let n = (if (t.(i) = i)
                   then let n = (n + 1) in
                   (
                     (if ((max0 / i) > i)
                      then let j = (i * i) in
                      let rec d j =
                        (if ((j < max0) && (j > 0))
                         then (
                                t.(j) <- 0;
                                let j = (j + i) in
                                (d j)
                                )
                         
                         else ()) in
                        (d j)
                      else ());
                     n
                     )
                   
                   else n) in
     (c (i + 1) n)
     else n) in
    (c e n)
let main =
  let maximumprimes = 1000001 in
  let era = (Array.init_withenv maximumprimes (fun  j () -> let g = j in
  ((), g)) ()) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun  o () -> let h = 0 in
  ((), h)) ()) in
  let l = 0 in
  let v = 2 in
  let w = (maximumprimes - 1) in
  let rec u k l =
    (if (k <= w)
     then let l = (if (era.(k) = k)
                   then (
                          primes.(l) <- k;
                          let l = (l + 1) in
                          l
                          )
                   
                   else l) in
     (u (k + 1) l)
     else (
            (Printf.printf "%d == %d\n" l nprimes);
            let sum = (Array.init_withenv nprimes (fun  i_ () -> let m = primes.(i_) in
            ((), m)) ()) in
            let maxl = 0 in
            let process = true in
            let stop = (maximumprimes - 1) in
            let len = 1 in
            let resp = 1 in
            let rec p len maxl process resp stop =
              (if process
               then let process = false in
               let r = 0 in
               let s = stop in
               let rec q i maxl process resp stop =
                 (if (i <= s)
                  then ((fun  (maxl, process, resp, stop) -> (q (i + 1) maxl process resp stop)) (
                  if ((i + len) < nprimes)
                  then (
                         sum.(i) <- (sum.(i) + primes.((i + len)));
                         ((fun  (maxl, process, resp, stop) -> (maxl, process, resp, stop)) (
                         if (maximumprimes > sum.(i))
                         then let process = true in
                         ((fun  (maxl, resp) -> (maxl, process, resp, stop)) (
                         if (era.(sum.(i)) = sum.(i))
                         then let maxl = len in
                         let resp = sum.(i) in
                         (maxl, resp)
                         else (maxl, resp)))
                         else let stop = ((min (stop) (i))) in
                         (maxl, process, resp, stop)))
                         )
                  
                  else (maxl, process, resp, stop)))
                  else let len = (len + 1) in
                  (p len maxl process resp stop)) in
                 (q r maxl process resp stop)
               else (
                      (Printf.printf "%d\n%d\n" resp maxl)
                      )
               ) in
              (p len maxl process resp stop)
            )
     ) in
    (u v l)

