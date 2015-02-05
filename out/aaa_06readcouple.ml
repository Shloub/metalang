let () =
begin
  for _i = 1 to 3 do
    let a, b = Scanf.scanf "%d %d " (fun v_0 v_1 -> v_0, v_1) in
    Printf.printf "a = %d b = %d\n" a b
  done
end
 