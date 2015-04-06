let main =
  let str = (Array.init 12 (fun  a -> Scanf.scanf "%c"
  (fun  b -> b))) in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let rec c i =
      (if (i <= 11)
       then (
              (Printf.printf "%c" str.(i));
              (c (i + 1))
              )
       
       else ()) in
      (c 0)
    )
  

