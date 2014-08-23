let read_int_matrix x y =
  let tab = Array.init y (fun _z ->
    let b = Array.init x (fun _c ->
      let d = Scanf.scanf "%d " (fun v_0 -> v_0) in
      d) in
    let a = b in
    a) in
  tab

let () =
begin
  let len = ref( Scanf.scanf "%d " (fun x -> x) ) in
  Printf.printf "%d=len\n" (!len);
  let g = Array.init (!len) (fun _h ->
    let k = Scanf.scanf "%d " (fun v_0 -> v_0) in
    k) in
  let tab1 = g in
  for i = 0 to (!len) - 1 do
    Printf.printf "%d=>%d\n" i tab1.(i)
  done;
  len := Scanf.scanf "%d " (fun x -> x);
  let tab2 = read_int_matrix (!len) ((!len) - 1) in
  for i = 0 to (!len) - 2 do
    for j = 0 to (!len) - 1 do
      Printf.printf "%d " tab2.(i).(j)
    done;
    Printf.printf "\n"
  done
end
 