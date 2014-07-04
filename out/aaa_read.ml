(*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*)
let () =
begin
  let len = Scanf.scanf "%d " (fun v_0 -> ref v_0) in
  Printf.printf "%d=len\n" (!len);
  len := (!len) * 2;
  Printf.printf "len*2=%d\n" (!len);
  len := (!len) / 2;
  let _tab = Array.init (!len) (fun i ->
    let tmpi1 = Scanf.scanf "%d " (fun v_0 -> v_0) in
    Printf.printf "%d=>%d " i tmpi1;
    tmpi1) in
  Printf.printf "\n";
  let _tab2 = Array.init (!len) (fun i_ ->
    let tmpi2 = Scanf.scanf "%d " (fun v_0 -> v_0) in
    Printf.printf "%d==>%d " i_ tmpi2;
    tmpi2) in
  let strlen = Scanf.scanf "%d " (fun v_0 -> v_0) in
  Printf.printf "%d=strlen\n" strlen;
  let tab4 = Array.init strlen (fun _toto ->
    let tmpc = Scanf.scanf "%c" (fun v_0 -> v_0) in
    let c = ref( int_of_char (tmpc) ) in
    Printf.printf "%c:%d " tmpc (!c);
    if tmpc <> ' ' then
      c := (((!c) - int_of_char ('a')) + 13) mod 26 + int_of_char ('a');
    char_of_int ((!c))) in
  for j = 0 to strlen - 1 do
    let a = tab4.(j) in
    Printf.printf "%c" a
  done
end
 