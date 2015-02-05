let () =
begin
  for _i = 1 to 3 do
    let d, e = Scanf.scanf "%d %d " (fun v_0 v_1 -> v_0, v_1) in
    let (a, b) = (d, e) in
    Printf.printf "a = %d b = %d\n" a b
  done
end
 