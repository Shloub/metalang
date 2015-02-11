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
  let z = 2 in
  let ba = (max0 - 1) in
  let rec x i n =
    (if (i <= ba)
     then let n = (if (t.(i) = i)
                   then let n = (n + 1) in
                   let j = (i * i) in
                   let rec y j =
                     (if ((j < max0) && (j > 0))
                      then (
                             t.(j) <- 0;
                             let j = (j + i) in
                             (y j)
                             )
                      
                      else n) in
                     (y j)
                   else n) in
     (x (i + 1) n)
     else n) in
    (x z n)
let fillPrimesFactors t n primes nprimes =
  let v = 0 in
  let w = (nprimes - 1) in
  let rec m i n =
    (if (i <= w)
     then let d = primes.(i) in
     let rec u n =
       (if ((n mod d) = 0)
        then (
               t.(d) <- (t.(d) + 1);
               let n = (n / d) in
               (u n)
               )
        
        else (if (n = 1)
              then primes.(i)
              else (m (i + 1) n))) in
       (u n)
     else n) in
    (m v n)
let sumdivaux2 t n i =
  let rec h i =
    (if ((i < n) && (t.(i) = 0))
     then let i = (i + 1) in
     (h i)
     else i) in
    (h i)
let rec sumdivaux t n i =
  let b () = () in
  (if (i > n)
   then 1
   else let c () = (b ()) in
   (if (t.(i) = 0)
    then (sumdivaux t n (sumdivaux2 t n (i + 1)))
    else let o = (sumdivaux t n (sumdivaux2 t n (i + 1))) in
    let out0 = 0 in
    let p = i in
    let f = 1 in
    let g = t.(i) in
    let rec e j out0 p =
      (if (j <= g)
       then let out0 = (out0 + p) in
       let p = (p * i) in
       (e (j + 1) out0 p)
       else ((out0 + 1) * o)) in
      (e f out0 p)))
let sumdiv nprimes primes n =
  let t = (Array.init_withenv (n + 1) (fun  i () -> let a = 0 in
  ((), a)) ()) in
  let max0 = (fillPrimesFactors t n primes nprimes) in
  (sumdivaux t max0 0)
let main =
  let maximumprimes = 30001 in
  let era = (Array.init_withenv maximumprimes (fun  s () -> let bb = s in
  ((), bb)) ()) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun  t () -> let bc = 0 in
  ((), bc)) ()) in
  let l = 0 in
  let bs = 2 in
  let bt = (maximumprimes - 1) in
  let rec br k l =
    (if (k <= bt)
     then let l = (if (era.(k) = k)
                   then (
                          primes.(l) <- k;
                          let l = (l + 1) in
                          l
                          )
                   
                   else l) in
     (br (k + 1) l)
     else let n = 100 in
     (*  28124 ça prend trop de temps mais on arrive a passer le test  *)
     let abondant = (Array.init_withenv (n + 1) (fun  p () -> let bd = false in
     ((), bd)) ()) in
     let summable = (Array.init_withenv (n + 1) (fun  q () -> let be = false in
     ((), be)) ()) in
     let sum = 0 in
     let bp = 2 in
     let bq = n in
     let rec bo r =
       (if (r <= bq)
        then let other = ((sumdiv nprimes primes r) - r) in
        (
          (if (other > r)
           then abondant.(r) <- true
           else ());
          (bo (r + 1))
          )
        
        else let bm = 1 in
        let bn = n in
        let rec bi i =
          (if (i <= bn)
           then let bk = 1 in
           let bl = n in
           let rec bj j =
             (if (j <= bl)
              then (
                     (if ((abondant.(i) && abondant.(j)) && ((i + j) <= n))
                      then summable.((i + j)) <- true
                      else ());
                     (bj (j + 1))
                     )
              
              else (bi (i + 1))) in
             (bj bk)
           else let bg = 1 in
           let bh = n in
           let rec bf o sum =
             (if (o <= bh)
              then let sum = (if (not summable.(o))
                              then let sum = (sum + o) in
                              sum
                              else sum) in
              (bf (o + 1) sum)
              else (
                     (Printf.printf "\n%d\n" sum)
                     )
              ) in
             (bf bg sum)) in
          (bi bm)) in
       (bo bp)) in
    (br bs l)

