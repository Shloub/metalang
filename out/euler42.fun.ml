let is_triangular n =
  (* 
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
    *)
  let a = ((int_of_float (sqrt (float_of_int ( n * 2))))) in
  a * (a + 1) = n * 2
let score () =
  ( Scanf.scanf "%[\n \010]" (fun _ -> ());
    Scanf.scanf "%d"
    (fun len -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                  let sum = 0 in
                  let rec b i sum =
                    if i <= len
                    then Scanf.scanf "%c"
                    (fun c -> let sum = sum + (int_of_char (c)) - (int_of_char ('A')) + 1 in
                    (* 		print c print " " print sum print " "  *)
                    b (i + 1) sum)
                    else if is_triangular sum
                         then 1
                         else 0 in
                    b 1 sum)))
let main =
  let rec d i =
    if i <= 55
    then if is_triangular i
         then ( Printf.printf "%d " i;
                d (i + 1))
         else d (i + 1)
    else ( Printf.printf "%s" "\n";
           let sum = 0 in
           Scanf.scanf "%d"
           (fun n -> let rec e i sum =
                       if i <= n
                       then let sum = sum + score () in
                       e (i + 1) sum
                       else Printf.printf "%d\n" sum in
                       e 1 sum)) in
    d 1

