let main =
  let x = (Scanf.scanf "%d " (fun x -> x)) in
  let y = (Scanf.scanf "%d " (fun x -> x)) in
  let tab = Array.init y (fun d -> Array.init x (fun g -> Scanf.scanf "%d"
  (fun e -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
              e)))) in
  let rec h ix =
    if ix <= x - 1
    then let rec l iy =
           if iy <= y - 1
           then if tab.(iy).(ix) = 1
                then ( tab.(iy).(ix) <- (min ((min (tab.(iy).(ix - 1)) (tab.(iy - 1).(ix)))) (tab.(iy - 1).(ix - 1))) + 1;
                       l (iy + 1))
                else l (iy + 1)
           else h (ix + 1) in
           l 1
    else let rec j jy =
           if jy <= y - 1
           then let rec k jx =
                  if jx <= x - 1
                  then ( Printf.printf "%d " tab.(jy).(jx);
                         k (jx + 1))
                  else ( Printf.printf "%s" "\n";
                         j (jy + 1)) in
                  k 0
           else () in
           j 0 in
    h 1

