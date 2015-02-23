let main =
  let sum = 0 in
  let rec a i sum =
    (if (i <= 999)
     then (if (((i mod 3) = 0) || ((i mod 5) = 0))
           then let sum = (sum + i) in
           (a (i + 1) sum)
           else (a (i + 1) sum))
     else (
            (Printf.printf "%d\n" sum)
            )
     ) in
    (a 0 sum)

