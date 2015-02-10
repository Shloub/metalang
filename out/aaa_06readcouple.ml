let () =
begin
  for _i = 1 to 3 do
    let a, b = Scanf.scanf "%d %d " (fun v_0 v_1 -> v_0, v_1) in
    Printf.printf "a = %d b = %d\n" a b
  done;
  let l = Array.init 10 (fun _k ->
    let m = Scanf.scanf "%d " (fun v_0 -> v_0) in
    m) in
  for j = 0 to 9 do
    Printf.printf "%d\n" l.(j)
  done
end
 