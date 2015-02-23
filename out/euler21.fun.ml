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
  let x = 2 in
  let y = (max0 - 1) in
  let rec v i n =
    (if (i <= y)
     then let n = (if (t.(i) = i)
                   then let n = (n + 1) in
                   let j = (i * i) in
                   let rec w j =
                     (if ((j < max0) && (j > 0))
                      then (
                             t.(j) <- 0;
                             let j = (j + i) in
                             (w j)
                             )
                      
                      else n) in
                     (w j)
                   else n) in
     (v (i + 1) n)
     else n) in
    (v x n)
let fillPrimesFactors t n primes nprimes =
  let s = 0 in
  let u = (nprimes - 1) in
  let rec q i n =
    (if (i <= u)
     then let d = primes.(i) in
     let rec r n =
       (if ((n mod d) = 0)
        then (
               t.(d) <- (t.(d) + 1);
               let n = (n / d) in
               (r n)
               )
        
        else (if (n = 1)
              then primes.(i)
              else (q (i + 1) n))) in
       (r n)
     else n) in
    (q s n)
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
  let maximumprimes = 1001 in
  ((fun  (ba, era) -> (
                        ba;
                        let nprimes = (eratostene era maximumprimes) in
                        ((fun  (bc, primes) -> (
                                                 bc;
                                                 let l = 0 in
                                                 let bh = 2 in
                                                 let bi = (maximumprimes - 1) in
                                                 let rec bg k l =
                                                   (if (k <= bi)
                                                    then let l = (if (era.(k) = k)
                                                                  then (
                                                                         primes.(l) <- k;
                                                                         let l = (l + 1) in
                                                                         l
                                                                         )
                                                                  
                                                                  else l) in
                                                    (bg (k + 1) l)
                                                    else (
                                                           (Printf.printf "%d == %d\n" l nprimes);
                                                           let sum = 0 in
                                                           let be = 2 in
                                                           let bf = 1000 in
                                                           let rec bd n sum =
                                                             (if (n <= bf)
                                                              then let other = ((sumdiv nprimes primes n) - n) in
                                                              let sum = (if (other > n)
                                                                         then let othersum = ((sumdiv nprimes primes other) - other) in
                                                                         let sum = (
                                                                         if (othersum = n)
                                                                         then (
                                                                                (Printf.printf "%d & %d\n" other n);
                                                                                let sum = (sum + (other + n)) in
                                                                                sum
                                                                                )
                                                                         
                                                                         else sum) in
                                                                         sum
                                                                         else sum) in
                                                              (bd (n + 1) sum)
                                                              else (
                                                                     (Printf.printf "\n%d\n" sum)
                                                                     )
                                                              ) in
                                                             (bd be sum)
                                                           )
                                                    ) in
                                                   (bg bh l)
                                                 )
                        ) (Array.init_withenv nprimes (fun  o () -> let bb = 0 in
                        ((), bb)) ()))
                        )
  ) (Array.init_withenv maximumprimes (fun  j () -> let z = j in
  ((), z)) ()))

