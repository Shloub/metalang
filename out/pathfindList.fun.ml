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

let rec pathfind_aux =
  (fun cache tab len pos ->
      ((fun b ->
           (if (pos >= (len - 1))
            then 0
            else ((fun c ->
                      (if (cache.(pos) <> (- 1))
                       then cache.(pos)
                       else (cache.(pos) <- (len * 2); ((fun posval ->
                                                            ((fun oneval ->
                                                                 ((fun
                                                                  out_ ->
                                                                 ((fun
                                                                  d ->
                                                                 (if (posval < oneval)
                                                                  then ((fun
                                                                   out_ ->
                                                                  (d out_ oneval posval cache tab len pos)) (1 + posval))
                                                                  else ((fun
                                                                   out_ ->
                                                                  (d out_ oneval posval cache tab len pos)) (1 + oneval)))) (fun
                                                                  out_ oneval posval cache tab len pos ->
                                                                 (cache.(pos) <- out_; out_)))) 0)) (pathfind_aux cache tab len (pos + 1)))) (pathfind_aux cache tab len tab.(pos)))))) (fun
             cache tab len pos ->
            (b cache tab len pos))))) (fun cache tab len pos ->
                                          ())));;
let rec pathfind =
  (fun tab len ->
      ((fun cache ->
           (pathfind_aux cache tab len 0)) ((Array.init_withenv len (fun
       i ->
      (fun (tab, len) ->
          ((fun a ->
               ((tab, len), a)) (- 1)))) ) (tab, len))));;
let rec main =
  ((fun len ->
       Scanf.scanf "%d" (fun g ->
                            ((fun len ->
                                 (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                  tab ->
                                 ((fun result ->
                                      (Printf.printf "%d" result;
                                      ())) (pathfind tab len))) ((Array.init_withenv len (fun
                                  i ->
                                 (fun (len) ->
                                     ((fun tmp ->
                                          Scanf.scanf "%d" (fun f ->
                                                               ((fun tmp ->
                                                                    (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                                     e ->
                                                                    ((len), e)) tmp)))) f))) 0))) ) (len)))))) g))) 0);;

