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
  ((fun  (k, directions) -> (
                              k;
                              let max0 = 0 in
                              let c = 20 in
                              ((fun  (o, m) -> (
                                                 o;
                                                 let rec r j max0 =
                                                   (if (j <= 7)
                                                    then ((fun  (dx, dy) -> let rec s x max0 =
                                                                              (if (x <= 19)
                                                                               then 
                                                                               let rec u y max0 =
                                                                                (if (y <= 19)
                                                                                then let max0 = ((max (max0) ((find 4 m x y dx dy)))) in
                                                                                (u (y + 1) max0)
                                                                                else (s (x + 1) max0)) in
                                                                                (u 0 max0)
                                                                               else (r (j + 1) max0)) in
                                                                              (s 0 max0)) directions.(j))
                                                    else (
                                                           (Printf.printf "%d\n" max0)
                                                           )
                                                    ) in
                                                   (r 0 max0)
                                                 )
                              ) (Array.init_withenv 20 (fun  d () -> ((fun  (q, f) -> 
                              (
                                q;
                                let l = f in
                                ((), l)
                                )
                              ) (Array.init_withenv c (fun  g () -> Scanf.scanf "%d"
                              (fun  e -> (
                                           (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                           let p = e in
                                           ((), p)
                                           )
                              )) ()))) ()))
                              )
  ) (Array.init_withenv 8 (fun  i () -> (if (i = 0)
                                         then let h = (0, 1) in
                                         ((), h)
                                         else (if (i = 1)
                                               then let h = (1, 0) in
                                               ((), h)
                                               else (if (i = 2)
                                                     then let h = (0, (- 1)) in
                                                     ((), h)
                                                     else (if (i = 3)
                                                           then let h = ((- 1), 0) in
                                                           ((), h)
                                                           else (if (i = 4)
                                                                 then let h = (1, 1) in
                                                                 ((), h)
                                                                 else (if (i = 5)
                                                                       then let h = (1, (- 1)) in
                                                                       ((), h)
                                                                       else (if (i = 6)
                                                                             then let h = ((- 1), 1) in
                                                                             ((), h)
                                                                             else let h = ((- 1), (- 1)) in
                                                                             ((), h))))))))) ()))

