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
    let rec r i =
      (if (i <= (len - 1))
       then (
              (Printf.printf "%d=>%d\n" i tab1.(i));
              (r (i + 1))
              )
       
       else let len = (Scanf.scanf "%d " (fun x -> x)) in
       let tab2 = (Array.init (len - 1) (fun  c -> let e = (Array.init len (fun  f -> Scanf.scanf "%d"
       (fun  d -> (
                    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                    d
                    )
       ))) in
       e)) in
       let rec m i =
         (if (i <= (len - 2))
          then let rec o j =
                 (if (j <= (len - 1))
                  then (
                         (Printf.printf "%d " tab2.(i).(j));
                         (o (j + 1))
                         )
                  
                  else (
                         (Printf.printf "\n");
                         (m (i + 1))
                         )
                  ) in
                 (o 0)
          else ()) in
         (m 0)) in
      (r 0)
    )
  

