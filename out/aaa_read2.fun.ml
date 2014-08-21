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

let read_int () =
  (Scanf.scanf "%d " (fun x -> x))
let read_int_line n =
  let tab = (Array.init_withenv n (fun  i () -> Scanf.scanf "%d"
  (fun  t -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let b = t in
               ((), b)
               )
  )) ()) in
  tab
let read_char_line n =
  let tab = (Array.init_withenv n (fun  i () -> Scanf.scanf "%c"
  (fun  t -> let a = t in
  ((), a))) ()) in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    tab
    )
  
let main =
  let len = (read_int ()) in
  (
    (Printf.printf "%d=len\n" len);
    let tab = (read_int_line len) in
    let q = 0 in
    let r = (len - 1) in
    let rec p i =
      (if (i <= r)
       then (
              (Printf.printf "%d=>%d " i tab.(i));
              (p (i + 1))
              )
       
       else (
              (Printf.printf "\n" );
              let tab2 = (read_int_line len) in
              let m = 0 in
              let o = (len - 1) in
              let rec l i_ =
                (if (i_ <= o)
                 then (
                        (Printf.printf "%d==>%d " i_ tab2.(i_));
                        (l (i_ + 1))
                        )
                 
                 else let strlen = (read_int ()) in
                 (
                   (Printf.printf "%d=strlen\n" strlen);
                   let tab4 = (read_char_line strlen) in
                   let h = 0 in
                   let k = (strlen - 1) in
                   let rec g i3 =
                     (if (i3 <= k)
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
                          (g (i3 + 1))
                          )
                        
                        )
                      
                      else let e = 0 in
                      let f = (strlen - 1) in
                      let rec d j =
                        (if (j <= f)
                         then (
                                (Printf.printf "%c" tab4.(j));
                                (d (j + 1))
                                )
                         
                         else ()) in
                        (d e)) in
                     (g h)
                   )
                 ) in
                (l m)
              )
       ) in
      (p q)
    )
  

