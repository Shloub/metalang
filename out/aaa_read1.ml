let () =
begin
  let str = Array.init 12 (fun _a ->
    let b = Scanf.scanf "%c" (fun v_0 -> v_0) in
    b) in
  Scanf.scanf " " (fun () -> ());
  for i = 0 to 11 do
    Printf.printf "%c" str.(i)
  done
end
 