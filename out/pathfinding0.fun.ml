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
      ((fun p ->
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
let rec read_int =
  (fun () -> Scanf.scanf "%d" (fun out_ ->
                                  (Scanf.scanf "%[\n \010]" (fun _ -> out_))));;
let rec read_char_line =
  (fun n ->
      ((fun tab ->
           (Scanf.scanf "%[\n \010]" (fun _ -> tab))) ((Array.init_withenv n (fun
       i ->
      (fun (n) ->
          Scanf.scanf "%c" (fun t ->
                               ((fun o ->
                                    ((n), o)) t)))) ) (n))));;
let rec read_char_matrix =
  (fun x y ->
      ((fun tab ->
           tab) ((Array.init_withenv y (fun z ->
                                           (fun (x, y) ->
                                               ((fun m ->
                                                    ((x, y), m)) (read_char_line x)))) ) (x, y))));;
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
               (Printf.printf "%s" "\n";
               ((fun e ->
                    ((tab, x, y), e)) tmp))) ((Array.init_withenv x (fun
           j ->
          (fun (i, tab, x, y) ->
              (Printf.printf "%c" tab.(i).(j);
              ((fun f ->
                   ((i, tab, x, y), f)) (- 1))))) ) (i, tab, x, y))))) ) (tab, x, y))));;
let rec main =
  ((fun x ->
       ((fun y ->
            (Printf.printf "%d" x;
            (Printf.printf "%s" " ";
            (Printf.printf "%d" y;
            (Printf.printf "%s" "\n";
            ((fun tab ->
                 ((fun result ->
                      (Printf.printf "%d" result;
                      ())) (pathfind tab x y))) (read_char_matrix x y))))))) (read_int ()))) (read_int ()));;

