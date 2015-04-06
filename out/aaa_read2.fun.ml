let main =
  let len = (Scanf.scanf "%d " (fun x -> x)) in
  (
    (Printf.printf "%d=len\n" len);
    let tab = (Array.init len (fun  a -> Scanf.scanf "%d"
    (fun  b -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 b
                 )
    ))) in
    let rec h i =
      (if (i <= (len - 1))
       then (
              (Printf.printf "%d=>%d " i tab.(i));
              (h (i + 1))
              )
       
       else (
              (Printf.printf "\n");
              let tab2 = (Array.init len (fun  d -> Scanf.scanf "%d"
              (fun  e -> (
                           (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                           e
                           )
              ))) in
              let rec k i_ =
                (if (i_ <= (len - 1))
                 then (
                        (Printf.printf "%d==>%d " i_ tab2.(i_));
                        (k (i_ + 1))
                        )
                 
                 else let strlen = (Scanf.scanf "%d " (fun x -> x)) in
                 (
                   (Printf.printf "%d=strlen\n" strlen);
                   let tab4 = (Array.init strlen (fun  f -> Scanf.scanf "%c"
                   (fun  g -> g))) in
                   (
                     (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                     let rec l i3 =
                       (if (i3 <= (strlen - 1))
                        then let tmpc = tab4.(i3) in
                        let c = (int_of_char (tmpc)) in
                        (
                          (Printf.printf "%c:%d " tmpc c);
                          let c = (if (tmpc <> ' ')
                                   then let c = ((((c - (int_of_char ('a'))) + 13) mod 26) + (int_of_char ('a'))) in
                                   c
                                   else c) in
                          (
                            tab4.(i3) <- (char_of_int (c));
                            (l (i3 + 1))
                            )
                          
                          )
                        
                        else let rec m j =
                               (if (j <= (strlen - 1))
                                then (
                                       (Printf.printf "%c" tab4.(j));
                                       (m (j + 1))
                                       )
                                
                                else ()) in
                               (m 0)) in
                       (l 0)
                     )
                   
                   )
                 ) in
                (k 0)
              )
       ) in
      (h 0)
    )
  

