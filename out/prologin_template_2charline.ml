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
  let a = Scanf.scanf "%d " (fun x -> x) in
  let taille1 = a in
  let c = Array.init taille1 (fun _d ->
    let e = Scanf.scanf "%c" (fun v_0 -> v_0) in
    e) in
  Scanf.scanf " " (fun () -> ());
  let b = c in
  let tableau1 = b in
  let f = Scanf.scanf "%d " (fun x -> x) in
  let taille2 = f in
  let h = Array.init taille2 (fun _k ->
    let l = Scanf.scanf "%c" (fun v_0 -> v_0) in
    l) in
  Scanf.scanf " " (fun () -> ());
  let g = h in
  let tableau2 = g in
  Printf.printf "%d\n" (programme_candidat tableau1 taille1 tableau2 taille2)
end
 