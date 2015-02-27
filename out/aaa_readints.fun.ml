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
    let v = (len - 1) in
    let rec u i =
      (if (i <= v)
       then (
              (Printf.printf "%d=>%d\n" i tab1.(i));
              (u (i + 1))
              )
       
       else let len = (Scanf.scanf "%d " (fun x -> x)) in
       let tab2 = (Array.init (len - 1) (fun  c -> let e = (Array.init len (fun  f -> Scanf.scanf "%d"
       (fun  d -> (
                    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                    d
                    )
       ))) in
       e)) in
       let q = (len - 2) in
       let rec m i =
         (if (i <= q)
          then let p = (len - 1) in
          let rec o j =
            (if (j <= p)
             then (
                    (Printf.printf "%d " tab2.(i).(j));
                    (o (j + 1))
                    )
             
             else (
                    (Printf.printf "\n" );
                    (m (i + 1))
                    )
             ) in
            (o 0)
          else ()) in
         (m 0)) in
      (u 0)
    )
  

