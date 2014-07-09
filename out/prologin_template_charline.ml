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
  let taille = (read_int ()) in
  let tableau = read_char_line taille in
  Printf.printf "%d\n" (programme_candidat tableau taille)
end
 