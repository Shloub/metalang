let programme_candidat tableau taille =
  let out0 = ref( 0 ) in
  for i = 0 to taille - 1 do
    out0 := (!out0) + tableau.(i)
  done;
  (!out0)

let () =
begin
  let taille = Scanf.scanf "%d " (fun x -> x) in
  let tableau = Array.init taille (fun _d ->
    let e = Scanf.scanf "%d " (fun v_0 -> v_0) in
    e) in
  Printf.printf "%d\n" (programme_candidat tableau taille)
end
 