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

let max2 a b =
  (max a b)
let read_int_matrix x y =
  let tab = (Array.init_withenv y (fun  z () -> let e = (Array.init_withenv x (fun  f () -> Scanf.scanf "%d"
  (fun  g -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let o = g in
               ((), o)
               )
  )) ()) in
  let d = e in
  let l = d in
  ((), l)) ()) in
  tab
let rec find n m x y dx dy =
  let h () = () in
  (if ((((x < 0) || (x = 20)) || (y < 0)) || (y = 20))
   then (- 1)
   else let k () = (h ()) in
   (if (n = 0)
    then 1
    else (m.(y).(x) * (find (n - 1) m (x + dx) (y + dy) dx dy))))
let main =
  let c = 8 in
  let directions = (Array.init_withenv c (fun  i () -> let q p = ((), p) in
  (if (i = 0)
   then let p = (0, 1) in
   ((), p)
   else let r () = (q ()) in
   (if (i = 1)
    then let p = (1, 0) in
    ((), p)
    else let s () = (r ()) in
    (if (i = 2)
     then let p = (0, (- 1)) in
     ((), p)
     else let u () = (s ()) in
     (if (i = 3)
      then let p = ((- 1), 0) in
      ((), p)
      else let v () = (u ()) in
      (if (i = 4)
       then let p = (1, 1) in
       ((), p)
       else let w () = (v ()) in
       (if (i = 5)
        then let p = (1, (- 1)) in
        ((), p)
        else let ba () = (w ()) in
        (if (i = 6)
         then let p = ((- 1), 1) in
         ((), p)
         else let p = ((- 1), (- 1)) in
         ((), p))))))))) ()) in
  let max_ = 0 in
  let m = (read_int_matrix 20 20) in
  let bi = 0 in
  let bj = 7 in
  let rec bb j max_ =
    (if (j <= bj)
     then ((fun  (dx, dy) -> let bg = 0 in
     let bh = 19 in
     let rec bc x max_ =
       (if (x <= bh)
        then let be = 0 in
        let bf = 19 in
        let rec bd y max_ =
          (if (y <= bf)
           then let max_ = (max2 max_ (find 4 m x y dx dy)) in
           (bd (y + 1) max_)
           else (bc (x + 1) max_)) in
          (bd be max_)
        else (bb (j + 1) max_)) in
       (bc bg max_)) directions.(j))
     else (
            (Printf.printf "%d\n" max_)
            )
     ) in
    (bb bi max_)

