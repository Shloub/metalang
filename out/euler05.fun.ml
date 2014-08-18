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

let max2 =
  (fun a b ->
      let p = (fun () -> ()) in
      (if (a > b)
       then a
       else b));;
let primesfactors =
  (fun n ->
      let c = (n + 1) in
      let tab = (Array.init_withenv c (fun i ->
                                          (fun () -> let f = 0 in
                                          ((), f))) ()) in
      let d = 2 in
      let rec h d n =
        (if ((n <> 1) && ((d * d) <= n))
         then ((fun (d, n) ->
                   (h d n)) (if ((n mod d) = 0)
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
        (h d n));;
let main =
  let lim = 20 in
  let e = (lim + 1) in
  let o = (Array.init_withenv e (fun m ->
                                    (fun () -> let q = 0 in
                                    ((), q))) ()) in
  let bc = 1 in
  let bd = lim in
  let rec y i =
    (if (i <= bd)
     then let t = (primesfactors i) in
     let ba = 1 in
     let bb = i in
     let rec z j =
       (if (j <= bb)
        then (
               o.(j) <- (max2 o.(j) t.(j));
               (z (j + 1))
               )
        
        else (y (i + 1))) in
       (z ba)
     else let product = 1 in
     let w = 1 in
     let x = lim in
     let rec r k product =
       (if (k <= x)
        then let u = 1 in
        let v = o.(k) in
        let rec s l product =
          (if (l <= v)
           then let product = (product * k) in
           (s (l + 1) product)
           else (r (k + 1) product)) in
          (s u product)
        else (
               (Printf.printf "%d" product);
               (Printf.printf "%s" "\n")
               )
        ) in
       (r w product)) in
    (y bc);;

