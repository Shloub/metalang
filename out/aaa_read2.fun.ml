module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let main =
  let len = (Scanf.scanf "%d " (fun x -> x)) in
  (
    (Printf.printf "%d=len\n" len);
    ((fun  (k, tab) -> (
                         k;
                         let y = (len - 1) in
                         let rec x i =
                           (if (i <= y)
                            then (
                                   (Printf.printf "%d=>%d " i tab.(i));
                                   (x (i + 1))
                                   )
                            
                            else (
                                   (Printf.printf "\n" );
                                   ((fun  (m, tab2) -> (
                                                         m;
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
                                                              ((fun  (p, tab4) -> 
                                                              (
                                                                p;
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
                                                              ) (Array.init_withenv strlen (fun  f () -> Scanf.scanf "%c"
                                                              (fun  g -> let o = g in
                                                              ((), o))) ()))
                                                              )
                                                            ) in
                                                           (v 0)
                                                         )
                                   ) (Array.init_withenv len (fun  d () -> Scanf.scanf "%d"
                                   (fun  e -> (
                                                (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                                let l = e in
                                                ((), l)
                                                )
                                   )) ()))
                                   )
                            ) in
                           (x 0)
                         )
    ) (Array.init_withenv len (fun  a () -> Scanf.scanf "%d"
    (fun  b -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 let h = b in
                 ((), h)
                 )
    )) ()))
    )
  

