let nth tab tofind len =
  let out0 = ref( 0 ) in
  for i = 0 to len - 1 do
    if tab.(i) = tofind then
      out0 := (!out0) + 1
  done;
  (!out0)
let () =
 let len = 0 in
  let len = Scanf.scanf "%d " (fun len -> len) in
  let tofind = '\000' in
  let tofind = Scanf.scanf "%c " (fun tofind -> tofind) in
  let tab = Array.init len (fun _i ->
    let tmp = ref( '\000' ) in
    Scanf.scanf "%c" (fun c -> tmp := c);
    (!tmp)) in
  let result = nth tab tofind len in
  Printf.printf "%d" result 
 