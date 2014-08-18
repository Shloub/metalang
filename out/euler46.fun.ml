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

let eratostene =
  (fun t max_ ->
      let n = 0 in
      let d = 2 in
      let e = (max_ - 1) in
      let rec a i n =
        (if (i <= e)
         then let n = (if (t.(i) = i)
                       then let n = (n + 1) in
                       let j = (i * i) in
                       let j = (if ((j / i) = i)
                                then (*  overflow test  *)
                                let rec c j =
                                  (if ((j < max_) && (j > 0))
                                   then (
                                          t.(j) <- 0;
                                          let j = (j + i) in
                                          (c j)
                                          )
                                   
                                   else j) in
                                  (c j)
                                else j) in
                       n
                       else n) in
         (a (i + 1) n)
         else n) in
        (a d n));;
let main =
  let maximumprimes = 6000 in
  let era = (Array.init_withenv maximumprimes (fun j_ ->
                                                  (fun () -> let f = j_ in
                                                  ((), f))) ()) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun o ->
                                               (fun () -> let g = 0 in
                                               ((), g))) ()) in
  let l = 0 in
  let ba = 2 in
  let bb = (maximumprimes - 1) in
  let rec z k l =
    (if (k <= bb)
     then let l = (if (era.(k) = k)
                   then (
                          primes.(l) <- k;
                          let l = (l + 1) in
                          l
                          )
                   
                   else l) in
     (z (k + 1) l)
     else (
            (Printf.printf "%d" l);
            (Printf.printf "%s" " == ");
            (Printf.printf "%d" nprimes);
            (Printf.printf "%s" "\n");
            let canbe = (Array.init_withenv maximumprimes (fun i_ ->
                                                              (fun () -> let h = false in
                                                              ((), h))) ()) in
            let x = 0 in
            let y = (nprimes - 1) in
            let rec s i =
              (if (i <= y)
               then let v = 0 in
               let w = (maximumprimes - 1) in
               let rec u j =
                 (if (j <= w)
                  then let n = (primes.(i) + ((2 * j) * j)) in
                  (
                    (if (n < maximumprimes)
                     then (
                            canbe.(n) <- true;
                            ()
                            )
                     
                     else ());
                    (u (j + 1))
                    )
                  
                  else (s (i + 1))) in
                 (u v)
               else let q = 1 in
               let r = maximumprimes in
               let rec p m =
                 (if (m <= r)
                  then let m2 = ((m * 2) + 1) in
                  (
                    (if ((m2 < maximumprimes) && (not canbe.(m2)))
                     then (
                            (Printf.printf "%d" m2);
                            (Printf.printf "%s" "\n")
                            )
                     
                     else ());
                    (p (m + 1))
                    )
                  
                  else ()) in
                 (p q)) in
              (s x)
            )
     ) in
    (z ba l);;

