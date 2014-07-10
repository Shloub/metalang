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
    let b = x in
    let c = Array.init b (fun _d ->
      let e = Scanf.scanf "%c" (fun v_0 -> v_0) in
      e) in
    Scanf.scanf " " (fun () -> ());
    let a = c in
    a) in
  tab

let programme_candidat tableau taille_x taille_y =
  let out_ = ref( 0 ) in
  for i = 0 to taille_y - 1 do
    for j = 0 to taille_x - 1 do
      out_ := (!out_) + int_of_char (tableau.(i).(j)) * (i + j * 2);
      Printf.printf "%c" tableau.(i).(j)
    done;
    Printf.printf "--\n"
  done;
  (!out_)

let () =
begin
  let f = Scanf.scanf "%d " (fun x -> x) in
  let taille_x = f in
  let g = Scanf.scanf "%d " (fun x -> x) in
  let taille_y = g in
  let tableau = read_char_matrix taille_x taille_y in
  Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y)
end
 