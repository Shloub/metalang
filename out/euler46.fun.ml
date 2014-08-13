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
      let f = 2 in
      let g = (max_ - 1) in
      let rec a i n t max_ =
        (if (i <= g)
         then let b = (fun n t max_ ->
                          (a (i + 1) n t max_)) in
         (if (t.(i) = i)
          then let n = (n + 1) in
          let j = (i * i) in
          let c = (fun j n t max_ ->
                      (b n t max_)) in
          (if ((j / i) = i)
           then (*  overflow test  *)
           let rec e j n t max_ =
             (if ((j < max_) && (j > 0))
              then (t.(j) <- 0; let j = (j + i) in
              (e j n t max_))
              else (c j n t max_)) in
             (e j n t max_)
           else (c j n t max_))
          else (b n t max_))
         else n) in
        (a f n t max_));;
let rec main =
  let maximumprimes = 6000 in
  let era = (Array.init_withenv maximumprimes (fun j_ maximumprimes ->
                                                  let h = j_ in
                                                  (maximumprimes, h)) maximumprimes) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun o ->
                                               (fun (nprimes, maximumprimes) ->
                                                   let p = 0 in
                                                   ((nprimes, maximumprimes), p))) (nprimes, maximumprimes)) in
  let l = 0 in
  let bf = 2 in
  let bg = (maximumprimes - 1) in
  let rec bd k l nprimes maximumprimes =
    (if (k <= bg)
     then let be = (fun l nprimes maximumprimes ->
                       (bd (k + 1) l nprimes maximumprimes)) in
     (if (era.(k) = k)
      then (primes.(l) <- k; let l = (l + 1) in
      (be l nprimes maximumprimes))
      else (be l nprimes maximumprimes))
     else begin
            (Printf.printf "%d" l);
            (Printf.printf "%s" " == ");
            (Printf.printf "%d" nprimes);
            (Printf.printf "%s" "\n");
            let canbe = (Array.init_withenv maximumprimes (fun i_ ->
                                                              (fun (l, nprimes, maximumprimes) ->
                                                                  let q = false in
                                                                  ((l, nprimes, maximumprimes), q))) (l, nprimes, maximumprimes)) in
            let bb = 0 in
            let bc = (nprimes - 1) in
            let rec w i l nprimes maximumprimes =
              (if (i <= bc)
               then let z = 0 in
               let ba = (maximumprimes - 1) in
               let rec x j l nprimes maximumprimes =
                 (if (j <= ba)
                  then let n = (primes.(i) + ((2 * j) * j)) in
                  let y = (fun n l nprimes maximumprimes ->
                              (x (j + 1) l nprimes maximumprimes)) in
                  (if (n < maximumprimes)
                   then (canbe.(n) <- true; (y n l nprimes maximumprimes))
                   else (y n l nprimes maximumprimes))
                  else (w (i + 1) l nprimes maximumprimes)) in
                 (x z l nprimes maximumprimes)
               else let u = 1 in
               let v = maximumprimes in
               let rec r m l nprimes maximumprimes =
                 (if (m <= v)
                  then let m2 = ((m * 2) + 1) in
                  let s = (fun m2 l nprimes maximumprimes ->
                              (r (m + 1) l nprimes maximumprimes)) in
                  (if ((m2 < maximumprimes) && (not canbe.(m2)))
                   then begin
                          (Printf.printf "%d" m2);
                          (Printf.printf "%s" "\n");
                          (s m2 l nprimes maximumprimes)
                          end
                   
                   else (s m2 l nprimes maximumprimes))
                  else ()) in
                 (r u l nprimes maximumprimes)) in
              (w bb l nprimes maximumprimes)
            end
     ) in
    (bd bf l nprimes maximumprimes);;

