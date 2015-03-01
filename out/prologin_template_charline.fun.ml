let programme_candidat tableau taille =
  let out0 = 0 in
  let d = (taille - 1) in
  let rec c i out0 =
    (if (i <= d)
     then let out0 = (out0 + ((int_of_char (tableau.(i))) * i)) in
     (
       (Printf.printf "%c" tableau.(i));
       (c (i + 1) out0)
       )
     
     else (
            (Printf.printf "--\n");
            out0
            )
     ) in
    (c 0 out0)
let main =
  let taille = (Scanf.scanf "%d " (fun x -> x)) in
  let tableau = (Array.init taille (fun  a -> Scanf.scanf "%c"
  (fun  b -> b))) in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    (Printf.printf "%d\n" (programme_candidat tableau taille))
    )
  

