let main =
  let f = Array.init 10 (fun j -> 1) in
  let rec h i =
    if i <= 9
    then ( f.(i) <- f.(i) * i * f.(i - 1);
           Printf.printf "%d " f.(i);
           h (i + 1))
    else let out0 = 0 in
    ( Printf.printf "%s" "\n";
      let rec k a out0 =
        if a <= 9
        then let rec l b out0 =
               if b <= 9
               then let rec m c out0 =
                      if c <= 9
                      then let rec n d out0 =
                             if d <= 9
                             then let rec o e out0 =
                                    if e <= 9
                                    then let rec p g out0 =
                                           if g <= 9
                                           then let sum = f.(a) + f.(b) + f.(c) + f.(d) + f.(e) + f.(g) in
                                           let num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g in
                                           let sum = if a = 0
                                                     then let sum = sum - 1 in
                                                     if b = 0
                                                     then let sum = sum - 1 in
                                                     if c = 0
                                                     then let sum = sum - 1 in
                                                     if d = 0
                                                     then sum - 1
                                                     else sum
                                                     else sum
                                                     else sum
                                                     else sum in
                                           if sum = num && sum <> 1 && sum <> 2
                                           then let out0 = out0 + num in
                                           ( Printf.printf "%d " num;
                                             p (g + 1) out0)
                                           else p (g + 1) out0
                                           else o (e + 1) out0 in
                                           p 0 out0
                                    else n (d + 1) out0 in
                                    o 0 out0
                             else m (c + 1) out0 in
                             n 0 out0
                      else l (b + 1) out0 in
                      m 0 out0
               else k (a + 1) out0 in
               l 0 out0
        else Printf.printf "\n%d\n" out0 in
        k 0 out0) in
    h 1

