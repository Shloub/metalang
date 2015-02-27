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
  (if ((((x < 0) || (x = 20)) || (y < 0)) || (y = 20))
   then (- 1)
   else (if (n = 0)
         then 1
         else (m.(y).(x) * (find (n - 1) m (x + dx) (y + dy) dx dy))))
let main =
  ((fun  (h, directions) -> let max0 = 0 in
  ((fun  (l, m) -> let rec o j max0 =
                     (if (j <= 7)
                      then ((fun  (dx, dy) -> let rec p x max0 =
                                                (if (x <= 19)
                                                 then let rec q y max0 =
                                                        (if (y <= 19)
                                                         then let max0 = ((max (max0) ((find 4 m x y dx dy)))) in
                                                         (q (y + 1) max0)
                                                         else (p (x + 1) max0)) in
                                                        (q 0 max0)
                                                 else (o (j + 1) max0)) in
                                                (p 0 max0)) directions.(j))
                      else (
                             (Printf.printf "%d\n" max0)
                             )
                      ) in
                     (o 0 max0)) (Array.init_withenv 20 (fun  c l -> ((fun  (s, e) -> let k = e in
  ((), k)) (Array.init_withenv 20 (fun  f s -> Scanf.scanf "%d"
  (fun  d -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let r = d in
               ((), r)
               )
  )) ()))) ()))) (Array.init_withenv 8 (fun  i h -> (if (i = 0)
                                                     then let g = (0, 1) in
                                                     ((), g)
                                                     else (if (i = 1)
                                                           then let g = (1, 0) in
                                                           ((), g)
                                                           else (if (i = 2)
                                                                 then let g = (0, (- 1)) in
                                                                 ((), g)
                                                                 else (if (i = 3)
                                                                       then let g = ((- 1), 0) in
                                                                       ((), g)
                                                                       else (if (i = 4)
                                                                             then let g = (1, 1) in
                                                                             ((), g)
                                                                             else (
                                                                             if (i = 5)
                                                                             then let g = (1, (- 1)) in
                                                                             ((), g)
                                                                             else (
                                                                             if (i = 6)
                                                                             then let g = ((- 1), 1) in
                                                                             ((), g)
                                                                             else let g = ((- 1), (- 1)) in
                                                                             ((), g))))))))) ()))

