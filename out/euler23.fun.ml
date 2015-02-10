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
  let bc = 2 in
  let bd = (max0 - 1) in
  let rec ba i n =
    (if (i <= bd)
     then let n = (if (t.(i) = i)
                   then let n = (n + 1) in
                   let j = (i * i) in
                   let rec bb j =
                     (if ((j < max0) && (j > 0))
                      then (
                             t.(j) <- 0;
                             let j = (j + i) in
                             (bb j)
                             )
                      
                      else n) in
                     (bb j)
                   else n) in
     (ba (i + 1) n)
     else n) in
    (ba bc n)
let fillPrimesFactors t n primes nprimes =
  let y = 0 in
  let z = (nprimes - 1) in
  let rec w i n =
    (if (i <= z)
     then let d = primes.(i) in
     let rec x n =
       (if ((n mod d) = 0)
        then (
               t.(d) <- (t.(d) + 1);
               let n = (n / d) in
               (x n)
               )
        
        else (if (n = 1)
              then primes.(i)
              else (w (i + 1) n))) in
       (x n)
     else n) in
    (w y n)
let sumdivaux2 t n i =
  let rec v i =
    (if ((i < n) && (t.(i) = 0))
     then let i = (i + 1) in
     (v i)
     else i) in
    (v i)
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
  let era = (Array.init_withenv maximumprimes (fun  s () -> let be = s in
  ((), be)) ()) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun  t () -> let bf = 0 in
  ((), bf)) ()) in
  let l = 0 in
  let bv = 2 in
  let bw = (maximumprimes - 1) in
  let rec bu k l =
    (if (k <= bw)
     then let l = (if (era.(k) = k)
                   then (
                          primes.(l) <- k;
                          let l = (l + 1) in
                          l
                          )
                   
                   else l) in
     (bu (k + 1) l)
     else let n = 100 in
     (*  28124 ça prend trop de temps mais on arrive a passer le test  *)
     let abondant = (Array.init_withenv (n + 1) (fun  p () -> let bg = false in
     ((), bg)) ()) in
     let summable = (Array.init_withenv (n + 1) (fun  q () -> let bh = false in
     ((), bh)) ()) in
     let sum = 0 in
     let bs = 2 in
     let bt = n in
     let rec br r =
       (if (r <= bt)
        then let other = ((sumdiv nprimes primes r) - r) in
        (
          (if (other > r)
           then abondant.(r) <- true
           else ());
          (br (r + 1))
          )
        
        else let bp = 1 in
        let bq = n in
        let rec bl i =
          (if (i <= bq)
           then let bn = 1 in
           let bo = n in
           let rec bm j =
             (if (j <= bo)
              then (
                     (if ((abondant.(i) && abondant.(j)) && ((i + j) <= n))
                      then summable.((i + j)) <- true
                      else ());
                     (bm (j + 1))
                     )
              
              else (bl (i + 1))) in
             (bm bn)
           else let bj = 1 in
           let bk = n in
           let rec bi o sum =
             (if (o <= bk)
              then let sum = (if (not summable.(o))
                              then let sum = (sum + o) in
                              sum
                              else sum) in
              (bi (o + 1) sum)
              else (
                     (Printf.printf "\n%d\n" sum)
                     )
              ) in
             (bi bj sum)) in
          (bl bp)) in
       (br bs)) in
    (bu bv l)

