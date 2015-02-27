let eratostene t max0 =
  let n = 0 in
  let e = (max0 - 1) in
  let rec c i n =
    (if (i <= e)
     then (if (t.(i) = i)
           then let n = (n + 1) in
           (if ((max0 / i) > i)
            then let j = (i * i) in
            let rec d j =
              (if ((j < max0) && (j > 0))
               then (
                      t.(j) <- 0;
                      let j = (j + i) in
                      (d j)
                      )
               
               else (c (i + 1) n)) in
              (d j)
            else (c (i + 1) n))
           else (c (i + 1) n))
     else n) in
    (c 2 n)
let main =
  let maximumprimes = 1000001 in
  let era = (Array.init maximumprimes (fun  j -> j)) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init nprimes (fun  o -> 0)) in
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
            let sum = (Array.init nprimes (fun  i_ -> primes.(i_))) in
            let maxl = 0 in
            let process = true in
            let stop = (maximumprimes - 1) in
            let len = 1 in
            let resp = 1 in
            let rec r len maxl process resp stop =
              (if process
               then let process = false in
               let rec s i maxl process resp stop =
                 (if (i <= stop)
                  then (if ((i + len) < nprimes)
                        then (
                               sum.(i) <- (sum.(i) + primes.((i + len)));
                               (if (maximumprimes > sum.(i))
                                then let process = true in
                                (if (era.(sum.(i)) = sum.(i))
                                 then let maxl = len in
                                 let resp = sum.(i) in
                                 (s (i + 1) maxl process resp stop)
                                 else (s (i + 1) maxl process resp stop))
                                else let stop = ((min (stop) (i))) in
                                (s (i + 1) maxl process resp stop))
                               )
                        
                        else (s (i + 1) maxl process resp stop))
                  else let len = (len + 1) in
                  (r len maxl process resp stop)) in
                 (s 0 maxl process resp stop)
               else (
                      (Printf.printf "%d\n%d\n" resp maxl)
                      )
               ) in
              (r len maxl process resp stop)
            )
     ) in
    (u 2 l)

