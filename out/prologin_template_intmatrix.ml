let programme_candidat tableau x y =
  let out0 = ref( 0 ) in
  for i = 0 to y - 1 do
    for j = 0 to x - 1 do
      out0 := (!out0) + tableau.(i).(j) * (i * 2 + j)
    done
  done;
  (!out0)

let () =
begin
  let taille_x = Scanf.scanf "%d " (fun x -> x) in
  let taille_y = Scanf.scanf "%d " (fun x -> x) in
  let tableau = Array.init taille_y (fun _k ->
    let p = Array.init taille_x (fun _m ->
      let o = Scanf.scanf "%d " (fun v_0 -> v_0) in
      o) in
    p) in
  Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y)
end
 