let main =
  let sum = 0 in
  let b = 0 in
  let c = 999 in
  let rec a i sum =
    (if (i <= c)
     then let sum = (if (((i mod 3) = 0) || ((i mod 5) = 0))
                     then let sum = (sum + i) in
                     sum
                     else sum) in
     (a (i + 1) sum)
     else (
            (Printf.printf "%d" sum);
            (Printf.printf "%s" "\n")
            )
     ) in
    (a b sum);;

