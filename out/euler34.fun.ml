let main =
  let f = (Array.init 10 (fun  j -> 1)) in
  let rec r i =
    (if (i <= 9)
     then (
            f.(i) <- (f.(i) * (i * f.((i - 1))));
            (Printf.printf "%d " f.(i));
            (r (i + 1))
            )
     
     else let out0 = 0 in
     (
       (Printf.printf "\n");
       let rec l a out0 =
         (if (a <= 9)
          then let rec m b out0 =
                 (if (b <= 9)
                  then let rec n c out0 =
                         (if (c <= 9)
                          then let rec o d out0 =
                                 (if (d <= 9)
                                  then let rec p e out0 =
                                         (if (e <= 9)
                                          then let rec q g out0 =
                                                 (if (g <= 9)
                                                  then let sum = (((((f.(a) + f.(b)) + f.(c)) + f.(d)) + f.(e)) + f.(g)) in
                                                  let num = ((((((((((a * 10) + b) * 10) + c) * 10) + d) * 10) + e) * 10) + g) in
                                                  let sum = (if (a = 0)
                                                             then let sum = (sum - 1) in
                                                             (if (b = 0)
                                                              then let sum = (sum - 1) in
                                                              (if (c = 0)
                                                               then let sum = (sum - 1) in
                                                               (if (d = 0)
                                                                then let sum = (sum - 1) in
                                                                sum
                                                                else sum)
                                                               else sum)
                                                              else sum)
                                                             else sum) in
                                                  (if (((sum = num) && (sum <> 1)) && (sum <> 2))
                                                   then let out0 = (out0 + num) in
                                                   (
                                                     (Printf.printf "%d " num);
                                                     (q (g + 1) out0)
                                                     )
                                                   
                                                   else (q (g + 1) out0))
                                                  else (p (e + 1) out0)) in
                                                 (q 0 out0)
                                          else (o (d + 1) out0)) in
                                         (p 0 out0)
                                  else (n (c + 1) out0)) in
                                 (o 0 out0)
                          else (m (b + 1) out0)) in
                         (n 0 out0)
                  else (l (a + 1) out0)) in
                 (m 0 out0)
          else (Printf.printf "\n%d\n" out0)) in
         (l 0 out0)
       )
     ) in
    (r 1)

