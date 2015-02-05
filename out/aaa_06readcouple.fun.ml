let main =
  let g = 1 in
  let h = 3 in
  let rec f i =
    (if (i <= h)
     then Scanf.scanf "%d"
     (fun  a -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  Scanf.scanf "%d"
                  (fun  b -> (
                               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                               (Printf.printf "a = %d b = %d\n" a b);
                               (f (i + 1))
                               )
                  )
                  )
     )
     else ()) in
    (f g)

