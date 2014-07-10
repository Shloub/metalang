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
    let b = Array.init x (fun _c ->
      let d = Scanf.scanf "%c" (fun v_0 -> v_0) in
      d) in
    Scanf.scanf " " (fun () -> ());
    let a = b in
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
  let e = Scanf.scanf "%d " (fun x -> x) in
  let taille_x = e in
  let f = Scanf.scanf "%d " (fun x -> x) in
  let taille_y = f in
  let tableau = read_char_matrix taille_x taille_y in
  Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y)
end
 