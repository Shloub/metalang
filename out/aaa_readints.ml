let read_int () =
  Scanf.scanf "%d " (fun x -> x)

let read_int_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%d " (fun v_0 -> v_0) in
    t) in
  tab

let read_int_matrix x y =
  let tab = Array.init y (fun _z ->
    let b = x in
    let c = Array.init b (fun _d ->
      let e = Scanf.scanf "%d " (fun v_0 -> v_0) in
      e) in
    let a = c in
    a) in
  tab

let () =
begin
  let f = Scanf.scanf "%d " (fun x -> x) in
  let len = ref( f ) in
  Printf.printf "%d=len\n" (!len);
  let h = (!len) in
  let k = Array.init h (fun _l ->
    let m = Scanf.scanf "%d " (fun v_0 -> v_0) in
    m) in
  let g = k in
  let tab1 = g in
  for i = 0 to (!len) - 1 do
    Printf.printf "%d=>%d\n" i tab1.(i)
  done;
  let o = Scanf.scanf "%d " (fun x -> x) in
  len := o;
  let tab2 = read_int_matrix (!len) ((!len) - 1) in
  for i = 0 to (!len) - 2 do
    for j = 0 to (!len) - 1 do
      Printf.printf "%d " tab2.(i).(j)
    done;
    Printf.printf "\n"
  done
end
 