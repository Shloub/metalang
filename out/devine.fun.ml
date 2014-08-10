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

let rec devine_ =
  (fun nombre tab len ->
      ((fun min_ ->
           ((fun max_ ->
                ((fun g h ->
                     let rec b i max_ min_ nombre tab len =
                       (if (i <= h)
                        then ((fun f ->
                                  (if ((tab.(i) > max_) || (tab.(i) < min_))
                                   then false
                                   else (f max_ min_ nombre tab len))) (fun
                         max_ min_ nombre tab len ->
                        ((fun e ->
                             (if (tab.(i) < nombre)
                              then ((fun min_ ->
                                        (e max_ min_ nombre tab len)) tab.(i))
                              else (e max_ min_ nombre tab len))) (fun
                         max_ min_ nombre tab len ->
                        ((fun d ->
                             (if (tab.(i) > nombre)
                              then ((fun max_ ->
                                        (d max_ min_ nombre tab len)) tab.(i))
                              else (d max_ min_ nombre tab len))) (fun
                         max_ min_ nombre tab len ->
                        ((fun c ->
                             (if ((tab.(i) = nombre) && (len <> (i + 1)))
                              then false
                              else (c max_ min_ nombre tab len))) (fun
                         max_ min_ nombre tab len ->
                        (b (i + 1) max_ min_ nombre tab len)))))))))
                        else true) in
                       (b g max_ min_ nombre tab len)) 2 (len - 1))) tab.(1))) tab.(0)));;
let rec main =
  Scanf.scanf "%d" (fun nombre ->
                       (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
                        len ->
                       (Scanf.scanf "%[\n \010]" (fun _ -> ((fun tab ->
                                                                ((fun
                                                                 a ->
                                                                ((fun
                                                                 k ->
                                                                (if a
                                                                 then (Printf.printf "%s" "True";
                                                                 (k a len nombre))
                                                                 else (Printf.printf "%s" "False";
                                                                 (k a len nombre)))) (fun
                                                                 a len nombre ->
                                                                ()))) (devine_ nombre tab len))) ((Array.init_withenv len (fun
                        i ->
                       (fun (len, nombre) ->
                           Scanf.scanf "%d" (fun tmp ->
                                                (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                 j ->
                                                ((len, nombre), j)) tmp)))))) ) (len, nombre)))))))));;

