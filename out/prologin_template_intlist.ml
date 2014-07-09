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
  let taille = (read_int ()) in
  let tableau = read_int_line taille in
  Printf.printf "%d\n" (programme_candidat tableau taille)
end
 