let main =
  let a = 1 in
  let b = 2 in
  let sum = 0 in
  let rec e a b sum =
    (if (a < 4000000)
     then let sum = (if ((a mod 2) = 0)
                     then let sum = (sum + a) in
                     sum
                     else sum) in
     let c = a in
     let a = b in
     let b = (b + c) in
     (e a b sum)
     else (
            (Printf.printf "%d" sum);
            (Printf.printf "%s" "\n")
            )
     ) in
    (e a b sum);;

