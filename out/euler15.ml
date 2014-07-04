let () =
begin
  let n = ref( 10 ) in
  (* normalement on doit mettre 20 mais là on se tape un overflow *)
  n := (!n) + 1;
  let tab = Array.init (!n) (fun _i ->
    let tab2 = Array.init (!n) (fun _j ->
      0) in
    tab2) in
  for l = 0 to (!n) - 1 do
    tab.((!n) - 1).(l) <- 1;
    tab.(l).((!n) - 1) <- 1
  done;
  for o = 2 to (!n) do
    let r = (!n) - o in
    for p = 2 to (!n) do
      let q = (!n) - p in
      tab.(r).(q) <- tab.(r + 1).(q) + tab.(r).(q + 1)
    done
  done;
  for m = 0 to (!n) - 1 do
    for k = 0 to (!n) - 1 do
      let a = tab.(m).(k) in
      Printf.printf "%d " a
    done;
    Printf.printf "\n"
  done;
  let b = tab.(0).(0) in
  Printf.printf "%d\n" b
end
 