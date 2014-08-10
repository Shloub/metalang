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

let rec min2 =
  (fun a b ->
      ((fun m ->
           (if (a < b)
            then a
            else b)) (fun a b ->
                         ())));;
let rec min3 =
  (fun a b c ->
      (min2 (min2 a b) c));;
let rec min4 =
  (fun a b c d ->
      (min3 (min2 a b) c d));;
let rec pathfind_aux =
  (fun cache tab x y posX posY ->
      ((fun g ->
           (if ((posX = (x - 1)) && (posY = (y - 1)))
            then 0
            else ((fun h ->
                      (if ((((posX < 0) || (posY < 0)) || (posX >= x)) || (posY >= y))
                       then ((x * y) * 10)
                       else ((fun k ->
                                 (if (tab.(posY).(posX) = '#')
                                  then ((x * y) * 10)
                                  else ((fun l ->
                                            (if (cache.(posY).(posX) <> (- 1))
                                             then cache.(posY).(posX)
                                             else (cache.(posY).(posX) <- ((x * y) * 10); ((fun
                                              val1 ->
                                             ((fun val2 ->
                                                  ((fun val3 ->
                                                       ((fun val4 ->
                                                            ((fun out_ ->
                                                                 (cache.(posY).(posX) <- out_; out_)) (1 + (min4 val1 val2 val3 val4)))) (pathfind_aux cache tab x y posX (posY + 1)))) (pathfind_aux cache tab x y posX (posY - 1)))) (pathfind_aux cache tab x y (posX - 1) posY))) (pathfind_aux cache tab x y (posX + 1) posY))))) (fun
                                   cache tab x y posX posY ->
                                  (k cache tab x y posX posY))))) (fun
                        cache tab x y posX posY ->
                       (h cache tab x y posX posY))))) (fun cache tab x y posX posY ->
                                                           (g cache tab x y posX posY))))) (fun
       cache tab x y posX posY ->
      ())));;
let rec pathfind =
  (fun tab x y ->
      ((fun cache ->
           (pathfind_aux cache tab x y 0 0)) ((Array.init_withenv y (fun
       i ->
      (fun (tab, x, y) ->
          ((fun tmp ->
               ((fun e ->
                    ((tab, x, y), e)) tmp)) ((Array.init_withenv x (fun
           j ->
          (fun (i, tab, x, y) ->
              ((fun f ->
                   ((i, tab, x, y), f)) (- 1)))) ) (i, tab, x, y))))) ) (tab, x, y))));;
let rec main =
  ((fun x ->
       ((fun y ->
            Scanf.scanf "%d" (fun r ->
                                 ((fun x ->
                                      (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
                                       q ->
                                      ((fun y ->
                                           (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                            tab ->
                                           ((fun result ->
                                                (Printf.printf "%d" result;
                                                ())) (pathfind tab x y))) ((Array.init_withenv y (fun
                                            i ->
                                           (fun (y, x) ->
                                               ((fun tab2 ->
                                                    (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                     n ->
                                                    ((y, x), n)) tab2)))) ((Array.init_withenv x (fun
                                                j ->
                                               (fun (i, y, x) ->
                                                   ((fun tmp ->
                                                        Scanf.scanf "%c" (fun
                                                         p ->
                                                        ((fun tmp ->
                                                             ((fun o ->
                                                                  ((i, y, x), o)) tmp)) p))) '\000'))) ) (i, y, x))))) ) (y, x)))))) q))))) r))) 0)) 0);;

