let () =
begin
  for _i = 1 to 3 do
    let a, b, c = Scanf.scanf "%d %d %d " (fun v_0 v_1 v_2 -> v_0, v_1, v_2) in
    Printf.printf "a = %d b = %dc =%d\n" a b c
  done;
  let l = Array.init 10 (fun _o ->
    let p = Scanf.scanf "%d " (fun v_0 -> v_0) in
    p) in
  for j = 0 to 9 do
    Printf.printf "%d\n" l.(j)
  done
end
 