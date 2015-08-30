let rec chiffre c m =
  if c = 0
  then m mod 10
  else chiffre (c - 1) (m / 10)
let main =
  let m = 1 in
  let rec g a m =
    if a <= 9
    then let rec h f m =
           if f <= 9
           then let rec i d m =
                  if d <= 9
                  then let rec j c m =
                         if c <= 9
                         then let rec k b m =
                                if b <= 9
                                then let rec l e m =
                                       if e <= 9
                                       then let mul = a * d + 10 * (a * e + b * d) + 100 * (a * f + b * e + c * d) + 1000 * (c * e + b * f) + 10000 * c * f in
                                       if chiffre 0 mul = chiffre 5 mul && chiffre 1 mul = chiffre 4 mul && chiffre 2 mul = chiffre 3 mul
                                       then let m = (max (mul) (m)) in
                                       l (e + 1) m
                                       else l (e + 1) m
                                       else k (b + 1) m in
                                       l 0 m
                                else j (c + 1) m in
                                k 0 m
                         else i (d + 1) m in
                         j 1 m
                  else h (f + 1) m in
                  i 0 m
           else g (a + 1) m in
           h 1 m
    else Printf.printf "%d\n" m in
    g 0 m

