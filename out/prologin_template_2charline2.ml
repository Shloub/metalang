let programme_candidat tableau1 taille1 tableau2 taille2 =
  let out0 = ref( 0 ) in
  for i = 0 to taille1 - 1 do
    out0 := (!out0) + int_of_char (tableau1.(i)) * i;
    Printf.printf "%c" tableau1.(i)
  done;
  Printf.printf "--\n";
  for j = 0 to taille2 - 1 do
    out0 := (!out0) + int_of_char (tableau2.(j)) * j * 100;
    Printf.printf "%c" tableau2.(j)
  done;
  Printf.printf "--\n";
  (!out0)

let () =
begin
  let taille1 = Scanf.scanf "%d " (fun x -> x) in
  let taille2 = Scanf.scanf "%d " (fun x -> x) in
  let tableau1 = Array.init taille1 (fun _a ->
    let b = Scanf.scanf "%c" (fun v_0 -> v_0) in
    b) in
  Scanf.scanf " " (fun () -> ());
  let tableau2 = Array.init taille2 (fun _c ->
    let d = Scanf.scanf "%c" (fun v_0 -> v_0) in
    d) in
  Scanf.scanf " " (fun () -> ());
  Printf.printf "%d\n" (programme_candidat tableau1 taille1 tableau2 taille2)
end
 