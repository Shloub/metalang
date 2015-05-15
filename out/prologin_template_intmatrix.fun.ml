let programme_candidat tableau x y =
  let out0 = 0 in
  let rec e i out0 =
    if i <= y - 1
    then let rec f j out0 =
           if j <= x - 1
           then let out0 = out0 + tableau.(i).(j) * (i * 2 + j) in
           f (j + 1) out0
           else e (i + 1) out0 in
           f 0 out0
    else out0 in
    e 0 out0
let main =
  let taille_x = (Scanf.scanf "%d " (fun x -> x)) in
  let taille_y = (Scanf.scanf "%d " (fun x -> x)) in
  let tableau = Array.init taille_y (fun a -> Array.init taille_x (fun d -> Scanf.scanf "%d"
  (fun b -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
              b)))) in
  Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y)

