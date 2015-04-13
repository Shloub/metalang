let main =
  let x = (Scanf.scanf "%d " (fun x -> x)) in
  let y = (Scanf.scanf "%d " (fun x -> x)) in
  let tab = (Array.init y (fun  d -> (Array.init x (fun  g -> Scanf.scanf "%d"
  (fun  e -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               e
               )
  ))))) in
  let rec h ix =
    (if (ix <= (x - 1))
     then let rec j iy =
            (if (iy <= (y - 1))
             then (if (tab.(iy).(ix) = 1)
                   then (
                          tab.(iy).(ix) <- (((min (((min (tab.(iy).((ix - 1))) (tab.((iy - 1)).(ix))))) (tab.((iy - 1)).((ix - 1))))) + 1);
                          (j (iy + 1))
                          )
                   
                   else (j (iy + 1)))
             else (h (ix + 1))) in
            (j 1)
     else let rec k jy =
            (if (jy <= (y - 1))
             then let rec l jx =
                    (if (jx <= (x - 1))
                     then (
                            (Printf.printf "%d " tab.(jy).(jx));
                            (l (jx + 1))
                            )
                     
                     else (
                            (Printf.printf "\n");
                            (k (jy + 1))
                            )
                     ) in
                    (l 0)
             else ()) in
            (k 0)) in
    (h 1)

