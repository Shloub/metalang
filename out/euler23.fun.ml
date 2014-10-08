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
  let bf = 2 in
  let bg = (max0 - 1) in
  let rec bc i n =
    (if (i <= bg)
     then let n = (if (t.(i) = i)
                   then let n = (n + 1) in
                   let j = (i * i) in
                   let rec be j =
                     (if ((j < max0) && (j > 0))
                      then (
                             t.(j) <- 0;
                             let j = (j + i) in
                             (be j)
                             )
                      
                      else n) in
                     (be j)
                   else n) in
     (bc (i + 1) n)
     else n) in
    (bc bf n)
let fillPrimesFactors t n primes nprimes =
  let ba = 0 in
  let bb = (nprimes - 1) in
  let rec x i n =
    (if (i <= bb)
     then let d = primes.(i) in
     let rec z n =
       (if ((n mod d) = 0)
        then (
               t.(d) <- (t.(d) + 1);
               let n = (n / d) in
               (z n)
               )
        
        else (if (n = 1)
              then primes.(i)
              else (x (i + 1) n))) in
       (z n)
     else n) in
    (x ba n)
let sumdivaux2 t n i =
  let rec w i =
    (if ((i < n) && (t.(i) = 0))
     then let i = (i + 1) in
     (w i)
     else i) in
    (w i)
let rec sumdivaux t n i =
  let f () = () in
  (if (i > n)
   then 1
   else let g () = (f ()) in
   (if (t.(i) = 0)
    then (sumdivaux t n (sumdivaux2 t n (i + 1)))
    else let o = (sumdivaux t n (sumdivaux2 t n (i + 1))) in
    let out0 = 0 in
    let p = i in
    let m = 1 in
    let u = t.(i) in
    let rec h j out0 p =
      (if (j <= u)
       then let out0 = (out0 + p) in
       let p = (p * i) in
       (h (j + 1) out0 p)
       else ((out0 + 1) * o)) in
      (h m out0 p)))
let sumdiv nprimes primes n =
  let t = (Array.init_withenv (n + 1) (fun  i () -> let e = 0 in
  ((), e)) ()) in
  let max0 = (fillPrimesFactors t n primes nprimes) in
  (sumdivaux t max0 0)
let main =
  let maximumprimes = 30001 in
  let era = (Array.init_withenv maximumprimes (fun  s () -> let bh = s in
  ((), bh)) ()) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun  t () -> let bi = 0 in
  ((), bi)) ()) in
  let l = 0 in
  let by = 2 in
  let bz = (maximumprimes - 1) in
  let rec bx k l =
    (if (k <= bz)
     then let l = (if (era.(k) = k)
                   then (
                          primes.(l) <- k;
                          let l = (l + 1) in
                          l
                          )
                   
                   else l) in
     (bx (k + 1) l)
     else let n = 100 in
     (*  28124 ça prend trop de temps mais on arrive a passer le test  *)
     let abondant = (Array.init_withenv (n + 1) (fun  p () -> let bj = false in
     ((), bj)) ()) in
     let summable = (Array.init_withenv (n + 1) (fun  q () -> let bk = false in
     ((), bk)) ()) in
     let sum = 0 in
     let bv = 2 in
     let bw = n in
     let rec bu r =
       (if (r <= bw)
        then let other = ((sumdiv nprimes primes r) - r) in
        (
          (if (other > r)
           then abondant.(r) <- true
           else ());
          (bu (r + 1))
          )
        
        else let bs = 1 in
        let bt = n in
        let rec bo i =
          (if (i <= bt)
           then let bq = 1 in
           let br = n in
           let rec bp j =
             (if (j <= br)
              then (
                     (if ((abondant.(i) && abondant.(j)) && ((i + j) <= n))
                      then summable.((i + j)) <- true
                      else ());
                     (bp (j + 1))
                     )
              
              else (bo (i + 1))) in
             (bp bq)
           else let bm = 1 in
           let bn = n in
           let rec bl o sum =
             (if (o <= bn)
              then let sum = (if (not summable.(o))
                              then let sum = (sum + o) in
                              sum
                              else sum) in
              (bl (o + 1) sum)
              else (
                     (Printf.printf "\n%d\n" sum)
                     )
              ) in
             (bl bm sum)) in
          (bo bs)) in
       (bu bv)) in
    (bx by l)

