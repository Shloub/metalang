module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    )
end

let main =
  Scanf.scanf "%d"
  (fun  len -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 (Printf.printf "%d=len\n" len);
                 let len = (len * 2) in
                 (
                   (Printf.printf "len*2=%d\n" len);
                   let len = (len / 2) in
                   let tab = (Array.init_withenv len (fun  i () -> Scanf.scanf "%d"
                   (fun  tmpi1 -> (
                                    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                    (Printf.printf "%d=>%d " i tmpi1);
                                    let a = tmpi1 in
                                    ((), a)
                                    )
                   )) ()) in
                   (
                     (Printf.printf "\n" );
                     let tab2 = (Array.init_withenv len (fun  i_ () -> Scanf.scanf "%d"
                     (fun  tmpi2 -> (
                                      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                      (Printf.printf "%d==>%d " i_ tmpi2);
                                      let b = tmpi2 in
                                      ((), b)
                                      )
                     )) ()) in
                     Scanf.scanf "%d"
                     (fun  strlen -> (
                                       (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                       (Printf.printf "%d=strlen\n" strlen);
                                       let tab4 = (Array.init_withenv strlen (fun  toto () -> Scanf.scanf "%c"
                                       (fun  tmpc -> let c = (int_of_char (tmpc)) in
                                       (
                                         (Printf.printf "%c:%d " tmpc c);
                                         let c = (if (tmpc <> ' ')
                                                  then let c = ((((c - (int_of_char ('a'))) + 13) mod 26) + (int_of_char ('a'))) in
                                                  c
                                                  else c) in
                                         let d = (char_of_int (c)) in
                                         ((), d)
                                         )
                                       )) ()) in
                                       let f = 0 in
                                       let g = (strlen - 1) in
                                       let rec e j =
                                         (if (j <= g)
                                          then (
                                                 (Printf.printf "%c" tab4.(j));
                                                 (e (j + 1))
                                                 )
                                          
                                          else ()) in
                                         (e f)
                                       )
                     )
                     )
                   
                   )
                 
                 )
  )

