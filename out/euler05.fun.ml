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
  let tab = (Array.init_withenv (n + 1) (fun  i () -> let c = 0 in
  ((), c)) ()) in
  let d = 2 in
  let rec e d n =
    (if ((n <> 1) && ((d * d) <= n))
     then ((fun  (d, n) -> (e d n)) (if ((n mod d) = 0)
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
    (e d n)
let main =
  let lim = 20 in
  let o = (Array.init_withenv (lim + 1) (fun  m () -> let f = 0 in
  ((), f)) ()) in
  let y = 1 in
  let z = lim in
  let rec u i =
    (if (i <= z)
     then let t = (primesfactors i) in
     let w = 1 in
     let x = i in
     let rec v j =
       (if (j <= x)
        then (
               o.(j) <- ((max (o.(j)) (t.(j))));
               (v (j + 1))
               )
        
        else (u (i + 1))) in
       (v w)
     else let product = 1 in
     let r = 1 in
     let s = lim in
     let rec g k product =
       (if (k <= s)
        then let p = 1 in
        let q = o.(k) in
        let rec h l product =
          (if (l <= q)
           then let product = (product * k) in
           (h (l + 1) product)
           else (g (k + 1) product)) in
          (h p product)
        else (
               (Printf.printf "%d\n" product)
               )
        ) in
       (g r product)) in
    (u y)

