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

let max2 a b =
  (max a b)
let primesfactors n =
  let c = (n + 1) in
  let tab = (Array.init_withenv c (fun  i () -> let f = 0 in
  ((), f)) ()) in
  let d = 2 in
  let rec h d n =
    (if ((n <> 1) && ((d * d) <= n))
     then ((fun  (d, n) -> (h d n)) (if ((n mod d) = 0)
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
    (h d n)
let main =
  let lim = 20 in
  let e = (lim + 1) in
  let o = (Array.init_withenv e (fun  m () -> let p = 0 in
  ((), p)) ()) in
  let bb = 1 in
  let bc = lim in
  let rec x i =
    (if (i <= bc)
     then let t = (primesfactors i) in
     let z = 1 in
     let ba = i in
     let rec y j =
       (if (j <= ba)
        then (
               o.(j) <- (max2 o.(j) t.(j));
               (y (j + 1))
               )
        
        else (x (i + 1))) in
       (y z)
     else let product = 1 in
     let v = 1 in
     let w = lim in
     let rec q k product =
       (if (k <= w)
        then let s = 1 in
        let u = o.(k) in
        let rec r l product =
          (if (l <= u)
           then let product = (product * k) in
           (r (l + 1) product)
           else (q (k + 1) product)) in
          (r s product)
        else (
               (Printf.printf "%d\n" product)
               )
        ) in
       (q v product)) in
    (x bb)

