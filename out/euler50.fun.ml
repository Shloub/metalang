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

let min2 =
  (fun a b ->
      let h = (fun () -> ()) in
      (if (a < b)
       then a
       else b));;
let eratostene =
  (fun t max_ ->
      let n = 0 in
      let f = 2 in
      let g = (max_ - 1) in
      let rec c i n =
        (if (i <= g)
         then let n = (if (t.(i) = i)
                       then let n = (n + 1) in
                       let j = (i * i) in
                       let j = (if ((j / i) = i)
                                then (*  overflow test  *)
                                let rec e j =
                                  (if ((j < max_) && (j > 0))
                                   then (
                                          t.(j) <- 0;
                                          let j = (j + i) in
                                          (e j)
                                          )
                                   
                                   else j) in
                                  (e j)
                                else j) in
                       n
                       else n) in
         (c (i + 1) n)
         else n) in
        (c f n));;
let main =
  let maximumprimes = 1000001 in
  let era = (Array.init_withenv maximumprimes (fun j ->
                                                  (fun () -> let m = j in
                                                  ((), m))) ()) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun o ->
                                               (fun () -> let p = 0 in
                                               ((), p))) ()) in
  let l = 0 in
  let y = 2 in
  let z = (maximumprimes - 1) in
  let rec x k l =
    (if (k <= z)
     then let l = (if (era.(k) = k)
                   then (
                          primes.(l) <- k;
                          let l = (l + 1) in
                          l
                          )
                   
                   else l) in
     (x (k + 1) l)
     else (
            (Printf.printf "%d" l);
            (Printf.printf "%s" " == ");
            (Printf.printf "%d" nprimes);
            (Printf.printf "%s" "\n");
            let sum = (Array.init_withenv nprimes (fun i_ ->
                                                      (fun () -> let q = primes.(i_) in
                                                      ((), q))) ()) in
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
                  then ((fun (maxl, process, resp, stop) ->
                            (u (i + 1) maxl process resp stop)) (if ((i + len) < nprimes)
                                                                 then 
                                                                 (
                                                                   sum.(i) <- (sum.(i) + primes.((i + len)));
                                                                   ((fun
                                                                    (maxl, process, resp, stop) ->
                                                                   (maxl, process, resp, stop)) (
                                                                   if (maximumprimes > sum.(i))
                                                                   then let process = true in
                                                                   ((fun
                                                                    (maxl, resp) ->
                                                                   (maxl, process, resp, stop)) (
                                                                   if (era.(sum.(i)) = sum.(i))
                                                                   then let maxl = len in
                                                                   let resp = sum.(i) in
                                                                   (maxl, resp)
                                                                   else (maxl, resp)))
                                                                   else let stop = (min2 stop i) in
                                                                   (maxl, process, resp, stop)))
                                                                   )
                                                                 
                                                                 else (maxl, process, resp, stop)))
                  else let len = (len + 1) in
                  (s len maxl process resp stop)) in
                 (u v maxl process resp stop)
               else (
                      (Printf.printf "%d" resp);
                      (Printf.printf "%s" "\n");
                      (Printf.printf "%d" maxl);
                      (Printf.printf "%s" "\n")
                      )
               ) in
              (s len maxl process resp stop)
            )
     ) in
    (x y l);;

