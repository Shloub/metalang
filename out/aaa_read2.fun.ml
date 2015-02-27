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
    let y = (len - 1) in
    let rec x i =
      (if (i <= y)
       then (
              (Printf.printf "%d=>%d " i tab.(i));
              (x (i + 1))
              )
       
       else (
              (Printf.printf "\n" );
              let tab2 = (Array.init len (fun  d -> Scanf.scanf "%d"
              (fun  e -> (
                           (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                           e
                           )
              ))) in
              let w = (len - 1) in
              let rec v i_ =
                (if (i_ <= w)
                 then (
                        (Printf.printf "%d==>%d " i_ tab2.(i_));
                        (v (i_ + 1))
                        )
                 
                 else let strlen = (Scanf.scanf "%d " (fun x -> x)) in
                 (
                   (Printf.printf "%d=strlen\n" strlen);
                   let tab4 = (Array.init strlen (fun  f -> Scanf.scanf "%c"
                   (fun  g -> g))) in
                   (
                     (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                     let u = (strlen - 1) in
                     let rec s i3 =
                       (if (i3 <= u)
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
                            (s (i3 + 1))
                            )
                          
                          )
                        
                        else let r = (strlen - 1) in
                        let rec q j =
                          (if (j <= r)
                           then (
                                  (Printf.printf "%c" tab4.(j));
                                  (q (j + 1))
                                  )
                           
                           else ()) in
                          (q 0)) in
                       (s 0)
                     )
                   
                   )
                 ) in
                (v 0)
              )
       ) in
      (x 0)
    )
  

