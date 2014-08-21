let main =
  (* 
	a + b + c = 1000 && a * a + b * b = c * c
	 *)
  let h = 1 in
  let i = 1000 in
  let rec d a =
    (if (a <= i)
     then let f = (a + 1) in
     let g = 1000 in
     let rec e b =
       (if (b <= g)
        then let c = ((1000 - a) - b) in
        let a2b2 = ((a * a) + (b * b)) in
        let cc = (c * c) in
        (
          (if ((cc = a2b2) && (c > a))
           then (
                  (Printf.printf "%d\n%d\n%d\n%d\n" a b c ((a * b) * c))
                  )
           
           else ());
          (e (b + 1))
          )
        
        else (d (a + 1))) in
       (e f)
     else ()) in
    (d h)

