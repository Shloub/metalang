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
      let h = (fun a b ->
                  ()) in
      (if (a > b)
       then a
       else b));;
let rec chiffre =
  (fun c m ->
      let g = (fun c m ->
                  ()) in
      (if (c = 0)
       then (m mod 10)
       else (chiffre (c - 1) (m / 10))));;
let rec main =
  let m = 1 in
  let ba = 0 in
  let bb = 9 in
  let rec i a m =
    (if (a <= bb)
     then let y = 1 in
     let z = 9 in
     let rec j f m =
       (if (f <= z)
        then let w = 0 in
        let x = 9 in
        let rec k d m =
          (if (d <= x)
           then let u = 1 in
           let v = 9 in
           let rec l c m =
             (if (c <= v)
              then let s = 0 in
              let t = 9 in
              let rec n b m =
                (if (b <= t)
                 then let q = 0 in
                 let r = 9 in
                 let rec o e m =
                   (if (e <= r)
                    then let mul = (((((a * d) + (10 * ((a * e) + (b * d)))) + (100 * (((a * f) + (b * e)) + (c * d)))) + (1000 * ((c * e) + (b * f)))) + ((10000 * c) * f)) in
                    let p = (fun mul m ->
                                (o (e + 1) m)) in
                    (if ((((chiffre 0 mul) = (chiffre 5 mul)) && ((chiffre 1 mul) = (chiffre 4 mul))) && ((chiffre 2 mul) = (chiffre 3 mul)))
                     then let m = (max2 mul m) in
                     (p mul m)
                     else (p mul m))
                    else (n (b + 1) m)) in
                   (o q m)
                 else (l (c + 1) m)) in
                (n s m)
              else (k (d + 1) m)) in
             (l u m)
           else (j (f + 1) m)) in
          (k w m)
        else (i (a + 1) m)) in
       (j y m)
     else begin
            (Printf.printf "%d" m);
            (Printf.printf "%s" "\n")
            end
     ) in
    (i ba m);;

