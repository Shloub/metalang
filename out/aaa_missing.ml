let rec read_int_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%d" (fun x -> x) in
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    t) in
  tab

(*
  Ce test a été généré par Metalang.
*)
exception Found_1 of int

let rec result len tab =
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
  let l0 = read_int_line 1 in
  let len = l0.(0) in
  let tab = read_int_line len in
  let a = result len tab in
  Printf.printf "%d" a
end
 