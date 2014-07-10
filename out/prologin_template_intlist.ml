let read_int () =
  Scanf.scanf "%d " (fun x -> x)

let read_int_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%d " (fun v_0 -> v_0) in
    t) in
  tab

let programme_candidat tableau taille =
  let out_ = ref( 0 ) in
  for i = 0 to taille - 1 do
    out_ := (!out_) + tableau.(i)
  done;
  (!out_)

let () =
begin
  let a = Scanf.scanf "%d " (fun x -> x) in
  let taille = a in
  let c = taille in
  let d = Array.init c (fun _e ->
    let f = Scanf.scanf "%d " (fun v_0 -> v_0) in
    f) in
  let b = d in
  let tableau = b in
  Printf.printf "%d\n" (programme_candidat tableau taille)
end
 