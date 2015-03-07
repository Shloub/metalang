exception Found_1 of bool

let devine0 nombre tab len =
  try
  let min0 = ref( tab.(0) ) in
  let max0 = ref( tab.(1) ) in
  for i = 2 to len - 1 do
    if tab.(i) > (!max0) || tab.(i) < (!min0) then
      raise (Found_1(false));
    if tab.(i) < nombre then
      min0 := tab.(i);
    if tab.(i) > nombre then
      max0 := tab.(i);
    if tab.(i) = nombre && len <> i + 1 then
      raise (Found_1(false))
  done;
  true
  with Found_1 (out) -> out

let () =
begin
  let nombre, len = Scanf.scanf "%d %d " (fun v_0 v_1 -> v_0, v_1) in
  let tab = Array.init len (fun _i ->
    let tmp = Scanf.scanf "%d " (fun v_0 -> v_0) in
    tmp) in
  let a = devine0 nombre tab len in
  if a then
    Printf.printf "True"
  else
    Printf.printf "False"
end
 