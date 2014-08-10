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

let rec summax =
  (fun lst len ->
      ((fun current ->
           ((fun max_ ->
                ((fun d e ->
                     let rec a i max_ current lst len =
                       (if (i <= e)
                        then ((fun current ->
                                  ((fun c ->
                                       (if (current < 0)
                                        then ((fun current ->
                                                  (c max_ current lst len)) 0)
                                        else (c max_ current lst len))) (fun
                                   max_ current lst len ->
                                  ((fun b ->
                                       (if (max_ < current)
                                        then ((fun max_ ->
                                                  (b max_ current lst len)) current)
                                        else (b max_ current lst len))) (fun
                                   max_ current lst len ->
                                  (a (i + 1) max_ current lst len)))))) (current + lst.(i)))
                        else max_) in
                       (a d max_ current lst len)) 0 (len - 1))) 0)) 0));;
let rec main =
  ((fun len ->
       Scanf.scanf "%d" (fun h ->
                            ((fun len ->
                                 (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                  tab ->
                                 ((fun result ->
                                      (Printf.printf "%d" result;
                                      ())) (summax tab len))) ((Array.init_withenv len (fun
                                  i ->
                                 (fun (len) ->
                                     ((fun tmp ->
                                          Scanf.scanf "%d" (fun g ->
                                                               ((fun tmp ->
                                                                    (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                                     f ->
                                                                    ((len), f)) tmp)))) g))) 0))) ) (len)))))) h))) 0);;

