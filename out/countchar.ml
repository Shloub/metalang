let nth tab tofind len =
  let out0 = ref( 0 ) in
  for i = 0 to len - 1 do
    if tab.(i) = tofind then
      out0 := (!out0) + 1
  done;
  (!out0)

let () =
begin
  let len = ref( 0 ) in
  Scanf.scanf "%d " (fun v_0 -> len := v_0);
  let tofind = ref( '\x00' ) in
  Scanf.scanf "%c " (fun v_0 -> tofind := v_0);
  let tab = Array.init (!len) (fun _i ->
    let tmp = ref( '\x00' ) in
    Scanf.scanf "%c" (fun v_0 -> tmp := v_0);
    (!tmp)) in
  let result = nth tab (!tofind) (!len) in
  Printf.printf "%d" result
end
 