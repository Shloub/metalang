let position_alphabet c =
  let i = (int_of_char (c)) in
  if i <= (int_of_char ('Z')) && i >= (int_of_char ('A')) then
    i - (int_of_char ('A'))
  else
    if i <= (int_of_char ('z')) && i >= (int_of_char ('a')) then
      i - (int_of_char ('a'))
    else
      - 1
let of_position_alphabet c =
  (char_of_int (c + (int_of_char ('a'))))
let crypte taille_cle cle taille message =
  for i = 0 to taille - 1 do
    let lettre = position_alphabet message.(i) in
    if lettre <> - 1 then
      let addon = position_alphabet cle.(i mod taille_cle) in
      let new0 = (addon + lettre) mod 26 in
      message.(i) <- of_position_alphabet new0
  done
let () =
 let taille_cle = Scanf.scanf "%d " (fun taille_cle -> taille_cle) in
  let cle = Array.init taille_cle (fun _index ->
    let out0 = Scanf.scanf "%c" (fun out0 -> out0) in
    out0) in
  let taille = Scanf.scanf " %d " (fun taille -> taille) in
  let message = Array.init taille (fun _index2 ->
    let out2 = Scanf.scanf "%c" (fun out2 -> out2) in
    out2) in
  crypte taille_cle cle taille message;
  for i = 0 to taille - 1 do
    Printf.printf "%c" message.(i)
  done;
  Printf.printf "\n" 
 