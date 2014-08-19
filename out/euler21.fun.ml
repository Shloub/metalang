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

let eratostene t max_ =
  let n = 0 in
  let ba = 2 in
  let bb = (max_ - 1) in
  let rec x i n =
    (if (i <= bb)
     then let n = (if (t.(i) = i)
                   then let n = (n + 1) in
                   let j = (i * i) in
                   let rec z j =
                     (if ((j < max_) && (j > 0))
                      then (
                             t.(j) <- 0;
                             let j = (j + i) in
                             (z j)
                             )
                      
                      else n) in
                     (z j)
                   else n) in
     (x (i + 1) n)
     else n) in
    (x ba n)
let fillPrimesFactors t n primes nprimes =
  let v = 0 in
  let w = (nprimes - 1) in
  let rec r i n =
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
              else (r (i + 1) n))) in
       (u n)
     else n) in
    (r v n)
let sumdivaux2 t n i =
  let rec q i =
    (if ((i < n) && (t.(i) = 0))
     then let i = (i + 1) in
     (q i)
     else i) in
    (q i)
let rec sumdivaux t n i =
  let c () = () in
  (if (i > n)
   then 1
   else let e () = (c ()) in
   (if (t.(i) = 0)
    then (sumdivaux t n (sumdivaux2 t n (i + 1)))
    else let o = (sumdivaux t n (sumdivaux2 t n (i + 1))) in
    let out_ = 0 in
    let p = i in
    let g = 1 in
    let h = t.(i) in
    let rec f j out_ p =
      (if (j <= h)
       then let out_ = (out_ + p) in
       let p = (p * i) in
       (f (j + 1) out_ p)
       else ((out_ + 1) * o)) in
      (f g out_ p)))
let sumdiv nprimes primes n =
  let a = (n + 1) in
  let t = (Array.init_withenv a (fun  i () -> let b = 0 in
  ((), b)) ()) in
  let max_ = (fillPrimesFactors t n primes nprimes) in
  (sumdivaux t max_ 0)
let main =
  let maximumprimes = 1001 in
  let era = (Array.init_withenv maximumprimes (fun  j () -> let bc = j in
  ((), bc)) ()) in
  let nprimes = (eratostene era maximumprimes) in
  let primes = (Array.init_withenv nprimes (fun  o () -> let bd = 0 in
  ((), bd)) ()) in
  let l = 0 in
  let bi = 2 in
  let bj = (maximumprimes - 1) in
  let rec bh k l =
    (if (k <= bj)
     then let l = (if (era.(k) = k)
                   then (
                          primes.(l) <- k;
                          let l = (l + 1) in
                          l
                          )
                   
                   else l) in
     (bh (k + 1) l)
     else (
            (Printf.printf "%d" l);
            (Printf.printf "%s" " == ");
            (Printf.printf "%d" nprimes);
            (Printf.printf "%s" "\n");
            let sum = 0 in
            let bf = 2 in
            let bg = 1000 in
            let rec be n sum =
              (if (n <= bg)
               then let other = ((sumdiv nprimes primes n) - n) in
               let sum = (if (other > n)
                          then let othersum = ((sumdiv nprimes primes other) - other) in
                          let sum = (if (othersum = n)
                                     then (
                                            (Printf.printf "%d" other);
                                            (Printf.printf "%s" " & ");
                                            (Printf.printf "%d" n);
                                            (Printf.printf "%s" "\n");
                                            let sum = (sum + (other + n)) in
                                            sum
                                            )
                                     
                                     else sum) in
                          sum
                          else sum) in
               (be (n + 1) sum)
               else (
                      (Printf.printf "%s" "\n");
                      (Printf.printf "%d" sum);
                      (Printf.printf "%s" "\n")
                      )
               ) in
              (be bf sum)
            )
     ) in
    (bh bi l)

