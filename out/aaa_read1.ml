let () =
begin
  let b = 12 in
  let c = Array.init b (fun _d ->
    let e = Scanf.scanf "%c" (fun v_0 -> v_0) in
    e) in
  Scanf.scanf " " (fun () -> ());
  let a = c in
  let str = a in
  for i = 0 to 11 do
    Printf.printf "%c" str.(i)
  done
end
 