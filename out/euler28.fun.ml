let sumdiag =
  (fun n ->
      let nterms = ((n * 2) - 1) in
      let un = 1 in
      let sum = 1 in
      let b = 0 in
      let c = (nterms - 2) in
      let rec a i sum un =
        (if (i <= c)
         then let d = (2 * (1 + (i / 4))) in
         let un = (un + d) in
         (*  print int d print "=>" print un print " "  *)
         let sum = (sum + un) in
         (a (i + 1) sum un)
         else sum) in
        (a b sum un));;
let main =
  (Printf.printf "%d" (sumdiag 1001));;

