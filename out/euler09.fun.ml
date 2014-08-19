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
                  (Printf.printf "%d" a);
                  (Printf.printf "%s" "\n");
                  (Printf.printf "%d" b);
                  (Printf.printf "%s" "\n");
                  (Printf.printf "%d" c);
                  (Printf.printf "%s" "\n");
                  (Printf.printf "%d" ((a * b) * c));
                  (Printf.printf "%s" "\n")
                  )
           
           else ());
          (e (b + 1))
          )
        
        else (d (a + 1))) in
       (e f)
     else ()) in
    (d h)

