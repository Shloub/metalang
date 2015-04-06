let exp0 a e =
  let o = 1 in
  let rec b i o =
    (if (i <= e)
     then let o = (o * a) in
     (b (i + 1) o)
     else o) in
    (b 1 o)
let e t n =
  let rec c i n =
    (if (i <= 8)
     then (if (n >= (t.(i) * i))
           then let n = (n - (t.(i) * i)) in
           (c (i + 1) n)
           else let nombre = ((exp0 10 (i - 1)) + (n / i)) in
           let chiffre = ((i - 1) - (n mod i)) in
           ((nombre / (exp0 10 chiffre)) mod 10))
     else (- 1)) in
    (c 1 n)
let main =
  let t = (Array.init 9 (fun  i -> ((exp0 10 i) - (exp0 10 (i - 1))))) in
  let rec d i2 =
    (if (i2 <= 8)
     then (
            (Printf.printf "%d => %d\n" i2 t.(i2));
            (d (i2 + 1))
            )
     
     else let rec f j =
            (if (j <= 80)
             then (
                    (Printf.printf "%d" (e t j));
                    (f (j + 1))
                    )
             
             else (
                    (Printf.printf "\n");
                    let rec g k =
                      (if (k <= 50)
                       then (
                              (Printf.printf "%d" k);
                              (g (k + 1))
                              )
                       
                       else (
                              (Printf.printf "\n");
                              let rec h j2 =
                                (if (j2 <= 220)
                                 then (
                                        (Printf.printf "%d" (e t j2));
                                        (h (j2 + 1))
                                        )
                                 
                                 else (
                                        (Printf.printf "\n");
                                        let rec m k2 =
                                          (if (k2 <= 110)
                                           then (
                                                  (Printf.printf "%d" k2);
                                                  (m (k2 + 1))
                                                  )
                                           
                                           else (
                                                  (Printf.printf "\n");
                                                  let out0 = 1 in
                                                  let rec p l out0 =
                                                    (if (l <= 6)
                                                     then let puiss = (exp0 10 l) in
                                                     let v = (e t (puiss - 1)) in
                                                     let out0 = (out0 * v) in
                                                     (
                                                       (Printf.printf "10^%d=%d v=%d\n" l puiss v);
                                                       (p (l + 1) out0)
                                                       )
                                                     
                                                     else (Printf.printf "%d\n" out0)) in
                                                    (p 0 out0)
                                                  )
                                           ) in
                                          (m 90)
                                        )
                                 ) in
                                (h 169)
                              )
                       ) in
                      (g 1)
                    )
             ) in
            (f 0)) in
    (d 1)

