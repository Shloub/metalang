let main =
  let rec k i =
    (if (i <= 3)
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
                                            (k (i + 1))
                                            )
                               )
                               )
                  )
                  )
     )
     else let l = (Array.init 10 (fun  d -> Scanf.scanf "%d"
     (fun  e -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  e
                  )
     ))) in
     let rec h j =
       (if (j <= 9)
        then (
               (Printf.printf "%d\n" l.(j));
               (h (j + 1))
               )
        
        else ()) in
       (h 0)) in
    (k 1)

