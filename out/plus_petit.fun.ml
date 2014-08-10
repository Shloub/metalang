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

let rec go_ =
  (fun tab a b ->
      ((fun m ->
           ((fun h ->
                (if (a = m)
                 then ((fun k ->
                           (if (tab.(a) = m)
                            then b
                            else a)) (fun m tab a b ->
                                         (h m tab a b)))
                 else (h m tab a b))) (fun m tab a b ->
                                          ((fun i ->
                                               ((fun j ->
                                                    let rec f j i m tab a b =
                                                      (if (i < j)
                                                       then ((fun e ->
                                                                 ((fun
                                                                  g ->
                                                                 (if (e < m)
                                                                  then ((fun
                                                                   i ->
                                                                  (g e j i m tab a b)) (i + 1))
                                                                  else ((fun
                                                                   j ->
                                                                  (tab.(i) <- tab.(j); (tab.(j) <- e; (g e j i m tab a b)))) (j - 1)))) (fun
                                                                  e j i m tab a b ->
                                                                 (f j i m tab a b)))) tab.(i))
                                                       else ((fun c ->
                                                                 (if (i < m)
                                                                  then (go_ tab a m)
                                                                  else (go_ tab m b))) (fun
                                                        j i m tab a b ->
                                                       ()))) in
                                                      (f j i m tab a b)) b)) a)))) ((a + b) / 2)));;
let rec plus_petit_ =
  (fun tab len ->
      (go_ tab 0 len));;
let rec main =
  ((fun len ->
       Scanf.scanf "%d" (fun o ->
                            ((fun len ->
                                 (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                  tab ->
                                 (Printf.printf "%d" (plus_petit_ tab len);
                                 ())) ((Array.init_withenv len (fun i ->
                                                                   (fun
                                                                    (len) ->
                                                                   ((fun
                                                                    tmp ->
                                                                   Scanf.scanf "%d" (fun
                                                                    n ->
                                                                   ((fun
                                                                    tmp ->
                                                                   (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                                    l ->
                                                                   ((len), l)) tmp)))) n))) 0))) ) (len)))))) o))) 0);;

