let main =
  Scanf.scanf "%d"
  (fun  len -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 (Printf.printf "%d=len\n" len);
                 let len = (len * 2) in
                 (
                   (Printf.printf "len*2=%d\n" len);
                   let len = (len / 2) in
                   let tab = (Array.init len (fun  i -> Scanf.scanf "%d"
                   (fun  tmpi1 -> (
                                    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                    (Printf.printf "%d=>%d " i tmpi1);
                                    tmpi1
                                    )
                   ))) in
                   (
                     (Printf.printf "\n");
                     let tab2 = (Array.init len (fun  i_ -> Scanf.scanf "%d"
                     (fun  tmpi2 -> (
                                      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                      (Printf.printf "%d==>%d " i_ tmpi2);
                                      tmpi2
                                      )
                     ))) in
                     Scanf.scanf "%d"
                     (fun  strlen -> (
                                       (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                       (Printf.printf "%d=strlen\n" strlen);
                                       let tab4 = (Array.init strlen (fun  toto -> Scanf.scanf "%c"
                                       (fun  tmpc -> let c = (int_of_char (tmpc)) in
                                       (
                                         (Printf.printf "%c:%d " tmpc c);
                                         let c = (if (tmpc <> ' ')
                                                  then ((((c - (int_of_char ('a'))) + 13) mod 26) + (int_of_char ('a')))
                                                  else c) in
                                         (char_of_int (c))
                                         )
                                       ))) in
                                       let rec a j =
                                         (if (j <= (strlen - 1))
                                          then (
                                                 (Printf.printf "%c" tab4.(j));
                                                 (a (j + 1))
                                                 )
                                          
                                          else ()) in
                                         (a 0)
                                       )
                     )
                     )
                   
                   )
                 
                 )
  )

