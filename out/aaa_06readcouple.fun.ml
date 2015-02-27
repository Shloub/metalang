let main =
  let rec h i =
    (if (i <= 3)
     then Scanf.scanf "%d"
     (fun  a -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  Scanf.scanf "%d"
                  (fun  b -> (
                               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                               (Printf.printf "a = %d b = %d\n" a b);
                               (h (i + 1))
                               )
                  )
                  )
     )
     else let l = (Array.init 10 (fun  c -> Scanf.scanf "%d"
     (fun  d -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  d
                  )
     ))) in
     let rec g j =
       (if (j <= 9)
        then (
               (Printf.printf "%d\n" l.(j));
               (g (j + 1))
               )
        
        else ()) in
       (g 0)) in
    (h 1)

