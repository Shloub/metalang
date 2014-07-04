let min2 a b =
  min a b

let min3 a b c =
  min2 (min2 a b) c

let min4 a b c d =
  min3 (min2 a b) c d

let read_int () =
  Scanf.scanf "%d " (fun x -> x)

let read_char_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%c" (fun v_0 -> v_0) in
    t) in
  Scanf.scanf " " (fun () -> ());
  tab

let read_char_matrix x y =
  let tab = Array.init y (fun _z ->
    read_char_line x) in
  tab

let rec pathfind_aux cache tab x y posX posY =
  if posX = x - 1 && posY = y - 1 then
    0
  else if posX < 0 or posY < 0 or posX >= x or posY >= y then
    x * y * 10
  else if tab.(posY).(posX) = '#' then
    x * y * 10
  else if cache.(posY).(posX) <> -1 then
    cache.(posY).(posX)
  else
    begin
      cache.(posY).(posX) <- x * y * 10;
      let val1 = pathfind_aux cache tab x y (posX + 1) posY in
      let val2 = pathfind_aux cache tab x y (posX - 1) posY in
      let val3 = pathfind_aux cache tab x y posX (posY - 1) in
      let val4 = pathfind_aux cache tab x y posX (posY + 1) in
      let out_ = 1 + min4 val1 val2 val3 val4 in
      cache.(posY).(posX) <- out_;
      out_
    end

let pathfind tab x y =
  let cache = Array.init y (fun i ->
    let tmp = Array.init x (fun j ->
      let e = tab.(i).(j) in
      Printf.printf "%c" e;
      -1) in
    Printf.printf "\n";
    tmp) in
  pathfind_aux cache tab x y 0 0

let () =
begin
  let x = (read_int ()) in
  let y = (read_int ()) in
  Printf.printf "%d %d\n" x y;
  let tab = read_char_matrix x y in
  let result = pathfind tab x y in
  Printf.printf "%d" result
end
 