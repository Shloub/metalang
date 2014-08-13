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

let rec max2 =
  (fun a b ->
      let q = (fun a b ->
                  ()) in
      (if (a > b)
       then a
       else b));;
let rec primesfactors =
  (fun n ->
      let c = (n + 1) in
      let tab = (Array.init_withenv c (fun i ->
                                          (fun (c, n) ->
                                              let f = 0 in
                                              ((c, n), f))) (c, n)) in
      let d = 2 in
      let rec h d c n =
        (if ((n <> 1) && ((d * d) <= n))
         then let p = (fun d c n ->
                          (h d c n)) in
         (if ((n mod d) = 0)
          then (tab.(d) <- (tab.(d) + 1); let n = (n / d) in
          (p d c n))
          else let d = (d + 1) in
          (p d c n))
         else (tab.(n) <- (tab.(n) + 1); tab)) in
        (h d c n));;
let rec main =
  let lim = 20 in
  let e = (lim + 1) in
  let o = (Array.init_withenv e (fun m ->
                                    (fun (e, lim) ->
                                        let r = 0 in
                                        ((e, lim), r))) (e, lim)) in
  let bd = 1 in
  let be = lim in
  let rec z i e lim =
    (if (i <= be)
     then let t = (primesfactors i) in
     let bb = 1 in
     let bc = i in
     let rec ba j t e lim =
       (if (j <= bc)
        then (o.(j) <- (max2 o.(j) t.(j)); (ba (j + 1) t e lim))
        else (z (i + 1) e lim)) in
       (ba bb t e lim)
     else let product = 1 in
     let x = 1 in
     let y = lim in
     let rec s k product e lim =
       (if (k <= y)
        then let v = 1 in
        let w = o.(k) in
        let rec u l product e lim =
          (if (l <= w)
           then let product = (product * k) in
           (u (l + 1) product e lim)
           else (s (k + 1) product e lim)) in
          (u v product e lim)
        else begin
               (Printf.printf "%d" product);
               (Printf.printf "%s" "\n")
               end
        ) in
       (s x product e lim)) in
    (z bd e lim);;

