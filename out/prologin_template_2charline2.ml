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
  let b = Scanf.scanf "%d " (fun x -> x) in
  let taille2 = b in
  let d = taille1 in
  let e = Array.init d (fun _f ->
    let g = Scanf.scanf "%c" (fun v_0 -> v_0) in
    g) in
  Scanf.scanf " " (fun () -> ());
  let c = e in
  let tableau1 = c in
  let k = taille2 in
  let l = Array.init k (fun _m ->
    let o = Scanf.scanf "%c" (fun v_0 -> v_0) in
    o) in
  Scanf.scanf " " (fun () -> ());
  let h = l in
  let tableau2 = h in
  Printf.printf "%d\n" (programme_candidat tableau1 taille1 tableau2 taille2)
end
 