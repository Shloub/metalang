let programme_candidat tableau taille =
  let out_ = ref( 0 ) in
  for i = 0 to taille - 1 do
    out_ := (!out_) + tableau.(i)
  done;
  (!out_)

let () =
begin
  let taille = Scanf.scanf "%d " (fun x -> x) in
  let c = Array.init taille (fun _d ->
    let e = Scanf.scanf "%d " (fun v_0 -> v_0) in
    e) in
  let tableau = c in
  Printf.printf "%d\n" (programme_candidat tableau taille)
end
 