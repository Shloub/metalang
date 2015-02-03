module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    )
end

let rec pathfind_aux cache tab x y posX posY =
  let t () = () in
  (if ((posX = (x - 1)) && (posY = (y - 1)))
   then 0
   else let u () = (t ()) in
   (if ((((posX < 0) || (posY < 0)) || (posX >= x)) || (posY >= y))
    then ((x * y) * 10)
    else let v () = (u ()) in
    (if (tab.(posY).(posX) = '#')
     then ((x * y) * 10)
     else let w () = (v ()) in
     (if (cache.(posY).(posX) <> (- 1))
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
  let cache = (Array.init_withenv y (fun  i () -> let tmp = (Array.init_withenv x (fun  j () -> let s = (- 1) in
  ((), s)) ()) in
  let r = tmp in
  ((), r)) ()) in
  (pathfind_aux cache tab x y 0 0)
let main =
  let x = 0 in
  let y = 0 in
  Scanf.scanf "%d"
  (fun  bd -> let x = bd in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    Scanf.scanf "%d"
    (fun  bc -> let y = bc in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let tab = (Array.init_withenv y (fun  i () -> let tab2 = (Array.init_withenv x (fun  j () -> let tmp = '\000' in
      Scanf.scanf "%c"
      (fun  bb -> let tmp = bb in
      let ba = tmp in
      ((), ba))) ()) in
      (
        (Scanf.scanf "%[\n \010]" (fun _ -> ()));
        let z = tab2 in
        ((), z)
        )
      ) ()) in
      let result = (pathfind tab x y) in
      (Printf.printf "%d" result)
      )
    )
    )
  )

