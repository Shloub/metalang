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
  let rec q d n =
    (if ((n <> 1) && ((d * d) <= n))
     then ((fun  (d, n) -> (q d n)) (if ((n mod d) = 0)
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
    (q d n)
let main =
  let lim = 20 in
  let o = (Array.init_withenv (lim + 1) (fun  m () -> let r = 0 in
  ((), r)) ()) in
  let bd = 1 in
  let be = lim in
  let rec z i =
    (if (i <= be)
     then let t = (primesfactors i) in
     let bb = 1 in
     let bc = i in
     let rec ba j =
       (if (j <= bc)
        then (
               o.(j) <- ((max (o.(j)) (t.(j))));
               (ba (j + 1))
               )
        
        else (z (i + 1))) in
       (ba bb)
     else let product = 1 in
     let x = 1 in
     let y = lim in
     let rec s k product =
       (if (k <= y)
        then let v = 1 in
        let w = o.(k) in
        let rec u l product =
          (if (l <= w)
           then let product = (product * k) in
           (u (l + 1) product)
           else (s (k + 1) product)) in
          (u v product)
        else (
               (Printf.printf "%d\n" product)
               )
        ) in
       (s x product)) in
    (z bd)

