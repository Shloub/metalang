let read_int () =
  Scanf.scanf "%d " (fun x -> x)

let read_char_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%c" (fun v_0 -> v_0) in
    t) in
  Scanf.scanf " " (fun () -> ());
  tab

let read_char_matrix x y =
  let tab = Array.init y (fun _z ->
    read_char_line x) in
  tab

let programme_candidat tableau taille_x taille_y =
  let out_ = ref( 0 ) in
  for i = 0 to taille_y - 1 do
    for j = 0 to taille_x - 1 do
      out_ := (!out_) + int_of_char (tableau.(i).(j)) * (i + j * 2);
      let a = tableau.(i).(j) in
      Printf.printf "%c" a
    done;
    Printf.printf "--\n"
  done;
  (!out_)

let () =
begin
  let taille_x = (read_int ()) in
  let taille_y = (read_int ()) in
  let tableau = read_char_matrix taille_x taille_y in
  let b = programme_candidat tableau taille_x taille_y in
  Printf.printf "%d\n" b
end
 