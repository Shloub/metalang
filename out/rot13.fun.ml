let main =
  Scanf.scanf "%d"
  (fun  strlen -> (
                    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                    let tab4 = (Array.init strlen (fun  toto -> Scanf.scanf "%c"
                    (fun  tmpc -> let c = (int_of_char (tmpc)) in
                    let c = (if (tmpc <> ' ')
                             then let c = ((((c - (int_of_char ('a'))) + 13) mod 26) + (int_of_char ('a'))) in
                             c
                             else c) in
                    (char_of_int (c))))) in
                    let rec a j =
                      (if (j <= (strlen - 1))
                       then (
                              (Printf.printf "%c" tab4.(j));
                              (a (j + 1))
                              )
                       
                       else ()) in
                      (a 0)
                    )
  )

