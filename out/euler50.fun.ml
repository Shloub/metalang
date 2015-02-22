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
  ((fun  (h, era) -> (
                       h;
                       let nprimes = (eratostene era maximumprimes) in
                       ((fun  (p, primes) -> (
                                               p;
                                               let l = 0 in
                                               let y = 2 in
                                               let z = (maximumprimes - 1) in
                                               let rec x k l =
                                                 (if (k <= z)
                                                  then let l = (if (era.(k) = k)
                                                                then 
                                                                (
                                                                  primes.(l) <- k;
                                                                  let l = (l + 1) in
                                                                  l
                                                                  )
                                                                
                                                                else l) in
                                                  (x (k + 1) l)
                                                  else (
                                                         (Printf.printf "%d == %d\n" l nprimes);
                                                         ((fun  (r, sum) -> 
                                                         (
                                                           r;
                                                           let maxl = 0 in
                                                           let process = true in
                                                           let stop = (maximumprimes - 1) in
                                                           let len = 1 in
                                                           let resp = 1 in
                                                           let rec s len maxl process resp stop =
                                                             (if process
                                                              then let process = false in
                                                              let v = 0 in
                                                              let w = stop in
                                                              let rec u i maxl process resp stop =
                                                                (if (i <= w)
                                                                 then ((fun  (maxl, process, resp, stop) -> (u (i + 1) maxl process resp stop)) (
                                                                 if ((i + len) < nprimes)
                                                                 then 
                                                                 (
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
                                                                 (s len maxl process resp stop)) in
                                                                (u v maxl process resp stop)
                                                              else (
                                                                    (Printf.printf "%d\n%d\n" resp maxl)
                                                                    )
                                                              ) in
                                                             (s len maxl process resp stop)
                                                           )
                                                         ) (Array.init_withenv nprimes (fun  i_ () -> let q = primes.(i_) in
                                                         ((), q)) ()))
                                                         )
                                                  ) in
                                                 (x y l)
                                               )
                       ) (Array.init_withenv nprimes (fun  o () -> let m = 0 in
                       ((), m)) ()))
                       )
  ) (Array.init_withenv maximumprimes (fun  j () -> let g = j in
  ((), g)) ()))

