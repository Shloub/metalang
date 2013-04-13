let rec min2 a b =
  if a < b then
    a
  else
    b

let rec min3 a b c =
  min2 (min2 a b) c

let rec min4 a b c d =
  min3 (min2 a b) c d

let rec pathfind_aux cache tab x y posX posY =
  if (posX = (x - 1)) && (posY = (y - 1)) then
    0
  else if (((posX < 0) or (posY < 0)) or (posX >= x)) or (posY >= y) then
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

let rec pathfind tab x y =
  let cache = Array.init (y) (fun i ->
    let tmp = Array.init (x) (fun j ->
      -1) in
    tmp) in
  pathfind_aux cache tab x y 0 0

let () =
begin
  let x = ref( 0 ) in
  let y = ref( 0 ) in
  Scanf.scanf "%d" (fun value -> x := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Scanf.scanf "%d" (fun value -> y := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let tab = Array.init ((!y)) (fun i ->
    let tab2 = Array.init ((!x)) (fun j ->
      let tmp = ref( '\000' ) in
      Scanf.scanf "%c" (fun value -> tmp := value);
      (!tmp)) in
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    tab2) in
  let result = pathfind tab (!x) (!y) in
  Printf.printf "%d" (result)
end
 