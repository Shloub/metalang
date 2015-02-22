module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let eratostene t max0 =
  let n = 0 in
  let ba = 2 in
  let bb = (max0 - 1) in
  let rec y i n =
    (if (i <= bb)
     then let n = (if (t.(i) = i)
                   then let n = (n + 1) in
                   let j = (i * i) in
                   let rec z j =
                     (if ((j < max0) && (j > 0))
                      then (
                             t.(j) <- 0;
                             let j = (j + i) in
                             (z j)
                             )
                      
                      else n) in
                     (z j)
                   else n) in
     (y (i + 1) n)
     else n) in
    (y ba n)
let fillPrimesFactors t n primes nprimes =
  let w = 0 in
  let x = (nprimes - 1) in
  let rec u i n =
    (if (i <= x)
     then let d = primes.(i) in
     let rec v n =
       (if ((n mod d) = 0)
        then (
               t.(d) <- (t.(d) + 1);
               let n = (n / d) in
               (v n)
               )
        
        else (if (n = 1)
              then primes.(i)
              else (u (i + 1) n))) in
       (v n)
     else n) in
    (u w n)
let sumdivaux2 t n i =
  let rec m i =
    (if ((i < n) && (t.(i) = 0))
     then let i = (i + 1) in
     (m i)
     else i) in
    (m i)
let rec sumdivaux t n i =
  let c () = () in
  (if (i > n)
   then 1
   else let e () = (c ()) in
   (if (t.(i) = 0)
    then (sumdivaux t n (sumdivaux2 t n (i + 1)))
    else let o = (sumdivaux t n (sumdivaux2 t n (i + 1))) in
    let out0 = 0 in
    let p = i in
    let g = 1 in
    let h = t.(i) in
    let rec f j out0 p =
      (if (j <= h)
       then let out0 = (out0 + p) in
       let p = (p * i) in
       (f (j + 1) out0 p)
       else ((out0 + 1) * o)) in
      (f g out0 p)))
let sumdiv nprimes primes n =
  ((fun  (b, t) -> (
                     b;
                     let max0 = (fillPrimesFactors t n primes nprimes) in
                     (sumdivaux t max0 0)
                     )
  ) (Array.init_withenv (n + 1) (fun  i () -> let a = 0 in
  ((), a)) ()))
let main =
  let maximumprimes = 30001 in
  ((fun  (bd, era) -> (
                        bd;
                        let nprimes = (eratostene era maximumprimes) in
                        ((fun  (bf, primes) -> (
                                                 bf;
                                                 let l = 0 in
                                                 let bx = 2 in
                                                 let by = (maximumprimes - 1) in
                                                 let rec bw k l =
                                                   (if (k <= by)
                                                    then let l = (if (era.(k) = k)
                                                                  then 
                                                                  (
                                                                    primes.(l) <- k;
                                                                    let l = (l + 1) in
                                                                    l
                                                                    )
                                                                  
                                                                  else l) in
                                                    (bw (k + 1) l)
                                                    else let n = 100 in
                                                    (*  28124 ça prend trop de temps mais on arrive a passer le test  *)
                                                    ((fun  (bh, abondant) -> 
                                                    (
                                                      bh;
                                                      ((fun  (bj, summable) -> 
                                                      (
                                                        bj;
                                                        let sum = 0 in
                                                        let bu = 2 in
                                                        let bv = n in
                                                        let rec bt r =
                                                          (if (r <= bv)
                                                           then let other = ((sumdiv nprimes primes r) - r) in
                                                           (
                                                             (if (other > r)
                                                              then abondant.(r) <- true
                                                              else ());
                                                             (bt (r + 1))
                                                             )
                                                           
                                                           else let br = 1 in
                                                           let bs = n in
                                                           let rec bn i =
                                                             (if (i <= bs)
                                                              then let bp = 1 in
                                                              let bq = n in
                                                              let rec bo j =
                                                                (if (j <= bq)
                                                                 then 
                                                                 (
                                                                   (if ((abondant.(i) && abondant.(j)) && ((i + j) <= n))
                                                                    then summable.((i + j)) <- true
                                                                    else ());
                                                                   (bo (j + 1))
                                                                   )
                                                                 
                                                                 else (bn (i + 1))) in
                                                                (bo bp)
                                                              else let bl = 1 in
                                                              let bm = n in
                                                              let rec bk o sum =
                                                                (if (o <= bm)
                                                                 then let sum = (
                                                                 if (not summable.(o))
                                                                 then let sum = (sum + o) in
                                                                 sum
                                                                 else sum) in
                                                                 (bk (o + 1) sum)
                                                                 else 
                                                                 (
                                                                   (Printf.printf "\n%d\n" sum)
                                                                   )
                                                                 ) in
                                                                (bk bl sum)) in
                                                             (bn br)) in
                                                          (bt bu)
                                                        )
                                                      ) (Array.init_withenv (n + 1) (fun  q () -> let bi = false in
                                                      ((), bi)) ()))
                                                      )
                                                    ) (Array.init_withenv (n + 1) (fun  p () -> let bg = false in
                                                    ((), bg)) ()))) in
                                                   (bw bx l)
                                                 )
                        ) (Array.init_withenv nprimes (fun  t () -> let be = 0 in
                        ((), be)) ()))
                        )
  ) (Array.init_withenv maximumprimes (fun  s () -> let bc = s in
  ((), bc)) ()))

