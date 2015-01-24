let () =
begin
  let c = Array.init 2 (fun _d ->
    let out0 = Scanf.scanf "%d " (fun v_0 -> v_0) in
    out0) in
  let t = c in
  Printf.printf "%d - %d\n" t.(0) t.(1)
end
 