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
                        let out0 = 1 + (min ((min ((min (val1) (val2))) (val3))) (val4)) in
                        ( cache.(posY).(posX) <- out0;
                          out0))

let pathfind tab x y =
  let cache = Array.init y (fun i -> let tmp = Array.init x (fun j -> ( Printf.printf "%c" tab.(i).(j);
                                                                        - 1)) in
  ( Printf.printf "%s" "\n";
    tmp)) in
  pathfind_aux cache tab x y 0 0

let main =
  let x = (Scanf.scanf "%d " (fun x -> x)) in
  let y = (Scanf.scanf "%d " (fun x -> x)) in
  ( Printf.printf "%d %d\n" x y;
    let e = Array.init y (fun f -> let h = Array.init x (fun k -> Scanf.scanf "%c"
    (fun g -> g)) in
    ( Scanf.scanf "%[\n \010]" (fun _ -> ());
      h)) in
    let tab = e in
    let result = pathfind tab x y in
    Printf.printf "%d" result)

