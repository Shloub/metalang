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
  let a = Scanf.scanf "%d " (fun x -> x) in
  let taille = a in
  let c = Array.init taille (fun _d ->
    let e = Scanf.scanf "%c" (fun v_0 -> v_0) in
    e) in
  Scanf.scanf " " (fun () -> ());
  let b = c in
  let tableau = b in
  Printf.printf "%d\n" (programme_candidat tableau taille)
end
 