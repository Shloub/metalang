let main =
  (* 
	a + b + c = 1000 && a * a + b * b = c * c
	 *)
  let rec d a =
    (if (a <= 1000)
     then let rec e b =
            (if (b <= 1000)
             then let c = ((1000 - a) - b) in
             let a2b2 = ((a * a) + (b * b)) in
             let cc = (c * c) in
             (if ((cc = a2b2) && (c > a))
              then (
                     (Printf.printf "%d\n%d\n%d\n%d\n" a b c ((a * b) * c));
                     (e (b + 1))
                     )
              
              else (e (b + 1)))
             else (d (a + 1))) in
            (e (a + 1))
     else ()) in
    (d 1)

