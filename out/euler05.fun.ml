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

let primesfactors n =
  ((fun  (e, tab) -> (
                       e;
                       let d = 2 in
                       let rec f d n =
                         (if ((n <> 1) && ((d * d) <= n))
                          then ((fun  (d, n) -> (f d n)) (if ((n mod d) = 0)
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
                         (f d n)
                       )
  ) (Array.init_withenv (n + 1) (fun  i () -> let c = 0 in
  ((), c)) ()))
let main =
  let lim = 20 in
  ((fun  (h, o) -> (
                     h;
                     let ba = 1 in
                     let bb = lim in
                     let rec w i =
                       (if (i <= bb)
                        then let t = (primesfactors i) in
                        let y = 1 in
                        let z = i in
                        let rec x j =
                          (if (j <= z)
                           then (
                                  o.(j) <- ((max (o.(j)) (t.(j))));
                                  (x (j + 1))
                                  )
                           
                           else (w (i + 1))) in
                          (x y)
                        else let product = 1 in
                        let u = 1 in
                        let v = lim in
                        let rec p k product =
                          (if (k <= v)
                           then let r = 1 in
                           let s = o.(k) in
                           let rec q l product =
                             (if (l <= s)
                              then let product = (product * k) in
                              (q (l + 1) product)
                              else (p (k + 1) product)) in
                             (q r product)
                           else (
                                  (Printf.printf "%d\n" product)
                                  )
                           ) in
                          (p u product)) in
                       (w ba)
                     )
  ) (Array.init_withenv (lim + 1) (fun  m () -> let g = 0 in
  ((), g)) ()))

