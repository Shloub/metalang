let () =
begin
  let str = Array.init 12 (fun _d ->
    let e = Scanf.scanf "%c" (fun v_0 -> v_0) in
    e) in
  Scanf.scanf " " (fun () -> ());
  for i = 0 to 11 do
    Printf.printf "%c" str.(i)
  done
end
 