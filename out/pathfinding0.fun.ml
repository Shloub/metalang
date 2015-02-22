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
  let q () = () in
  (if ((posX = (x - 1)) && (posY = (y - 1)))
   then 0
   else let r () = (q ()) in
   (if ((((posX < 0) || (posY < 0)) || (posX >= x)) || (posY >= y))
    then ((x * y) * 10)
    else let s () = (r ()) in
    (if (tab.(posY).(posX) = '#')
     then ((x * y) * 10)
     else let u () = (s ()) in
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
  ((fun  (m, cache) -> (
                         m;
                         (pathfind_aux cache tab x y 0 0)
                         )
  ) (Array.init_withenv y (fun  i () -> ((fun  (p, tmp) -> (
                                                             p;
                                                             (Printf.printf "\n" );
                                                             let l = tmp in
                                                             ((), l)
                                                             )
  ) (Array.init_withenv x (fun  j () -> (
                                          (Printf.printf "%c" tab.(i).(j));
                                          let o = (- 1) in
                                          ((), o)
                                          )
  ) ()))) ()))
let main =
  let x = (Scanf.scanf "%d " (fun x -> x)) in
  let y = (Scanf.scanf "%d " (fun x -> x)) in
  (
    (Printf.printf "%d %d\n" x y);
    ((fun  (w, e) -> (
                       w;
                       let tab = e in
                       let result = (pathfind tab x y) in
                       (Printf.printf "%d" result)
                       )
    ) (Array.init_withenv y (fun  f () -> ((fun  (bb, h) -> (
                                                              bb;
                                                              (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                                              let v = h in
                                                              ((), v)
                                                              )
    ) (Array.init_withenv x (fun  k () -> Scanf.scanf "%c"
    (fun  g -> let ba = g in
    ((), ba))) ()))) ()))
    )
  

