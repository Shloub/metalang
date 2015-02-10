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
  let f = 2 in
  let g = (max0 - 1) in
  let rec d i n =
    (if (i <= g)
     then let n = (if (t.(i) = i)
                   then let n = (n + 1) in
                   (
                     (if ((max0 / i) > i)
                      then let j = (i * i) in
                      let rec e j =
                        (if ((j < max0) && (j > 0))
                         then (
                                t.(j) <- 0;
                                let j = (j + i) in
                                (e j)
                                )
                         
                         else ()) in
                        (e j)
                      else ());
                     n
                     )
                   
                   else n) in
     (d (i + 1) n)
     else n) in
    (d f n)
let main =
  let maximumprimes = 1000001 in
  let era = (Array.init_withenv maximumprimes (fun  j () -> let h = j in
  ((), h)) ()) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun  o () -> let m = 0 in
  ((), m)) ()) in
  let l = 0 in
  let w = 2 in
  let x = (maximumprimes - 1) in
  let rec v k l =
    (if (k <= x)
     then let l = (if (era.(k) = k)
                   then (
                          primes.(l) <- k;
                          let l = (l + 1) in
                          l
                          )
                   
                   else l) in
     (v (k + 1) l)
     else (
            (Printf.printf "%d == %d\n" l nprimes);
            let sum = (Array.init_withenv nprimes (fun  i_ () -> let p = primes.(i_) in
            ((), p)) ()) in
            let maxl = 0 in
            let process = true in
            let stop = (maximumprimes - 1) in
            let len = 1 in
            let resp = 1 in
            let rec q len maxl process resp stop =
              (if process
               then let process = false in
               let s = 0 in
               let u = stop in
               let rec r i maxl process resp stop =
                 (if (i <= u)
                  then ((fun  (maxl, process, resp, stop) -> (r (i + 1) maxl process resp stop)) (
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
                  (q len maxl process resp stop)) in
                 (r s maxl process resp stop)
               else (
                      (Printf.printf "%d\n%d\n" resp maxl)
                      )
               ) in
              (q len maxl process resp stop)
            )
     ) in
    (v w l)

