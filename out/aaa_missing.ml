let read_int () =
  let out_ = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  out_

let read_int_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%d" (fun x -> x) in
    Scanf.scanf "%[\n \010]" (fun _ -> ());
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
  Printf.printf "%d" len;
  Printf.printf "\n";
  let tab = read_int_line len in
  let a = result len tab in
  Printf.printf "%d" a
end
 