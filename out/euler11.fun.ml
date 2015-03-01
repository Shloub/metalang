let rec find n m x y dx dy =
  (if ((((x < 0) || (x = 20)) || (y < 0)) || (y = 20))
   then (- 1)
   else (if (n = 0)
         then 1
         else (m.(y).(x) * (find (n - 1) m (x + dx) (y + dy) dx dy))))
let main =
  let directions = (Array.init 8 (fun  i -> (if (i = 0)
                                             then (0, 1)
                                             else (if (i = 1)
                                                   then (1, 0)
                                                   else (if (i = 2)
                                                         then (0, (- 1))
                                                         else (if (i = 3)
                                                               then ((- 1), 0)
                                                               else (if (i = 4)
                                                                     then (1, 1)
                                                                     else (if (i = 5)
                                                                           then (1, (- 1))
                                                                           else (
                                                                           if (i = 6)
                                                                           then ((- 1), 1)
                                                                           else ((- 1), (- 1))))))))))) in
  let max0 = 0 in
  let m = (Array.init 20 (fun  c -> let e = (Array.init 20 (fun  f -> Scanf.scanf "%d"
  (fun  d -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               d
               )
  ))) in
  e)) in
  let rec o j max0 =
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
     else (Printf.printf "%d\n" max0)) in
    (o 0 max0)

