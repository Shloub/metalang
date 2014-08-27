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
  let tab = (Array.init_withenv y (fun  z () -> let d = (Array.init_withenv x (fun  e () -> Scanf.scanf "%d"
  (fun  f -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let l = f in
               ((), l)
               )
  )) ()) in
  let k = d in
  ((), k)) ()) in
  tab
let rec find n m x y dx dy =
  let g () = () in
  (if ((((x < 0) || (x = 20)) || (y < 0)) || (y = 20))
   then (- 1)
   else let h () = (g ()) in
   (if (n = 0)
    then 1
    else (m.(y).(x) * (find (n - 1) m (x + dx) (y + dy) dx dy))))
let main =
  let directions = (Array.init_withenv 8 (fun  i () -> let p o = ((), o) in
  (if (i = 0)
   then let o = (0, 1) in
   ((), o)
   else let q () = (p ()) in
   (if (i = 1)
    then let o = (1, 0) in
    ((), o)
    else let r () = (q ()) in
    (if (i = 2)
     then let o = (0, (- 1)) in
     ((), o)
     else let s () = (r ()) in
     (if (i = 3)
      then let o = ((- 1), 0) in
      ((), o)
      else let u () = (s ()) in
      (if (i = 4)
       then let o = (1, 1) in
       ((), o)
       else let v () = (u ()) in
       (if (i = 5)
        then let o = (1, (- 1)) in
        ((), o)
        else let w () = (v ()) in
        (if (i = 6)
         then let o = ((- 1), 1) in
         ((), o)
         else let o = ((- 1), (- 1)) in
         ((), o))))))))) ()) in
  let max_ = 0 in
  let m = (read_int_matrix 20 20) in
  let bh = 0 in
  let bi = 7 in
  let rec ba j max_ =
    (if (j <= bi)
     then ((fun  (dx, dy) -> let bf = 0 in
     let bg = 19 in
     let rec bb x max_ =
       (if (x <= bg)
        then let bd = 0 in
        let be = 19 in
        let rec bc y max_ =
          (if (y <= be)
           then let max_ = (max2 max_ (find 4 m x y dx dy)) in
           (bc (y + 1) max_)
           else (bb (x + 1) max_)) in
          (bc bd max_)
        else (ba (j + 1) max_)) in
       (bb bf max_)) directions.(j))
     else (
            (Printf.printf "%d\n" max_)
            )
     ) in
    (ba bh max_)

