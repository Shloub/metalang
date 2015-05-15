let programme_candidat tableau taille_x taille_y =
  let out0 = 0 in
  let rec f i out0 =
    if i <= taille_y - 1
    then let rec g j out0 =
           if j <= taille_x - 1
           then let out0 = out0 + (int_of_char (tableau.(i).(j))) * (i + j * 2) in
           ( Printf.printf "%c" tableau.(i).(j);
             g (j + 1) out0)
           else ( Printf.printf "%s" "--\n";
                  f (i + 1) out0) in
           g 0 out0
    else out0 in
    f 0 out0
let main =
  let taille_x = (Scanf.scanf "%d " (fun x -> x)) in
  let taille_y = (Scanf.scanf "%d " (fun x -> x)) in
  let a = Array.init taille_y (fun b -> let d = Array.init taille_x (fun e -> Scanf.scanf "%c"
  (fun c -> c)) in
  ( Scanf.scanf "%[\n \010]" (fun _ -> ());
    d)) in
  let tableau = a in
  Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y)

