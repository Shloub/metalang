let read_int () =
  Scanf.scanf "%d " (fun x -> x)

let read_char_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%c" (fun v_0 -> v_0) in
    t) in
  Scanf.scanf " " (fun () -> ());
  tab

let programme_candidat tableau1 taille1 tableau2 taille2 =
  let out_ = ref( 0 ) in
  for i = 0 to taille1 - 1 do
    out_ := (!out_) + int_of_char (tableau1.(i)) * i;
    Printf.printf "%c" tableau1.(i)
  done;
  Printf.printf "--\n";
  for j = 0 to taille2 - 1 do
    out_ := (!out_) + int_of_char (tableau2.(j)) * j * 100;
    Printf.printf "%c" tableau2.(j)
  done;
  Printf.printf "--\n";
  (!out_)

let () =
begin
  let taille1 = (read_int ()) in
  let tableau1 = read_char_line taille1 in
  let taille2 = (read_int ()) in
  let tableau2 = read_char_line taille2 in
  Printf.printf "%d\n" (programme_candidat tableau1 taille1 tableau2 taille2)
end
 