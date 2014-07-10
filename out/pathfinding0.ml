let min2 a b =
  min a b

let min3 a b c =
  min2 (min2 a b) c

let min4 a b c d =
  let f = min2 a b in
  let g = c in
  let h = d in
  let e = min2 (min2 f g) h in
  e

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
    let l = x in
    let m = Array.init l (fun _o ->
      let p = Scanf.scanf "%c" (fun v_0 -> v_0) in
      p) in
    Scanf.scanf " " (fun () -> ());
    let k = m in
    k) in
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
      let r = val1 in
      let s = val2 in
      let u = val3 in
      let v = val4 in
      let w = min2 r s in
      let ba = u in
      let bb = v in
      let bc = min2 (min2 w ba) bb in
      let q = bc in
      let out_ = 1 + q in
      cache.(posY).(posX) <- out_;
      out_
    end

let pathfind tab x y =
  let cache = Array.init y (fun i ->
    let tmp = Array.init x (fun j ->
      Printf.printf "%c" tab.(i).(j);
      -1) in
    Printf.printf "\n";
    tmp) in
  pathfind_aux cache tab x y 0 0

let () =
begin
  let bd = Scanf.scanf "%d " (fun x -> x) in
  let x = bd in
  let be = Scanf.scanf "%d " (fun x -> x) in
  let y = be in
  Printf.printf "%d %d\n" x y;
  let tab = read_char_matrix x y in
  let result = pathfind tab x y in
  Printf.printf "%d" result
end
 