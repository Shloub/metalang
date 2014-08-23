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
  let taille1 = Scanf.scanf "%d " (fun x -> x) in
  let taille2 = Scanf.scanf "%d " (fun x -> x) in
  let d = Array.init taille1 (fun _e ->
    let f = Scanf.scanf "%c" (fun v_0 -> v_0) in
    f) in
  Scanf.scanf " " (fun () -> ());
  let tableau1 = d in
  let h = Array.init taille2 (fun _k ->
    let l = Scanf.scanf "%c" (fun v_0 -> v_0) in
    l) in
  Scanf.scanf " " (fun () -> ());
  let tableau2 = h in
  Printf.printf "%d\n" (programme_candidat tableau1 taille1 tableau2 taille2)
end
 