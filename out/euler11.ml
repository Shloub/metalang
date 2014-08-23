let max2 a b =
  max a b

let read_int_matrix x y =
  let tab = Array.init y (fun _z ->
    let d = Array.init x (fun _e ->
      let f = Scanf.scanf "%d " (fun v_0 -> v_0) in
      f) in
    let c = d in
    c) in
  tab

let rec find n m x y dx dy =
  if x < 0 or x = 20 or y < 0 or y = 20 then
    -1
  else if n = 0 then
    1
  else
    m.(y).(x) * find (n - 1) m (x + dx) (y + dy) dx dy

let () =
begin
  let directions = Array.init 8 (fun i ->
    if i = 0 then
      (0, 1)
    else if i = 1 then
      (1, 0)
    else if i = 2 then
      (0, -1)
    else if i = 3 then
      (-1, 0)
    else if i = 4 then
      (1, 1)
    else if i = 5 then
      (1, -1)
    else if i = 6 then
      (-1, 1)
    else
      (-1, -1)) in
  let max_ = ref( 0 ) in
  let m = read_int_matrix 20 20 in
  for j = 0 to 7 do
    let (dx, dy) = directions.(j) in
    for x = 0 to 19 do
      for y = 0 to 19 do
        max_ := max2 (!max_) (find 4 m x y dx dy)
      done
    done
  done;
  Printf.printf "%d\n" (!max_)
end
 