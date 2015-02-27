let result len tab =
  let tab2 = (Array.init len (fun  i -> false)) in
  let h = (len - 1) in
  let rec g i1 =
    (if (i1 <= h)
     then (
            (Printf.printf "%d " tab.(i1));
            tab2.(tab.(i1)) <- true;
            (g (i1 + 1))
            )
     
     else (
            (Printf.printf "\n" );
            let f = (len - 1) in
            let rec e i2 =
              (if (i2 <= f)
               then (if (not tab2.(i2))
                     then i2
                     else (e (i2 + 1)))
               else (- 1)) in
              (e 0)
            )
     ) in
    (g 0)
let main =
  let len = (Scanf.scanf "%d " (fun x -> x)) in
  (
    (Printf.printf "%d\n" len);
    let tab = (Array.init len (fun  a -> Scanf.scanf "%d"
    (fun  b -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 b
                 )
    ))) in
    (
      (Printf.printf "%d\n" (result len tab))
      )
    
    )
  

