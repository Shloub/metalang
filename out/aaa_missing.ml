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
  let a = Scanf.scanf "%d " (fun x -> x) in
  let len = a in
  Printf.printf "%d\n" len;
  let c = Array.init len (fun _d ->
    let e = Scanf.scanf "%d " (fun v_0 -> v_0) in
    e) in
  let b = c in
  let tab = b in
  Printf.printf "%d" (result len tab)
end
 