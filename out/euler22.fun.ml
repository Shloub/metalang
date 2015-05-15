let score () =
  ( Scanf.scanf "%[\n \010]" (fun _ -> ());
    Scanf.scanf "%d"
    (fun len -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                  let sum = 0 in
                  let rec a i sum =
                    if i <= len
                    then Scanf.scanf "%c"
                    (fun c -> let sum = sum + (int_of_char (c)) - (int_of_char ('A')) + 1 in
                    (* 		print c print " " print sum print " "  *)
                    a (i + 1) sum)
                    else sum in
                    a 1 sum)))
let main =
  let sum = 0 in
  Scanf.scanf "%d"
  (fun n -> let rec b i sum =
              if i <= n
              then let sum = sum + i * score () in
              b (i + 1) sum
              else Printf.printf "%d\n" sum in
              b 1 sum)

