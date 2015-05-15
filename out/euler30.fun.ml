let main =
  (* 
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
 *)
  let p = Array.init 10 (fun i -> i * i * i * i * i) in
  let sum = 0 in
  let rec g a sum =
    if a <= 9
    then let rec h b sum =
           if b <= 9
           then let rec j c sum =
                  if c <= 9
                  then let rec k d sum =
                         if d <= 9
                         then let rec l e sum =
                                if e <= 9
                                then let rec m f sum =
                                       if f <= 9
                                       then let s = p.(a) + p.(b) + p.(c) + p.(d) + p.(e) + p.(f) in
                                       let r = a + b * 10 + c * 100 + d * 1000 + e * 10000 + f * 100000 in
                                       if s = r && r <> 1
                                       then ( Printf.printf "%d%d%d%d%d%d %d\n" f e d c b a r;
                                              let sum = sum + r in
                                              m (f + 1) sum)
                                       else m (f + 1) sum
                                       else l (e + 1) sum in
                                       m 0 sum
                                else k (d + 1) sum in
                                l 0 sum
                         else j (c + 1) sum in
                         k 0 sum
                  else h (b + 1) sum in
                  j 0 sum
           else g (a + 1) sum in
           h 0 sum
    else Printf.printf "%d" sum in
    g 0 sum

