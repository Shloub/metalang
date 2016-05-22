let () =
begin
  let x, y = Scanf.scanf "%d %d " (fun x y -> x, y) in
  let tab = Array.init y (fun _d ->
    let f = Array.init x (fun _g ->
      let e = Scanf.scanf "%d " (fun e -> e) in
      e) in
    f) in
  for ix = 1 to x - 1 do
    for iy = 1 to y - 1 do
      if tab.(iy).(ix) = 1 then
        tab.(iy).(ix) <- min (min (tab.(iy).(ix - 1)) (tab.(iy - 1).(ix))) (tab.(iy - 1).(ix - 1)) + 1
    done
  done;
  for jy = 0 to y - 1 do
    for jx = 0 to x - 1 do
      Printf.printf "%d " tab.(jy).(jx)
    done;
    Printf.printf "\n"
  done
end
 