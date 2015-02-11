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
                   let e = 1 in
                   let f = len in
                   let rec d i sum =
                     (if (i <= f)
                      then Scanf.scanf "%c"
                      (fun  c -> let sum = (sum + (((int_of_char (c)) - (int_of_char ('A'))) + 1)) in
                      (* 		print c print " " print sum print " "  *)
                      (d (i + 1) sum))
                      else let b () = () in
                      (if (is_triangular sum)
                       then 1
                       else 0)) in
                     (d e sum)
                   )
    )
    )
  
let main =
  let l = 1 in
  let m = 55 in
  let rec k i =
    (if (i <= m)
     then (
            (if (is_triangular i)
             then (
                    (Printf.printf "%d " i)
                    )
             
             else ());
            (k (i + 1))
            )
     
     else (
            (Printf.printf "\n" );
            let sum = 0 in
            Scanf.scanf "%d"
            (fun  n -> let h = 1 in
            let j = n in
            let rec g i sum =
              (if (i <= j)
               then let sum = (sum + (score ())) in
               (g (i + 1) sum)
               else (
                      (Printf.printf "%d\n" sum)
                      )
               ) in
              (g h sum))
            )
     ) in
    (k l)

