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
let read_char_matrix x y =
  let tab = (Array.init_withenv y (fun  z () -> let h = (Array.init_withenv x (fun  k () -> Scanf.scanf "%c"
  (fun  l -> let bd = l in
  ((), bd))) ()) in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let g = h in
    let bc = g in
    ((), bc)
    )
  ) ()) in
  tab
let rec pathfind_aux cache tab x y posX posY =
  let v () = () in
  (if ((posX = (x - 1)) && (posY = (y - 1)))
   then 0
   else let w () = (v ()) in
   (if ((((posX < 0) || (posY < 0)) || (posX >= x)) || (posY >= y))
    then ((x * y) * 10)
    else let ba () = (w ()) in
    (if (tab.(posY).(posX) = '#')
     then ((x * y) * 10)
     else let bb () = (ba ()) in
     (if (cache.(posY).(posX) <> (- 1))
      then cache.(posY).(posX)
      else (
             cache.(posY).(posX) <- ((x * y) * 10);
             let val1 = (pathfind_aux cache tab x y (posX + 1) posY) in
             let val2 = (pathfind_aux cache tab x y (posX - 1) posY) in
             let val3 = (pathfind_aux cache tab x y posX (posY - 1)) in
             let val4 = (pathfind_aux cache tab x y posX (posY + 1)) in
             let o = (min2 val1 val2) in
             let p = (min2 (min2 o val3) val4) in
             let m = p in
             let out_ = (1 + m) in
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
    let u = (- 1) in
    ((), u)
    )
  ) ()) in
  (
    (Printf.printf "\n" );
    let s = tmp in
    ((), s)
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
  

