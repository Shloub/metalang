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

let read_int_matrix x y =
  let tab = (Array.init_withenv y (fun  z () -> let d = (Array.init_withenv x (fun  e () -> Scanf.scanf "%d"
  (fun  f -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let p = f in
               ((), p)
               )
  )) ()) in
  let o = d in
  ((), o)) ()) in
  tab
let rec find n m x y dx dy =
  let k () = () in
  (if ((((x < 0) || (x = 20)) || (y < 0)) || (y = 20))
   then (- 1)
   else let l () = (k ()) in
   (if (n = 0)
    then 1
    else (m.(y).(x) * (find (n - 1) m (x + dx) (y + dy) dx dy))))
let main =
  let directions = (Array.init_withenv 8 (fun  i () -> let r q = ((), q) in
  (if (i = 0)
   then let q = (0, 1) in
   ((), q)
   else let s () = (r ()) in
   (if (i = 1)
    then let q = (1, 0) in
    ((), q)
    else let u () = (s ()) in
    (if (i = 2)
     then let q = (0, (- 1)) in
     ((), q)
     else let v () = (u ()) in
     (if (i = 3)
      then let q = ((- 1), 0) in
      ((), q)
      else let w () = (v ()) in
      (if (i = 4)
       then let q = (1, 1) in
       ((), q)
       else let ba () = (w ()) in
       (if (i = 5)
        then let q = (1, (- 1)) in
        ((), q)
        else let bb () = (ba ()) in
        (if (i = 6)
         then let q = ((- 1), 1) in
         ((), q)
         else let q = ((- 1), (- 1)) in
         ((), q))))))))) ()) in
  let max_ = 0 in
  let m = (read_int_matrix 20 20) in
  let bj = 0 in
  let bk = 7 in
  let rec bc j max_ =
    (if (j <= bk)
     then ((fun  (dx, dy) -> let bh = 0 in
     let bi = 19 in
     let rec bd x max_ =
       (if (x <= bi)
        then let bf = 0 in
        let bg = 19 in
        let rec be y max_ =
          (if (y <= bg)
           then let h = (find 4 m x y dx dy) in
           let g = ((max (max_) (h))) in
           let max_ = g in
           (be (y + 1) max_)
           else (bd (x + 1) max_)) in
          (be bf max_)
        else (bc (j + 1) max_)) in
       (bd bh max_)) directions.(j))
     else (
            (Printf.printf "%d\n" max_)
            )
     ) in
    (bc bj max_)

