let rec dichofind len tab tofind a b =
  if a >= b - 1 then
    a
  else
    let c = (a + b) / 2 in
    if tab.(c) < tofind then
      dichofind len tab tofind c b
    else
      dichofind len tab tofind a c

exception Found_1 of int

let process len tab =
  try
  let size = Array.init len (fun j ->
    if j = 0 then
      0
    else
      len * 2) in
  for i = 0 to len - 1 do
    let k = dichofind len size tab.(i) 0 (len - 1) in
    if size.(k + 1) > tab.(i) then
      size.(k + 1) <- tab.(i)
  done;
  for l = 0 to len - 1 do
    Printf.printf "%d " size.(l)
  done;
  for m = 0 to len - 1 do
    let k = len - 1 - m in
    if size.(k) <> len * 2 then
      raise (Found_1(k))
  done;
  0
  with Found_1 (out) -> out

let () =
 let n = Scanf.scanf "%d " (fun n -> n) in
  for _i = 1 to n do
    let len = Scanf.scanf "%d " (fun len -> len) in
    let e = Array.init len (fun _f ->
      let d = Scanf.scanf "%d " (fun d -> d) in
      d) in
    Printf.printf "%d\n" (process len e)
  done 
 