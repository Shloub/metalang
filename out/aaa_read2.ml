


let read_int () =
  Scanf.scanf "%d " (fun x -> x)

let read_int_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%d " (fun v_0 -> v_0) in
    t) in
  tab

let read_char_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%c" (fun v_0 -> v_0) in
    t) in
  Scanf.scanf " " (fun () -> ());
  tab

(*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*)
let () =
begin
  let len = (read_int ()) in
  Printf.printf "%d=len\n" len;
  let tab = read_int_line len in
  for i = 0 to len - 1 do
    Printf.printf "%d=>" i;
    let a = tab.(i) in
    Printf.printf "%d " a
  done;
  Printf.printf "\n";
  let tab2 = read_int_line len in
  for i_ = 0 to len - 1 do
    Printf.printf "%d==>" i_;
    let b = tab2.(i_) in
    Printf.printf "%d " b
  done;
  let strlen = (read_int ()) in
  Printf.printf "%d=strlen\n" strlen;
  let tab4 = read_char_line strlen in
  for i3 = 0 to strlen - 1 do
    let tmpc = tab4.(i3) in
    let c = ref( int_of_char (tmpc) ) in
    Printf.printf "%c:%d " tmpc (!c);
    if tmpc <> ' ' then
      c := (((!c) - int_of_char ('a')) + 13) mod 26 + int_of_char ('a');
    tab4.(i3) <- char_of_int ((!c))
  done;
  for j = 0 to strlen - 1 do
    let d = tab4.(j) in
    Printf.printf "%c" d
  done
end
 