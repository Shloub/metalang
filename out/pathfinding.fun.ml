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

let min2 a b =
  (min a b)
let rec pathfind_aux cache tab x y posX posY =
  let n () = () in
  (if ((posX = (x - 1)) && (posY = (y - 1)))
   then 0
   else let o () = (n ()) in
   (if ((((posX < 0) || (posY < 0)) || (posX >= x)) || (posY >= y))
    then ((x * y) * 10)
    else let p () = (o ()) in
    (if (tab.(posY).(posX) = '#')
     then ((x * y) * 10)
     else let q () = (p ()) in
     (if (cache.(posY).(posX) <> (- 1))
      then cache.(posY).(posX)
      else (
             cache.(posY).(posX) <- ((x * y) * 10);
             let val1 = (pathfind_aux cache tab x y (posX + 1) posY) in
             let val2 = (pathfind_aux cache tab x y (posX - 1) posY) in
             let val3 = (pathfind_aux cache tab x y posX (posY - 1)) in
             let val4 = (pathfind_aux cache tab x y posX (posY + 1)) in
             let h = (min2 val1 val2) in
             let k = (min2 (min2 h val3) val4) in
             let g = k in
             let out_ = (1 + g) in
             (
               cache.(posY).(posX) <- out_;
               out_
               )
             
             )
      ))))
let pathfind tab x y =
  let cache = (Array.init_withenv y (fun  i () -> let tmp = (Array.init_withenv x (fun  j () -> let m = (- 1) in
  ((), m)) ()) in
  let l = tmp in
  ((), l)) ()) in
  (pathfind_aux cache tab x y 0 0)
let main =
  let x = 0 in
  let y = 0 in
  Scanf.scanf "%d"
  (fun  v -> let x = v in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    Scanf.scanf "%d"
    (fun  u -> let y = u in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let tab = (Array.init_withenv y (fun  i () -> let tab2 = (Array.init_withenv x (fun  j () -> let tmp = '\000' in
      Scanf.scanf "%c"
      (fun  t -> let tmp = t in
      let s = tmp in
      ((), s))) ()) in
      (
        (Scanf.scanf "%[\n \010]" (fun _ -> ()));
        let r = tab2 in
        ((), r)
        )
      ) ()) in
      let result = (pathfind tab x y) in
      (Printf.printf "%d" result)
      )
    )
    )
  )

