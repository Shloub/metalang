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

let primesfactors n =
  let tab = (Array.init_withenv (n + 1) (fun  i () -> let p = 0 in
  ((), p)) ()) in
  let d = 2 in
  let rec r d n =
    (if ((n <> 1) && ((d * d) <= n))
     then ((fun  (d, n) -> (r d n)) (if ((n mod d) = 0)
                                     then (
                                            tab.(d) <- (tab.(d) + 1);
                                            let n = (n / d) in
                                            (d, n)
                                            )
                                     
                                     else let d = (d + 1) in
                                     (d, n)))
     else (
            tab.(n) <- (tab.(n) + 1);
            tab
            )
     ) in
    (r d n)
let main =
  let lim = 20 in
  let o = (Array.init_withenv (lim + 1) (fun  m () -> let s = 0 in
  ((), s)) ()) in
  let be = 1 in
  let bf = lim in
  let rec ba i =
    (if (i <= bf)
     then let t = (primesfactors i) in
     let bc = 1 in
     let bd = i in
     let rec bb j =
       (if (j <= bd)
        then let g = o.(j) in
        let h = t.(j) in
        let f = ((max (g) (h))) in
        (
          o.(j) <- f;
          (bb (j + 1))
          )
        
        else (ba (i + 1))) in
       (bb bc)
     else let product = 1 in
     let y = 1 in
     let z = lim in
     let rec u k product =
       (if (k <= z)
        then let w = 1 in
        let x = o.(k) in
        let rec v l product =
          (if (l <= x)
           then let product = (product * k) in
           (v (l + 1) product)
           else (u (k + 1) product)) in
          (v w product)
        else (
               (Printf.printf "%d\n" product)
               )
        ) in
       (u y product)) in
    (ba be)

