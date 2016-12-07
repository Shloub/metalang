let programme_candidat tableau taille_x taille_y =
  let out0 = ref( 0 ) in
  for i = 0 to taille_y - 1 do
    for j = 0 to taille_x - 1 do
      out0 := (!out0) + (int_of_char (tableau.(i).(j))) * (i + j * 2);
      Printf.printf "%c" tableau.(i).(j)
    done;
    Printf.printf "--\n"
  done;
  (!out0)

let () =
 let taille_x, taille_y = Scanf.scanf "%d %d " (fun taille_x taille_y -> taille_x, taille_y) in
  let a = Array.init taille_y (fun b ->
    let d = Array.init taille_x (fun e ->
      let c = Scanf.scanf "%c" (fun c -> c) in
      c) in
    Scanf.scanf " " ();
    d) in
  let tableau = a in
  Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y) 
 