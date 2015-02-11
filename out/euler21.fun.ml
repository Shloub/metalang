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
  let w = 2 in
  let x = (max0 - 1) in
  let rec u i n =
    (if (i <= x)
     then let n = (if (t.(i) = i)
                   then let n = (n + 1) in
                   let j = (i * i) in
                   let rec v j =
                     (if ((j < max0) && (j > 0))
                      then (
                             t.(j) <- 0;
                             let j = (j + i) in
                             (v j)
                             )
                      
                      else n) in
                     (v j)
                   else n) in
     (u (i + 1) n)
     else n) in
    (u w n)
let fillPrimesFactors t n primes nprimes =
  let r = 0 in
  let s = (nprimes - 1) in
  let rec m i n =
    (if (i <= s)
     then let d = primes.(i) in
     let rec q n =
       (if ((n mod d) = 0)
        then (
               t.(d) <- (t.(d) + 1);
               let n = (n / d) in
               (q n)
               )
        
        else (if (n = 1)
              then primes.(i)
              else (m (i + 1) n))) in
       (q n)
     else n) in
    (m r n)
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
  let maximumprimes = 1001 in
  let era = (Array.init_withenv maximumprimes (fun  j () -> let y = j in
  ((), y)) ()) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun  o () -> let z = 0 in
  ((), z)) ()) in
  let l = 0 in
  let be = 2 in
  let bf = (maximumprimes - 1) in
  let rec bd k l =
    (if (k <= bf)
     then let l = (if (era.(k) = k)
                   then (
                          primes.(l) <- k;
                          let l = (l + 1) in
                          l
                          )
                   
                   else l) in
     (bd (k + 1) l)
     else (
            (Printf.printf "%d == %d\n" l nprimes);
            let sum = 0 in
            let bb = 2 in
            let bc = 1000 in
            let rec ba n sum =
              (if (n <= bc)
               then let other = ((sumdiv nprimes primes n) - n) in
               let sum = (if (other > n)
                          then let othersum = ((sumdiv nprimes primes other) - other) in
                          let sum = (if (othersum = n)
                                     then (
                                            (Printf.printf "%d & %d\n" other n);
                                            let sum = (sum + (other + n)) in
                                            sum
                                            )
                                     
                                     else sum) in
                          sum
                          else sum) in
               (ba (n + 1) sum)
               else (
                      (Printf.printf "\n%d\n" sum)
                      )
               ) in
              (ba bb sum)
            )
     ) in
    (bd be l)

