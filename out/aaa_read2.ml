(*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*)
let () =
begin
  let len = Scanf.scanf "%d " (fun x -> x) in
  Printf.printf "%d=len\n" len;
  let d = Array.init len (fun _e ->
    let f = Scanf.scanf "%d " (fun v_0 -> v_0) in
    f) in
  let tab = d in
  for i = 0 to len - 1 do
    Printf.printf "%d=>%d " i tab.(i)
  done;
  Printf.printf "\n";
  let h = Array.init len (fun _k ->
    let l = Scanf.scanf "%d " (fun v_0 -> v_0) in
    l) in
  let tab2 = h in
  for i_ = 0 to len - 1 do
    Printf.printf "%d==>%d " i_ tab2.(i_)
  done;
  let strlen = Scanf.scanf "%d " (fun x -> x) in
  Printf.printf "%d=strlen\n" strlen;
  let p = Array.init strlen (fun _q ->
    let r = Scanf.scanf "%c" (fun v_0 -> v_0) in
    r) in
  Scanf.scanf " " (fun () -> ());
  let tab4 = p in
  for i3 = 0 to strlen - 1 do
    let tmpc = tab4.(i3) in
    let c = ref( int_of_char (tmpc) ) in
    Printf.printf "%c:%d " tmpc (!c);
    if tmpc <> ' ' then
      c := (((!c) - int_of_char ('a')) + 13) mod 26 + int_of_char ('a');
    tab4.(i3) <- char_of_int ((!c))
  done;
  for j = 0 to strlen - 1 do
    Printf.printf "%c" tab4.(j)
  done
end
 