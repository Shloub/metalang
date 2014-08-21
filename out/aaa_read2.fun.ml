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
  let a = (Scanf.scanf "%d " (fun x -> x)) in
  let len = a in
  (
    (Printf.printf "%d=len\n" len);
    let d = (Array.init_withenv len (fun  e () -> Scanf.scanf "%d"
    (fun  f -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 let s = f in
                 ((), s)
                 )
    )) ()) in
    let b = d in
    let tab = b in
    let bg = 0 in
    let bh = (len - 1) in
    let rec bf i =
      (if (i <= bh)
       then (
              (Printf.printf "%d=>%d " i tab.(i));
              (bf (i + 1))
              )
       
       else (
              (Printf.printf "\n" );
              let h = (Array.init_withenv len (fun  k () -> Scanf.scanf "%d"
              (fun  l -> (
                           (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                           let u = l in
                           ((), u)
                           )
              )) ()) in
              let g = h in
              let tab2 = g in
              let bd = 0 in
              let be = (len - 1) in
              let rec bc i_ =
                (if (i_ <= be)
                 then (
                        (Printf.printf "%d==>%d " i_ tab2.(i_));
                        (bc (i_ + 1))
                        )
                 
                 else let m = (Scanf.scanf "%d " (fun x -> x)) in
                 let strlen = m in
                 (
                   (Printf.printf "%d=strlen\n" strlen);
                   let p = (Array.init_withenv strlen (fun  q () -> Scanf.scanf "%c"
                   (fun  r -> let v = r in
                   ((), v))) ()) in
                   (
                     (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                     let o = p in
                     let tab4 = o in
                     let ba = 0 in
                     let bb = (strlen - 1) in
                     let rec z i3 =
                       (if (i3 <= bb)
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
                            (z (i3 + 1))
                            )
                          
                          )
                        
                        else let x = 0 in
                        let y = (strlen - 1) in
                        let rec w j =
                          (if (j <= y)
                           then (
                                  (Printf.printf "%c" tab4.(j));
                                  (w (j + 1))
                                  )
                           
                           else ()) in
                          (w x)) in
                       (z ba)
                     )
                   
                   )
                 ) in
                (bc bd)
              )
       ) in
      (bf bg)
    )
  

