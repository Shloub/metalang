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
  let len = (Scanf.scanf "%d " (fun x -> x)) in
  (
    (Printf.printf "%d=len\n" len);
    let tab = (Array.init_withenv len (fun  a () -> Scanf.scanf "%d"
    (fun  b -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 let h = b in
                 ((), h)
                 )
    )) ()) in
    let y = 0 in
    let z = (len - 1) in
    let rec x i =
      (if (i <= z)
       then (
              (Printf.printf "%d=>%d " i tab.(i));
              (x (i + 1))
              )
       
       else (
              (Printf.printf "\n" );
              let tab2 = (Array.init_withenv len (fun  d () -> Scanf.scanf "%d"
              (fun  e -> (
                           (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                           let k = e in
                           ((), k)
                           )
              )) ()) in
              let v = 0 in
              let w = (len - 1) in
              let rec u i_ =
                (if (i_ <= w)
                 then (
                        (Printf.printf "%d==>%d " i_ tab2.(i_));
                        (u (i_ + 1))
                        )
                 
                 else let strlen = (Scanf.scanf "%d " (fun x -> x)) in
                 (
                   (Printf.printf "%d=strlen\n" strlen);
                   let tab4 = (Array.init_withenv strlen (fun  f () -> Scanf.scanf "%c"
                   (fun  g -> let l = g in
                   ((), l))) ()) in
                   (
                     (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                     let r = 0 in
                     let s = (strlen - 1) in
                     let rec q i3 =
                       (if (i3 <= s)
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
                            (q (i3 + 1))
                            )
                          
                          )
                        
                        else let o = 0 in
                        let p = (strlen - 1) in
                        let rec m j =
                          (if (j <= p)
                           then (
                                  (Printf.printf "%c" tab4.(j));
                                  (m (j + 1))
                                  )
                           
                           else ()) in
                          (m o)) in
                       (q r)
                     )
                   
                   )
                 ) in
                (u v)
              )
       ) in
      (x y)
    )
  

