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

let rec nth =
  (fun tab tofind len ->
      ((fun out_ ->
           ((fun c d ->
                let rec a i out_ tab tofind len =
                  (if (i <= d)
                   then ((fun b ->
                             (if (tab.(i) = tofind)
                              then ((fun out_ ->
                                        (b out_ tab tofind len)) (out_ + 1))
                              else (b out_ tab tofind len))) (fun out_ tab tofind len ->
                                                                 (a (i + 1) out_ tab tofind len)))
                   else out_) in
                  (a c out_ tab tofind len)) 0 (len - 1))) 0));;
let rec main =
  ((fun len ->
       Scanf.scanf "%d" (fun h ->
                            ((fun len ->
                                 (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                  tofind ->
                                 Scanf.scanf "%c" (fun g ->
                                                      ((fun tofind ->
                                                           (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                            tab ->
                                                           ((fun result ->
                                                                (Printf.printf "%d" result;
                                                                ())) (nth tab tofind len))) ((Array.init_withenv len (fun
                                                            i ->
                                                           (fun (tofind, len) ->
                                                               ((fun tmp ->
                                                                    Scanf.scanf "%c" (fun
                                                                     f ->
                                                                    ((fun
                                                                     tmp ->
                                                                    ((fun
                                                                     e ->
                                                                    ((tofind, len), e)) tmp)) f))) '\000'))) ) (tofind, len)))))) g))) '\000')))) h))) 0);;

