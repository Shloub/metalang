let main =
  let j = 1 in
  let k = 3 in
  let rec h i =
    (if (i <= k)
     then Scanf.scanf "%d"
     (fun  a -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  Scanf.scanf "%d"
                  (fun  b -> (
                               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                               Scanf.scanf "%d"
                               (fun  c -> (
                                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                            (Printf.printf "a = %d b = %dc =%d\n" a b c);
                                            (h (i + 1))
                                            )
                               )
                               )
                  )
                  )
     )
     else ()) in
    (h j)

