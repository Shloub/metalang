let rec pathfind_aux cache tab x y posX posY =
  if posX = x - 1 && posY = y - 1
  then 0
  else if posX < 0 || posY < 0 || posX >= x || posY >= y
       then x * y * 10
       else if tab.(posY).(posX) = '#'
            then x * y * 10
            else if cache.(posY).(posX) <> - 1
                 then cache.(posY).(posX)
                 else ( cache.(posY).(posX) <- x * y * 10;
                        let val1 = pathfind_aux cache tab x y (posX + 1) posY in
                        let val2 = pathfind_aux cache tab x y (posX - 1) posY in
                        let val3 = pathfind_aux cache tab x y posX (posY - 1) in
                        let val4 = pathfind_aux cache tab x y posX (posY + 1) in
                        let out0 = 1 + ((min (((min (((min (val1) (val2)))) (val3)))) (val4))) in
                        ( cache.(posY).(posX) <- out0;
                          out0))
let pathfind tab x y =
  let cache = Array.init y (fun i -> Array.init x (fun j -> - 1)) in
  pathfind_aux cache tab x y 0 0
let main =
  let x = 0 in
  let y = 0 in
  Scanf.scanf "%d"
  (fun e -> let x = e in
  ( Scanf.scanf "%[\n \010]" (fun _ -> ());
    Scanf.scanf "%d"
    (fun f -> let y = f in
    ( Scanf.scanf "%[\n \010]" (fun _ -> ());
      let tab = Array.init y (fun i -> let tab2 = Array.init x (fun j -> let tmp = '\000' in
      Scanf.scanf "%c"
      (fun g -> g)) in
      ( Scanf.scanf "%[\n \010]" (fun _ -> ());
        tab2)) in
      let result = pathfind tab x y in
      Printf.printf "%d" result))))

