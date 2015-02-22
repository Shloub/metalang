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

let rec find n m x y dx dy =
  let h () = () in
  (if ((((x < 0) || (x = 20)) || (y < 0)) || (y = 20))
   then (- 1)
   else let k () = (h ()) in
   (if (n = 0)
    then 1
    else (m.(y).(x) * (find (n - 1) m (x + dx) (y + dy) dx dy))))
let main =
  ((fun  (o, directions) -> (
                              o;
                              let max0 = 0 in
                              let c = 20 in
                              ((fun  (bb, m) -> (
                                                  bb;
                                                  let bl = 0 in
                                                  let bm = 7 in
                                                  let rec be j max0 =
                                                    (if (j <= bm)
                                                     then ((fun  (dx, dy) -> let bj = 0 in
                                                     let bk = 19 in
                                                     let rec bf x max0 =
                                                       (if (x <= bk)
                                                        then let bh = 0 in
                                                        let bi = 19 in
                                                        let rec bg y max0 =
                                                          (if (y <= bi)
                                                           then let max0 = ((max (max0) ((find 4 m x y dx dy)))) in
                                                           (bg (y + 1) max0)
                                                           else (bf (x + 1) max0)) in
                                                          (bg bh max0)
                                                        else (be (j + 1) max0)) in
                                                       (bf bj max0)) directions.(j))
                                                     else (
                                                            (Printf.printf "%d\n" max0)
                                                            )
                                                     ) in
                                                    (be bl max0)
                                                  )
                              ) (Array.init_withenv 20 (fun  d () -> ((fun  (bd, f) -> 
                              (
                                bd;
                                let ba = f in
                                ((), ba)
                                )
                              ) (Array.init_withenv c (fun  g () -> Scanf.scanf "%d"
                              (fun  e -> (
                                           (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                           let bc = e in
                                           ((), bc)
                                           )
                              )) ()))) ()))
                              )
  ) (Array.init_withenv 8 (fun  i () -> let p l = ((), l) in
  (if (i = 0)
   then let l = (0, 1) in
   ((), l)
   else let q () = (p ()) in
   (if (i = 1)
    then let l = (1, 0) in
    ((), l)
    else let r () = (q ()) in
    (if (i = 2)
     then let l = (0, (- 1)) in
     ((), l)
     else let s () = (r ()) in
     (if (i = 3)
      then let l = ((- 1), 0) in
      ((), l)
      else let u () = (s ()) in
      (if (i = 4)
       then let l = (1, 1) in
       ((), l)
       else let v () = (u ()) in
       (if (i = 5)
        then let l = (1, (- 1)) in
        ((), l)
        else let w () = (v ()) in
        (if (i = 6)
         then let l = ((- 1), 1) in
         ((), l)
         else let l = ((- 1), (- 1)) in
         ((), l))))))))) ()))

