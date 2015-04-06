let main =
  let len = (Scanf.scanf "%d " (fun x -> x)) in
  (
    (Printf.printf "%d=len\n" len);
    let tab1 = (Array.init len (fun  a -> Scanf.scanf "%d"
    (fun  b -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 b
                 )
    ))) in
    let rec g i =
      (if (i <= (len - 1))
       then (
              (Printf.printf "%d=>%d\n" i tab1.(i));
              (g (i + 1))
              )
       
       else let len = (Scanf.scanf "%d " (fun x -> x)) in
       let tab2 = (Array.init (len - 1) (fun  c -> let e = (Array.init len (fun  f -> Scanf.scanf "%d"
       (fun  d -> (
                    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                    d
                    )
       ))) in
       e)) in
       let rec h i =
         (if (i <= (len - 2))
          then let rec k j =
                 (if (j <= (len - 1))
                  then (
                         (Printf.printf "%d " tab2.(i).(j));
                         (k (j + 1))
                         )
                  
                  else (
                         (Printf.printf "\n");
                         (h (i + 1))
                         )
                  ) in
                 (k 0)
          else ()) in
         (h 0)) in
      (g 0)
    )
  

