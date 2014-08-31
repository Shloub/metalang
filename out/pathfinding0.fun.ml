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

let read_char_matrix x y =
  let tab = (Array.init_withenv y (fun  z () -> let o = (Array.init_withenv x (fun  p () -> Scanf.scanf "%c"
  (fun  q -> let bj = q in
  ((), bj))) ()) in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let bi = o in
    ((), bi)
    )
  ) ()) in
  tab
let rec pathfind_aux cache tab x y posX posY =
  let be () = () in
  (if ((posX = (x - 1)) && (posY = (y - 1)))
   then 0
   else let bf () = (be ()) in
   (if ((((posX < 0) || (posY < 0)) || (posX >= x)) || (posY >= y))
    then ((x * y) * 10)
    else let bg () = (bf ()) in
    (if (tab.(posY).(posX) = '#')
     then ((x * y) * 10)
     else let bh () = (bg ()) in
     (if (cache.(posY).(posX) <> (- 1))
      then cache.(posY).(posX)
      else (
             cache.(posY).(posX) <- ((x * y) * 10);
             let val1 = (pathfind_aux cache tab x y (posX + 1) posY) in
             let val2 = (pathfind_aux cache tab x y (posX - 1) posY) in
             let val3 = (pathfind_aux cache tab x y posX (posY - 1)) in
             let val4 = (pathfind_aux cache tab x y posX (posY + 1)) in
             let s = ((min (val1) (val2))) in
             let u = ((min (s) (val3))) in
             let v = ((min (u) (val4))) in
             let w = v in
             let r = w in
             let out_ = (1 + r) in
             (
               cache.(posY).(posX) <- out_;
               out_
               )
             
             )
      ))))
let pathfind tab x y =
  let cache = (Array.init_withenv y (fun  i () -> let tmp = (Array.init_withenv x (fun  j () -> 
  (
    (Printf.printf "%c" tab.(i).(j));
    let bd = (- 1) in
    ((), bd)
    )
  ) ()) in
  (
    (Printf.printf "\n" );
    let bc = tmp in
    ((), bc)
    )
  ) ()) in
  (pathfind_aux cache tab x y 0 0)
let main =
  let x = (Scanf.scanf "%d " (fun x -> x)) in
  let y = (Scanf.scanf "%d " (fun x -> x)) in
  (
    (Printf.printf "%d %d\n" x y);
    let tab = (read_char_matrix x y) in
    let result = (pathfind tab x y) in
    (Printf.printf "%d" result)
    )
  

