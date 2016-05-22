let rec pathfind_aux cache tab x y posX posY =
  if posX = x - 1 && posY = y - 1 then
    0
  else if posX < 0 || posY < 0 || posX >= x || posY >= y then
    x * y * 10
  else if tab.(posY).(posX) = '#' then
    x * y * 10
  else if cache.(posY).(posX) <> - 1 then
    cache.(posY).(posX)
  else
    begin
      cache.(posY).(posX) <- x * y * 10;
      let val1 = pathfind_aux cache tab x y (posX + 1) posY in
      let val2 = pathfind_aux cache tab x y (posX - 1) posY in
      let val3 = pathfind_aux cache tab x y posX (posY - 1) in
      let val4 = pathfind_aux cache tab x y posX (posY + 1) in
      let out0 = 1 + min (min (min (val1) (val2)) (val3)) (val4) in
      cache.(posY).(posX) <- out0;
      out0
    end

let pathfind tab x y =
  let cache = Array.init y (fun _i ->
    let tmp = Array.init x (fun _j ->
      - 1) in
    tmp) in
  pathfind_aux cache tab x y 0 0

let () =
begin
  let x = 0 in
  let y = 0 in
  let x, y = Scanf.scanf "%d %d " (fun x y -> x, y) in
  let tab = Array.init y (fun _i ->
    let tab2 = Array.init x (fun _j ->
      let tmp = ref( '\000' ) in
      Scanf.scanf "%c" (fun e -> tmp := e);
      (!tmp)) in
    Scanf.scanf " " ();
    tab2) in
  let result = pathfind tab x y in
  Printf.printf "%d" result
end
 