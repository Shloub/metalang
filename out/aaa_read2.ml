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
  let a = Scanf.scanf "%d " (fun x -> x) in
  let len = a in
  Printf.printf "%d=len\n" len;
  let d = len in
  let e = Array.init d (fun _f ->
    let g = Scanf.scanf "%d " (fun v_0 -> v_0) in
    g) in
  let b = e in
  let tab = b in
  for i = 0 to len - 1 do
    Printf.printf "%d=>%d " i tab.(i)
  done;
  Printf.printf "\n";
  let k = len in
  let l = Array.init k (fun _m ->
    let o = Scanf.scanf "%d " (fun v_0 -> v_0) in
    o) in
  let h = l in
  let tab2 = h in
  for i_ = 0 to len - 1 do
    Printf.printf "%d==>%d " i_ tab2.(i_)
  done;
  let p = Scanf.scanf "%d " (fun x -> x) in
  let strlen = p in
  Printf.printf "%d=strlen\n" strlen;
  let r = strlen in
  let s = Array.init r (fun _u ->
    let v = Scanf.scanf "%c" (fun v_0 -> v_0) in
    v) in
  Scanf.scanf " " (fun () -> ());
  let q = s in
  let tab4 = q in
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
 