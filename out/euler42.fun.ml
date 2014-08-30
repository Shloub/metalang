let is_triangular n =
  (* 
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
    *)
  let a = ((int_of_float (sqrt (float_of_int ( (n * 2)))))) in
  ((a * (a + 1)) = (n * 2))
let score () =
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    Scanf.scanf "%d"
    (fun  len -> (
                   (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                   let sum = 0 in
                   let g = 1 in
                   let h = len in
                   let rec f i sum =
                     (if (i <= h)
                      then Scanf.scanf "%c"
                      (fun  c -> let sum = (sum + (((int_of_char (c)) - (int_of_char ('A'))) + 1)) in
                      (* 		print c print " " print sum print " "  *)
                      (f (i + 1) sum))
                      else let e () = () in
                      (if (is_triangular sum)
                       then 1
                       else 0)) in
                     (f g sum)
                   )
    )
    )
  
let main =
  let o = 1 in
  let p = 55 in
  let rec m i =
    (if (i <= p)
     then (
            (if (is_triangular i)
             then (
                    (Printf.printf "%d " i)
                    )
             
             else ());
            (m (i + 1))
            )
     
     else (
            (Printf.printf "\n" );
            let sum = 0 in
            Scanf.scanf "%d"
            (fun  n -> let k = 1 in
            let l = n in
            let rec j i sum =
              (if (i <= l)
               then let sum = (sum + (score ())) in
               (j (i + 1) sum)
               else (
                      (Printf.printf "%d\n" sum)
                      )
               ) in
              (j k sum))
            )
     ) in
    (m o)

