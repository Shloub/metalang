let main =
  (* 
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
 *)
  let p = (Array.init 10 (fun  i -> ((((i * i) * i) * i) * i))) in
  let sum = 0 in
  let rec j a sum =
    (if (a <= 9)
     then let rec k b sum =
            (if (b <= 9)
             then let rec l c sum =
                    (if (c <= 9)
                     then let rec m d sum =
                            (if (d <= 9)
                             then let rec n e sum =
                                    (if (e <= 9)
                                     then let rec o f sum =
                                            (if (f <= 9)
                                             then let s = (((((p.(a) + p.(b)) + p.(c)) + p.(d)) + p.(e)) + p.(f)) in
                                             let r = (((((a + (b * 10)) + (c * 100)) + (d * 1000)) + (e * 10000)) + (f * 100000)) in
                                             (if ((s = r) && (r <> 1))
                                              then (
                                                     (Printf.printf "%d%d%d%d%d%d %d\n" f e d c b a r);
                                                     let sum = (sum + r) in
                                                     (o (f + 1) sum)
                                                     )
                                              
                                              else (o (f + 1) sum))
                                             else (n (e + 1) sum)) in
                                            (o 0 sum)
                                     else (m (d + 1) sum)) in
                                    (n 0 sum)
                             else (l (c + 1) sum)) in
                            (m 0 sum)
                     else (k (b + 1) sum)) in
                    (l 0 sum)
             else (j (a + 1) sum)) in
            (k 0 sum)
     else (Printf.printf "%d" sum)) in
    (j 0 sum)

