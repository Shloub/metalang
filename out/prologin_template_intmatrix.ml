let programme_candidat tableau x y =
  let out_ = ref( 0 ) in
  for i = 0 to y - 1 do
    for j = 0 to x - 1 do
      out_ := (!out_) + tableau.(i).(j) * (i * 2 + j)
    done
  done;
  (!out_)

let () =
begin
  let taille_x = Scanf.scanf "%d " (fun x -> x) in
  let taille_y = Scanf.scanf "%d " (fun x -> x) in
  let h = Array.init taille_y (fun _k ->
    let l = Array.init taille_x (fun _m ->
      let o = Scanf.scanf "%d " (fun v_0 -> v_0) in
      o) in
    l) in
  let tableau = h in
  Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y)
end
 