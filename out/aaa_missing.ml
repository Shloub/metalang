
let read_int () =
  Scanf.scanf "%d " (fun x -> x)

let read_int_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%d " (fun v_0 -> v_0) in
    t) in
  tab

(*
  Ce test a été généré par Metalang.
*)
exception Found_1 of int

let result len tab =
  try
  let tab2 = Array.init len (fun _i ->
    false) in
  for i1 = 0 to len - 1 do
    tab2.(tab.(i1)) <- true
  done;
  for i2 = 0 to len - 1 do
    if not tab2.(i2) then
      raise (Found_1(i2))
  done;
  raise (Found_1(-1))
  with Found_1 (out) -> out

let () =
begin
  let len = (read_int ()) in
  Printf.printf "%d\n" len;
  let tab = read_int_line len in
  let a = result len tab in
  Printf.printf "%d" a
end
 