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

let rec min2 =
  (fun a b ->
      let p = (fun a b ->
                  ()) in
      (if (a < b)
       then a
       else b));;
let rec eratostene =
  (fun t max_ ->
      let n = 0 in
      let h = 2 in
      let m = (max_ - 1) in
      let rec c i n t max_ =
        (if (i <= m)
         then let d = (fun n t max_ ->
                          (c (i + 1) n t max_)) in
         (if (t.(i) = i)
          then let n = (n + 1) in
          let j = (i * i) in
          let e = (fun j n t max_ ->
                      (d n t max_)) in
          (if ((j / i) = i)
           then (*  overflow test  *)
           let rec g j n t max_ =
             (if ((j < max_) && (j > 0))
              then (t.(j) <- 0; let j = (j + i) in
              (g j n t max_))
              else (e j n t max_)) in
             (g j n t max_)
           else (e j n t max_))
          else (d n t max_))
         else n) in
        (c h n t max_));;
let rec main =
  let maximumprimes = 1000001 in
  let era = (Array.init_withenv maximumprimes (fun j maximumprimes ->
                                                  let q = j in
                                                  (maximumprimes, q)) maximumprimes) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun o ->
                                               (fun (nprimes, maximumprimes) ->
                                                   let r = 0 in
                                                   ((nprimes, maximumprimes), r))) (nprimes, maximumprimes)) in
  let l = 0 in
  let be = 2 in
  let bf = (maximumprimes - 1) in
  let rec bc k l nprimes maximumprimes =
    (if (k <= bf)
     then let bd = (fun l nprimes maximumprimes ->
                       (bc (k + 1) l nprimes maximumprimes)) in
     (if (era.(k) = k)
      then (primes.(l) <- k; let l = (l + 1) in
      (bd l nprimes maximumprimes))
      else (bd l nprimes maximumprimes))
     else begin
            (Printf.printf "%d" l);
            (Printf.printf "%s" " == ");
            (Printf.printf "%d" nprimes);
            (Printf.printf "%s" "\n");
            let sum = (Array.init_withenv nprimes (fun i_ ->
                                                      (fun (l, nprimes, maximumprimes) ->
                                                          let s = primes.(i_) in
                                                          ((l, nprimes, maximumprimes), s))) (l, nprimes, maximumprimes)) in
            let maxl = 0 in
            let process = true in
            let stop = (maximumprimes - 1) in
            let len = 1 in
            let resp = 1 in
            let rec v resp len stop process maxl l nprimes maximumprimes =
              (if process
               then let process = false in
               let ba = 0 in
               let bb = stop in
               let rec w i resp len stop process maxl l nprimes maximumprimes =
                 (if (i <= bb)
                  then let x = (fun resp len stop process maxl l nprimes maximumprimes ->
                                   (w (i + 1) resp len stop process maxl l nprimes maximumprimes)) in
                  (if ((i + len) < nprimes)
                   then (sum.(i) <- (sum.(i) + primes.((i + len))); let y = (fun
                    resp len stop process maxl l nprimes maximumprimes ->
                   (x resp len stop process maxl l nprimes maximumprimes)) in
                   (if (maximumprimes > sum.(i))
                    then let process = true in
                    let z = (fun resp len stop process maxl l nprimes maximumprimes ->
                                (y resp len stop process maxl l nprimes maximumprimes)) in
                    (if (era.(sum.(i)) = sum.(i))
                     then let maxl = len in
                     let resp = sum.(i) in
                     (z resp len stop process maxl l nprimes maximumprimes)
                     else (z resp len stop process maxl l nprimes maximumprimes))
                    else let stop = (min2 stop i) in
                    (y resp len stop process maxl l nprimes maximumprimes)))
                   else (x resp len stop process maxl l nprimes maximumprimes))
                  else let len = (len + 1) in
                  (v resp len stop process maxl l nprimes maximumprimes)) in
                 (w ba resp len stop process maxl l nprimes maximumprimes)
               else begin
                      (Printf.printf "%d" resp);
                      (Printf.printf "%s" "\n");
                      (Printf.printf "%d" maxl);
                      (Printf.printf "%s" "\n")
                      end
               ) in
              (v resp len stop process maxl l nprimes maximumprimes)
            end
     ) in
    (bc be l nprimes maximumprimes);;

