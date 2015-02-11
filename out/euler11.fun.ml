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

let rec find n m x y dx dy =
  let h () = () in
  (if ((((x < 0) || (x = 20)) || (y < 0)) || (y = 20))
   then (- 1)
   else let k () = (h ()) in
   (if (n = 0)
    then 1
    else (m.(y).(x) * (find (n - 1) m (x + dx) (y + dy) dx dy))))
let main =
  let directions = (Array.init_withenv 8 (fun  i () -> let o l = ((), l) in
  (if (i = 0)
   then let l = (0, 1) in
   ((), l)
   else let p () = (o ()) in
   (if (i = 1)
    then let l = (1, 0) in
    ((), l)
    else let q () = (p ()) in
    (if (i = 2)
     then let l = (0, (- 1)) in
     ((), l)
     else let r () = (q ()) in
     (if (i = 3)
      then let l = ((- 1), 0) in
      ((), l)
      else let s () = (r ()) in
      (if (i = 4)
       then let l = (1, 1) in
       ((), l)
       else let u () = (s ()) in
       (if (i = 5)
        then let l = (1, (- 1)) in
        ((), l)
        else let v () = (u ()) in
        (if (i = 6)
         then let l = ((- 1), 1) in
         ((), l)
         else let l = ((- 1), (- 1)) in
         ((), l))))))))) ()) in
  let max0 = 0 in
  let c = 20 in
  let m = (Array.init_withenv 20 (fun  d () -> let f = (Array.init_withenv c (fun  g () -> Scanf.scanf "%d"
  (fun  e -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let ba = e in
               ((), ba)
               )
  )) ()) in
  let w = f in
  ((), w)) ()) in
  let bi = 0 in
  let bj = 7 in
  let rec bb j max0 =
    (if (j <= bj)
     then ((fun  (dx, dy) -> let bg = 0 in
     let bh = 19 in
     let rec bc x max0 =
       (if (x <= bh)
        then let be = 0 in
        let bf = 19 in
        let rec bd y max0 =
          (if (y <= bf)
           then let max0 = ((max (max0) ((find 4 m x y dx dy)))) in
           (bd (y + 1) max0)
           else (bc (x + 1) max0)) in
          (bd be max0)
        else (bb (j + 1) max0)) in
       (bc bg max0)) directions.(j))
     else (
            (Printf.printf "%d\n" max0)
            )
     ) in
    (bb bi max0)

