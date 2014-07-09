let read_int () =
  Scanf.scanf "%d " (fun x -> x)

let read_int_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%d " (fun v_0 -> v_0) in
    t) in
  tab

let read_int_matrix x y =
  let tab = Array.init y (fun _z ->
    read_int_line x) in
  tab

let () =
begin
  let len = ref( (read_int ()) ) in
  Printf.printf "%d=len\n" (!len);
  let tab1 = read_int_line (!len) in
  for i = 0 to (!len) - 1 do
    Printf.printf "%d=>%d\n" i tab1.(i)
  done;
  len := (read_int ());
  let tab2 = read_int_matrix (!len) ((!len) - 1) in
  for i = 0 to (!len) - 2 do
    for j = 0 to (!len) - 1 do
      Printf.printf "%d " tab2.(i).(j)
    done;
    Printf.printf "\n"
  done
end
 