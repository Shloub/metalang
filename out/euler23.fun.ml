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
      let bh = 2 in
      let bi = (max_ - 1) in
      let rec bd i n t max_ =
        (if (i <= bi)
         then let be = (fun n t max_ ->
                           (bd (i + 1) n t max_)) in
         (if (t.(i) = i)
          then let n = (n + 1) in
          let j = (i * i) in
          let rec bg j n t max_ =
            (if ((j < max_) && (j > 0))
             then (t.(j) <- 0; let j = (j + i) in
             (bg j n t max_))
             else (be n t max_)) in
            (bg j n t max_)
          else (be n t max_))
         else n) in
        (bd bh n t max_));;
let rec fillPrimesFactors =
  (fun t n primes nprimes ->
      let bb = 0 in
      let bc = (nprimes - 1) in
      let rec x i t n primes nprimes =
        (if (i <= bc)
         then let d = primes.(i) in
         let rec ba d t n primes nprimes =
           (if ((n mod d) = 0)
            then (t.(d) <- (t.(d) + 1); let n = (n / d) in
            (ba d t n primes nprimes))
            else let y = (fun d t n primes nprimes ->
                             (x (i + 1) t n primes nprimes)) in
            (if (n = 1)
             then primes.(i)
             else (y d t n primes nprimes))) in
           (ba d t n primes nprimes)
         else n) in
        (x bb t n primes nprimes));;
let rec sumdivaux2 =
  (fun t n i ->
      let rec w t n i =
        (if ((i < n) && (t.(i) = 0))
         then let i = (i + 1) in
         (w t n i)
         else i) in
        (w t n i));;
let rec sumdivaux =
  (fun t n i ->
      let f = (fun t n i ->
                  ()) in
      (if (i > n)
       then 1
       else let g = (fun t n i ->
                        (f t n i)) in
       (if (t.(i) = 0)
        then (sumdivaux t n (sumdivaux2 t n (i + 1)))
        else let o = (sumdivaux t n (sumdivaux2 t n (i + 1))) in
        let out_ = 0 in
        let p = i in
        let m = 1 in
        let u = t.(i) in
        let rec h j p out_ o t n i =
          (if (j <= u)
           then let out_ = (out_ + p) in
           let p = (p * i) in
           (h (j + 1) p out_ o t n i)
           else ((out_ + 1) * o)) in
          (h m p out_ o t n i))));;
let rec sumdiv =
  (fun nprimes primes n ->
      let a = (n + 1) in
      let t = (Array.init_withenv a (fun i ->
                                        (fun (a, nprimes, primes, n) ->
                                            let e = 0 in
                                            ((a, nprimes, primes, n), e))) (a, nprimes, primes, n)) in
      let max_ = (fillPrimesFactors t n primes nprimes) in
      (sumdivaux t max_ 0));;
let rec main =
  let maximumprimes = 30001 in
  let era = (Array.init_withenv maximumprimes (fun s maximumprimes ->
                                                  let bj = s in
                                                  (maximumprimes, bj)) maximumprimes) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun t ->
                                               (fun (nprimes, maximumprimes) ->
                                                   let bk = 0 in
                                                   ((nprimes, maximumprimes), bk))) (nprimes, maximumprimes)) in
  let l = 0 in
  let ce = 2 in
  let cf = (maximumprimes - 1) in
  let rec cc k l nprimes maximumprimes =
    (if (k <= cf)
     then let cd = (fun l nprimes maximumprimes ->
                       (cc (k + 1) l nprimes maximumprimes)) in
     (if (era.(k) = k)
      then (primes.(l) <- k; let l = (l + 1) in
      (cd l nprimes maximumprimes))
      else (cd l nprimes maximumprimes))
     else let n = 100 in
     (*  28124 ça prend trop de temps mais on arrive a passer le test  *)
     let b = (n + 1) in
     let abondant = (Array.init_withenv b (fun p ->
                                              (fun (b, n, l, nprimes, maximumprimes) ->
                                                  let bl = false in
                                                  ((b, n, l, nprimes, maximumprimes), bl))) (b, n, l, nprimes, maximumprimes)) in
     let c = (n + 1) in
     let summable = (Array.init_withenv c (fun q ->
                                              (fun (c, b, n, l, nprimes, maximumprimes) ->
                                                  let bm = false in
                                                  ((c, b, n, l, nprimes, maximumprimes), bm))) (c, b, n, l, nprimes, maximumprimes)) in
     let sum = 0 in
     let ca = 2 in
     let cb = n in
     let rec by r sum c b n l nprimes maximumprimes =
       (if (r <= cb)
        then let other = ((sumdiv nprimes primes r) - r) in
        let bz = (fun other sum c b n l nprimes maximumprimes ->
                     (by (r + 1) sum c b n l nprimes maximumprimes)) in
        (if (other > r)
         then (abondant.(r) <- true; (bz other sum c b n l nprimes maximumprimes))
         else (bz other sum c b n l nprimes maximumprimes))
        else let bw = 1 in
        let bx = n in
        let rec br i sum c b n l nprimes maximumprimes =
          (if (i <= bx)
           then let bu = 1 in
           let bv = n in
           let rec bs j sum c b n l nprimes maximumprimes =
             (if (j <= bv)
              then let bt = (fun sum c b n l nprimes maximumprimes ->
                                (bs (j + 1) sum c b n l nprimes maximumprimes)) in
              (if ((abondant.(i) && abondant.(j)) && ((i + j) <= n))
               then (summable.((i + j)) <- true; (bt sum c b n l nprimes maximumprimes))
               else (bt sum c b n l nprimes maximumprimes))
              else (br (i + 1) sum c b n l nprimes maximumprimes)) in
             (bs bu sum c b n l nprimes maximumprimes)
           else let bp = 1 in
           let bq = n in
           let rec bn o sum c b n l nprimes maximumprimes =
             (if (o <= bq)
              then let bo = (fun sum c b n l nprimes maximumprimes ->
                                (bn (o + 1) sum c b n l nprimes maximumprimes)) in
              (if (not summable.(o))
               then let sum = (sum + o) in
               (bo sum c b n l nprimes maximumprimes)
               else (bo sum c b n l nprimes maximumprimes))
              else begin
                     (Printf.printf "%s" "\n");
                     (Printf.printf "%d" sum);
                     (Printf.printf "%s" "\n")
                     end
              ) in
             (bn bp sum c b n l nprimes maximumprimes)) in
          (br bw sum c b n l nprimes maximumprimes)) in
       (by ca sum c b n l nprimes maximumprimes)) in
    (cc ce l nprimes maximumprimes);;

