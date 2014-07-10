let read_int () =
  Scanf.scanf "%d " (fun x -> x)

let read_char_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%c" (fun v_0 -> v_0) in
    t) in
  Scanf.scanf " " (fun () -> ());
  tab

let programme_candidat tableau taille =
  let out_ = ref( 0 ) in
  for i = 0 to taille - 1 do
    out_ := (!out_) + int_of_char (tableau.(i)) * i;
    Printf.printf "%c" tableau.(i)
  done;
  Printf.printf "--\n";
  (!out_)

let () =
begin
  let a = Scanf.scanf "%d " (fun x -> x) in
  let taille = a in
  let c = taille in
  let d = Array.init c (fun _e ->
    let f = Scanf.scanf "%c" (fun v_0 -> v_0) in
    f) in
  Scanf.scanf " " (fun () -> ());
  let b = d in
  let tableau = b in
  Printf.printf "%d\n" (programme_candidat tableau taille)
end
 