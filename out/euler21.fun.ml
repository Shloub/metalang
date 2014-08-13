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
      let bc = 2 in
      let bd = (max_ - 1) in
      let rec y i n t max_ =
        (if (i <= bd)
         then let z = (fun n t max_ ->
                          (y (i + 1) n t max_)) in
         (if (t.(i) = i)
          then let n = (n + 1) in
          let j = (i * i) in
          let rec bb j n t max_ =
            (if ((j < max_) && (j > 0))
             then (t.(j) <- 0; let j = (j + i) in
             (bb j n t max_))
             else (z n t max_)) in
            (bb j n t max_)
          else (z n t max_))
         else n) in
        (y bc n t max_));;
let rec fillPrimesFactors =
  (fun t n primes nprimes ->
      let w = 0 in
      let x = (nprimes - 1) in
      let rec r i t n primes nprimes =
        (if (i <= x)
         then let d = primes.(i) in
         let rec v d t n primes nprimes =
           (if ((n mod d) = 0)
            then (t.(d) <- (t.(d) + 1); let n = (n / d) in
            (v d t n primes nprimes))
            else let s = (fun d t n primes nprimes ->
                             (r (i + 1) t n primes nprimes)) in
            (if (n = 1)
             then primes.(i)
             else (s d t n primes nprimes))) in
           (v d t n primes nprimes)
         else n) in
        (r w t n primes nprimes));;
let rec sumdivaux2 =
  (fun t n i ->
      let rec q t n i =
        (if ((i < n) && (t.(i) = 0))
         then let i = (i + 1) in
         (q t n i)
         else i) in
        (q t n i));;
let rec sumdivaux =
  (fun t n i ->
      let c = (fun t n i ->
                  ()) in
      (if (i > n)
       then 1
       else let e = (fun t n i ->
                        (c t n i)) in
       (if (t.(i) = 0)
        then (sumdivaux t n (sumdivaux2 t n (i + 1)))
        else let o = (sumdivaux t n (sumdivaux2 t n (i + 1))) in
        let out_ = 0 in
        let p = i in
        let g = 1 in
        let h = t.(i) in
        let rec f j p out_ o t n i =
          (if (j <= h)
           then let out_ = (out_ + p) in
           let p = (p * i) in
           (f (j + 1) p out_ o t n i)
           else ((out_ + 1) * o)) in
          (f g p out_ o t n i))));;
let rec sumdiv =
  (fun nprimes primes n ->
      let a = (n + 1) in
      let t = (Array.init_withenv a (fun i ->
                                        (fun (a, nprimes, primes, n) ->
                                            let b = 0 in
                                            ((a, nprimes, primes, n), b))) (a, nprimes, primes, n)) in
      let max_ = (fillPrimesFactors t n primes nprimes) in
      (sumdivaux t max_ 0));;
let rec main =
  let maximumprimes = 1001 in
  let era = (Array.init_withenv maximumprimes (fun j maximumprimes ->
                                                  let be = j in
                                                  (maximumprimes, be)) maximumprimes) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun o ->
                                               (fun (nprimes, maximumprimes) ->
                                                   let bf = 0 in
                                                   ((nprimes, maximumprimes), bf))) (nprimes, maximumprimes)) in
  let l = 0 in
  let bn = 2 in
  let bo = (maximumprimes - 1) in
  let rec bl k l nprimes maximumprimes =
    (if (k <= bo)
     then let bm = (fun l nprimes maximumprimes ->
                       (bl (k + 1) l nprimes maximumprimes)) in
     (if (era.(k) = k)
      then (primes.(l) <- k; let l = (l + 1) in
      (bm l nprimes maximumprimes))
      else (bm l nprimes maximumprimes))
     else begin
            (Printf.printf "%d" l);
            (Printf.printf "%s" " == ");
            (Printf.printf "%d" nprimes);
            (Printf.printf "%s" "\n");
            let sum = 0 in
            let bj = 2 in
            let bk = 1000 in
            let rec bg n sum l nprimes maximumprimes =
              (if (n <= bk)
               then let other = ((sumdiv nprimes primes n) - n) in
               let bh = (fun other sum l nprimes maximumprimes ->
                            (bg (n + 1) sum l nprimes maximumprimes)) in
               (if (other > n)
                then let othersum = ((sumdiv nprimes primes other) - other) in
                let bi = (fun othersum other sum l nprimes maximumprimes ->
                             (bh other sum l nprimes maximumprimes)) in
                (if (othersum = n)
                 then begin
                        (Printf.printf "%d" other);
                        (Printf.printf "%s" " & ");
                        (Printf.printf "%d" n);
                        (Printf.printf "%s" "\n");
                        let sum = (sum + (other + n)) in
                        (bi othersum other sum l nprimes maximumprimes)
                        end
                 
                 else (bi othersum other sum l nprimes maximumprimes))
                else (bh other sum l nprimes maximumprimes))
               else begin
                      (Printf.printf "%s" "\n");
                      (Printf.printf "%d" sum);
                      (Printf.printf "%s" "\n")
                      end
               ) in
              (bg bj sum l nprimes maximumprimes)
            end
     ) in
    (bl bn l nprimes maximumprimes);;

