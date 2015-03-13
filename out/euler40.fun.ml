let exp0 a e =
  let o = 1 in
  let rec c i o =
    (if (i <= e)
     then let o = (o * a) in
     (c (i + 1) o)
     else o) in
    (c 1 o)
let e t n =
  let rec b i n =
    (if (i <= 8)
     then (if (n >= (t.(i) * i))
           then let n = (n - (t.(i) * i)) in
           (b (i + 1) n)
           else let nombre = ((exp0 10 (i - 1)) + (n / i)) in
           let chiffre = ((i - 1) - (n mod i)) in
           ((nombre / (exp0 10 chiffre)) mod 10))
     else (- 1)) in
    (b 1 n)
let main =
  let t = (Array.init 9 (fun  i -> ((exp0 10 i) - (exp0 10 (i - 1))))) in
  let rec r i2 =
    (if (i2 <= 8)
     then (
            (Printf.printf "%d => %d\n" i2 t.(i2));
            (r (i2 + 1))
            )
     
     else let rec q j =
            (if (j <= 80)
             then (
                    (Printf.printf "%d" (e t j));
                    (q (j + 1))
                    )
             
             else (
                    (Printf.printf "\n");
                    let rec p k =
                      (if (k <= 50)
                       then (
                              (Printf.printf "%d" k);
                              (p (k + 1))
                              )
                       
                       else (
                              (Printf.printf "\n");
                              let rec m j2 =
                                (if (j2 <= 220)
                                 then (
                                        (Printf.printf "%d" (e t j2));
                                        (m (j2 + 1))
                                        )
                                 
                                 else (
                                        (Printf.printf "\n");
                                        let rec h k2 =
                                          (if (k2 <= 110)
                                           then (
                                                  (Printf.printf "%d" k2);
                                                  (h (k2 + 1))
                                                  )
                                           
                                           else (
                                                  (Printf.printf "\n");
                                                  let out0 = 1 in
                                                  let rec g l out0 =
                                                    (if (l <= 6)
                                                     then let puiss = (exp0 10 l) in
                                                     let v = (e t (puiss - 1)) in
                                                     let out0 = (out0 * v) in
                                                     (
                                                       (Printf.printf "10^%d=%d v=%d\n" l puiss v);
                                                       (g (l + 1) out0)
                                                       )
                                                     
                                                     else (Printf.printf "%d\n" out0)) in
                                                    (g 0 out0)
                                                  )
                                           ) in
                                          (h 90)
                                        )
                                 ) in
                                (m 169)
                              )
                       ) in
                      (p 1)
                    )
             ) in
            (q 0)) in
    (r 1)

