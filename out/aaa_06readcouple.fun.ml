let main =
  let rec e i =
    if i <= 3
    then Scanf.scanf "%d"
    (fun a -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                Scanf.scanf "%d"
                (fun b -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                            Printf.printf "a = %d b = %d\n" a b;
                            e (i + 1)))))
    else let l = Array.init 10 (fun c -> Scanf.scanf "%d"
    (fun d -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                d))) in
    let rec f j =
      if j <= 9
      then ( Printf.printf "%d\n" l.(j);
             f (j + 1))
      else () in
      f 0 in
    e 1

