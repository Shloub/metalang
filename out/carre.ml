let () =
begin
  let x = Scanf.scanf "%d " (fun x -> x) in
  let y = Scanf.scanf "%d " (fun x -> x) in
  let tab = Array.init y (fun _d ->
    let f = Array.init x (fun _g ->
      let e = Scanf.scanf "%d " (fun v_0 -> v_0) in
      e) in
    f) in
  for ix = 1 to x - 1 do
    for iy = 1 to y - 1 do
      if tab.(iy).(ix) = 1 then
        tab.(iy).(ix) <- (min ((min (tab.(iy).(ix - 1)) (tab.(iy - 1).(ix)))) (tab.(iy - 1).(ix - 1))) + 1
    done
  done;
  for jy = 0 to y - 1 do
    for jx = 0 to x - 1 do
      Printf.printf "%d " tab.(jy).(jx)
    done;
    Printf.printf "\n"
  done
end
 