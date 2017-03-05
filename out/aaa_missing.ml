(*
  Ce test a été généré par Metalang.
*)
exception Found_1 of int

let result len tab =
  try
  let tab2 = Array.init len (fun _i ->
    false) in
  for i1 = 0 to len - 1 do
    Printf.printf "%d " tab.(i1);
    tab2.(tab.(i1)) <- true
  done;
  Printf.printf "\n";
  for i2 = 0 to len - 1 do
    if not tab2.(i2) then
      raise (Found_1(i2))
  done;
  - 1
  with Found_1 (out) -> out
let () =
 let len = Scanf.scanf "%d " (fun len -> len) in
  Printf.printf "%d\n" len;
  let tab = Array.init len (fun _a ->
    let b = Scanf.scanf "%d " (fun b -> b) in
    b) in
  Printf.printf "%d\n" (result len tab) 
 