(*
Ce test effectue un rot13 sur une chaine lue en entrée
*)
let () =
 let strlen = Scanf.scanf "%d " (fun strlen -> strlen) in
  let tab4 = Array.init strlen (fun _toto ->
    let tmpc = Scanf.scanf "%c" (fun tmpc -> tmpc) in
    let c = ref( (int_of_char (tmpc)) ) in
    if tmpc <> ' ' then
      c := ((!c) - (int_of_char ('a')) + 13) mod 26 + (int_of_char ('a'));
    (char_of_int ((!c)))) in
  for j = 0 to strlen - 1 do
    Printf.printf "%c" tab4.(j)
  done 
 