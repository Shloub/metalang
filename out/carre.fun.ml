let main =
  let x = (Scanf.scanf "%d " (fun x -> x)) in
  let y = (Scanf.scanf "%d " (fun x -> x)) in
  let tab = (Array.init y (fun  d -> let f = (Array.init x (fun  g -> Scanf.scanf "%d"
  (fun  e -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               e
               )
  ))) in
  f)) in
  let rec m ix =
    (if (ix <= (x - 1))
     then let rec o iy =
            (if (iy <= (y - 1))
             then (if (tab.(iy).(ix) = 1)
                   then (
                          tab.(iy).(ix) <- (((min (((min (tab.(iy).((ix - 1))) (tab.((iy - 1)).(ix))))) (tab.((iy - 1)).((ix - 1))))) + 1);
                          (o (iy + 1))
                          )
                   
                   else (o (iy + 1)))
             else (m (ix + 1))) in
            (o 1)
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
    (m 1)

