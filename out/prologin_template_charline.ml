let programme_candidat tableau taille =
  let out0 = ref( 0 ) in
  for i = 0 to taille - 1 do
    out0 := (!out0) + (int_of_char (tableau.(i))) * i;
    Printf.printf "%c" tableau.(i)
  done;
  Printf.printf "--\n";
  (!out0)
let () =
 let taille = Scanf.scanf "%d " (fun taille -> taille) in
  let tableau = Array.init taille (fun a ->
    let b = Scanf.scanf "%c" (fun b -> b) in
    b) in
  Scanf.scanf " " ();
  Printf.printf "%d\n" (programme_candidat tableau taille) 
 