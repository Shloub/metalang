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
let read_int_line n =
  let tab = (Array.init_withenv n (fun  i () -> Scanf.scanf "%d"
  (fun  t -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let g = t in
               ((), g)
               )
  )) ()) in
  tab
let read_int_matrix x y =
  let tab = (Array.init_withenv y (fun  z () -> let f = (read_int_line x) in
  ((), f)) ()) in
  tab
let rec find n m x y dx dy =
  let d () = () in
  (if ((((x < 0) || (x = 20)) || (y < 0)) || (y = 20))
   then (- 1)
   else let e () = (d ()) in
   (if (n = 0)
    then 1
    else (m.(y).(x) * (find (n - 1) m (x + dx) (y + dy) dx dy))))
let main =
  let c = 8 in
  let directions = (Array.init_withenv c (fun  i () -> let k h = ((), h) in
  (if (i = 0)
   then let h = (0, 1) in
   ((), h)
   else let l () = (k ()) in
   (if (i = 1)
    then let h = (1, 0) in
    ((), h)
    else let o () = (l ()) in
    (if (i = 2)
     then let h = (0, (- 1)) in
     ((), h)
     else let p () = (o ()) in
     (if (i = 3)
      then let h = ((- 1), 0) in
      ((), h)
      else let q () = (p ()) in
      (if (i = 4)
       then let h = (1, 1) in
       ((), h)
       else let r () = (q ()) in
       (if (i = 5)
        then let h = (1, (- 1)) in
        ((), h)
        else let s () = (r ()) in
        (if (i = 6)
         then let h = ((- 1), 1) in
         ((), h)
         else let h = ((- 1), (- 1)) in
         ((), h))))))))) ()) in
  let max_ = 0 in
  let m = (read_int_matrix 20 20) in
  let be = 0 in
  let bf = 7 in
  let rec u j max_ =
    (if (j <= bf)
     then ((fun  (dx, dy) -> let bc = 0 in
     let bd = 19 in
     let rec v x max_ =
       (if (x <= bd)
        then let ba = 0 in
        let bb = 19 in
        let rec w y max_ =
          (if (y <= bb)
           then let max_ = (max2 max_ (find 4 m x y dx dy)) in
           (w (y + 1) max_)
           else (v (x + 1) max_)) in
          (w ba max_)
        else (u (j + 1) max_)) in
       (v bc max_)) directions.(j))
     else (
            (Printf.printf "%d\n" max_)
            )
     ) in
    (u be max_)

