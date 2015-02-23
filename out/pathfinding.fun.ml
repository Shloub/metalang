module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let rec pathfind_aux cache tab x y posX posY =
  (if ((posX = (x - 1)) && (posY = (y - 1)))
   then 0
   else (if ((((posX < 0) || (posY < 0)) || (posX >= x)) || (posY >= y))
         then ((x * y) * 10)
         else (if (tab.(posY).(posX) = '#')
               then ((x * y) * 10)
               else (if (cache.(posY).(posX) <> (- 1))
                     then cache.(posY).(posX)
                     else (
                            cache.(posY).(posX) <- ((x * y) * 10);
                            let val1 = (pathfind_aux cache tab x y (posX + 1) posY) in
                            let val2 = (pathfind_aux cache tab x y (posX - 1) posY) in
                            let val3 = (pathfind_aux cache tab x y posX (posY - 1)) in
                            let val4 = (pathfind_aux cache tab x y posX (posY + 1)) in
                            let out0 = (1 + ((min (((min (((min (val1) (val2)))) (val3)))) (val4)))) in
                            (
                              cache.(posY).(posX) <- out0;
                              out0
                              )
                            
                            )
                     ))))
let pathfind tab x y =
  ((fun  (f, cache) -> (pathfind_aux cache tab x y 0 0)) (Array.init_withenv y (fun  i f -> ((fun  (h, tmp) -> let e = tmp in
  ((), e)) (Array.init_withenv x (fun  j h -> let g = (- 1) in
  ((), g)) ()))) ()))
let main =
  let x = 0 in
  let y = 0 in
  Scanf.scanf "%d"
  (fun  q -> let x = q in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    Scanf.scanf "%d"
    (fun  p -> let y = p in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      ((fun  (l, tab) -> let result = (pathfind tab x y) in
      (Printf.printf "%d" result)) (Array.init_withenv y (fun  i l -> ((fun  (n, tab2) -> 
      (
        (Scanf.scanf "%[\n \010]" (fun _ -> ()));
        let k = tab2 in
        ((), k)
        )
      ) (Array.init_withenv x (fun  j n -> let tmp = '\000' in
      Scanf.scanf "%c"
      (fun  o -> let tmp = o in
      let m = tmp in
      ((), m))) ()))) ()))
      )
    )
    )
  )

