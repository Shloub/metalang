let main =
  let g = 1 in
  let h = 3 in
  let rec f i =
    (if (i <= h)
     then Scanf.scanf "%d"
     (fun  d -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  Scanf.scanf "%d"
                  (fun  e -> (
                               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                               let a = d
                               and b = e in
                               (
                                 (Printf.printf "a = %d b = %d\n" a b);
                                 (f (i + 1))
                                 )
                               
                               )
                  )
                  )
     )
     else ()) in
    (f g)

