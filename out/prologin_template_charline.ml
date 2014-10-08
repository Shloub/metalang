let programme_candidat tableau taille =
  let out0 = ref( 0 ) in
  for i = 0 to taille - 1 do
    out0 := (!out0) + int_of_char (tableau.(i)) * i;
    Printf.printf "%c" tableau.(i)
  done;
  Printf.printf "--\n";
  (!out0)

let () =
begin
  let taille = Scanf.scanf "%d " (fun x -> x) in
  let c = Array.init taille (fun _d ->
    let e = Scanf.scanf "%c" (fun v_0 -> v_0) in
    e) in
  Scanf.scanf " " (fun () -> ());
  let tableau = c in
  Printf.printf "%d\n" (programme_candidat tableau taille)
end
 