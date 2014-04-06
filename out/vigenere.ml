

let position_alphabet c =
  let i = int_of_char (c) in
  if i <= int_of_char ('Z') && i >= int_of_char ('A') then
    i - int_of_char ('A')
  else if i <= int_of_char ('z') && i >= int_of_char ('a') then
    i - int_of_char ('a')
  else
    -1

let of_position_alphabet c =
  char_of_int (c + int_of_char ('a'))

let crypte taille_cle cle taille message =
  for i = 0 to taille - 1 do
    let lettre = position_alphabet message.(i) in
    if lettre <> -1 then
      begin
        let addon = position_alphabet cle.(i mod taille_cle) in
        let new_ = (addon + lettre) mod 26 in
        message.(i) <- of_position_alphabet new_
      end
  done

let () =
begin
  let taille_cle = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let cle = Array.init taille_cle (fun _index ->
    let out_ = Scanf.scanf "%c" (fun x -> x) in
    out_) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let taille = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let message = Array.init taille (fun _index2 ->
    let out2 = Scanf.scanf "%c" (fun x -> x) in
    out2) in
  crypte taille_cle cle taille message;
  for i = 0 to taille - 1 do
    let a = message.(i) in
    Printf.printf "%c" a
  done;
  Printf.printf "\n"
end
 