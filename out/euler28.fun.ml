let sumdiag n =
  let nterms = ((n * 2) - 1) in
  let un = 1 in
  let sum = 1 in
  let b = (nterms - 2) in
  let rec a i sum un =
    (if (i <= b)
     then let d = (2 * (1 + (i / 4))) in
     let un = (un + d) in
     (*  print int d print "=>" print un print " "  *)
     let sum = (sum + un) in
     (a (i + 1) sum un)
     else sum) in
    (a 0 sum un)
let main =
  (Printf.printf "%d" (sumdiag 1001))

