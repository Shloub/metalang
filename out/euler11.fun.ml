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

let rec max2 =
  (fun a b ->
      ((fun h ->
           (if (a > b)
            then a
            else b)) (fun a b ->
                         ())));;
let rec read_int_line =
  (fun n ->
      ((fun tab ->
           tab) ((Array.init_withenv n (fun i ->
                                           (fun (n) ->
                                               Scanf.scanf "%d" (fun t ->
                                                                    (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                                     g ->
                                                                    ((n), g)) t)))))) ) (n))));;
let rec read_int_matrix =
  (fun x y ->
      ((fun tab ->
           tab) ((Array.init_withenv y (fun z ->
                                           (fun (x, y) ->
                                               ((fun f ->
                                                    ((x, y), f)) (read_int_line x)))) ) (x, y))));;
let rec find =
  (fun n m x y dx dy ->
      ((fun d ->
           (if ((((x < 0) || (x = 20)) || (y < 0)) || (y = 20))
            then (- 1)
            else ((fun e ->
                      (if (n = 0)
                       then 1
                       else (m.(y).(x) * (find (n - 1) m (x + dx) (y + dy) dx dy)))) (fun
             n m x y dx dy ->
            (d n m x y dx dy))))) (fun n m x y dx dy ->
                                      ())));;
let rec main =
  ((fun c ->
       ((fun directions ->
            ((fun max_ ->
                 ((fun m ->
                      ((fun bf bg ->
                           let rec v j m max_ c =
                             (if (j <= bg)
                              then ((fun (dx, dy) ->
                                        ((fun bd be ->
                                             let rec w x dx dy m max_ c =
                                               (if (x <= be)
                                                then ((fun bb bc ->
                                                          let rec ba y dx dy m max_ c =
                                                            (if (y <= bc)
                                                             then ((fun
                                                              max_ ->
                                                             (ba (y + 1) dx dy m max_ c)) (max2 max_ (find 4 m x y dx dy)))
                                                             else (w (x + 1) dx dy m max_ c)) in
                                                            (ba bb dx dy m max_ c)) 0 19)
                                                else (v (j + 1) m max_ c)) in
                                               (w bd dx dy m max_ c)) 0 19)) directions.(j))
                              else (Printf.printf "%d" max_;
                              (Printf.printf "%s" "\n";
                              ()))) in
                             (v bf m max_ c)) 0 7)) (read_int_matrix 20 20))) 0)) ((Array.init_withenv c (fun
        i ->
       (fun (c) ->
           ((fun l ->
                (if (i = 0)
                 then ((fun k ->
                           ((c), k)) (0, 1))
                 else ((fun o ->
                           (if (i = 1)
                            then ((fun k ->
                                      ((c), k)) (1, 0))
                            else ((fun p ->
                                      (if (i = 2)
                                       then ((fun k ->
                                                 ((c), k)) (0, (- 1)))
                                       else ((fun q ->
                                                 (if (i = 3)
                                                  then ((fun k ->
                                                            ((c), k)) ((- 1), 0))
                                                  else ((fun r ->
                                                            (if (i = 4)
                                                             then ((fun
                                                              k ->
                                                             ((c), k)) (1, 1))
                                                             else ((fun
                                                              s ->
                                                             (if (i = 5)
                                                              then ((fun
                                                               k ->
                                                              ((c), k)) (1, (- 1)))
                                                              else ((fun
                                                               u ->
                                                              (if (i = 6)
                                                               then ((fun
                                                                k ->
                                                               ((c), k)) ((- 1), 1))
                                                               else ((fun
                                                                k ->
                                                               ((c), k)) ((- 1), (- 1))))) (fun
                                                               i c ->
                                                              (s i c))))) (fun
                                                              i c ->
                                                             (r i c))))) (fun
                                                   i c ->
                                                  (q i c))))) (fun i c ->
                                                                  (p i c))))) (fun
                             i c ->
                            (o i c))))) (fun i c ->
                                            (l i c))))) (fun i c ->
                                                            (fun k ->
                                                                ((c), k)))))) ) (c)))) 8);;

