let programme_candidat tableau x y =
  let out0 = ref( 0 ) in
  for i = 0 to y - 1 do
    for j = 0 to x - 1 do
      out0 := (!out0) + tableau.(i).(j) * (i * 2 + j)
    done
  done;
  (!out0)

let () =
 let taille_x, taille_y = Scanf.scanf "%d %d " (fun taille_x taille_y -> taille_x, taille_y) in
  let tableau = Array.init taille_y (fun a ->
    let c = Array.init taille_x (fun d ->
      let b = Scanf.scanf "%d " (fun b -> b) in
      b) in
    c) in
  Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y) 
 