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
      let b = (fun cache tab len pos ->
                  ()) in
      (if (pos >= (len - 1))
       then 0
       else let c = (fun cache tab len pos ->
                        (b cache tab len pos)) in
       (if (cache.(pos) <> (- 1))
        then cache.(pos)
        else (cache.(pos) <- (len * 2); let posval = (pathfind_aux cache tab len tab.(pos)) in
        let oneval = (pathfind_aux cache tab len (pos + 1)) in
        let out_ = 0 in
        let d = (fun out_ oneval posval cache tab len pos ->
                    (cache.(pos) <- out_; out_)) in
        (if (posval < oneval)
         then let out_ = (1 + posval) in
         (d out_ oneval posval cache tab len pos)
         else let out_ = (1 + oneval) in
         (d out_ oneval posval cache tab len pos))))));;
let rec pathfind =
  (fun tab len ->
      let cache = (Array.init_withenv len (fun i ->
                                              (fun (tab, len) ->
                                                  let a = (- 1) in
                                                  ((tab, len), a))) (tab, len)) in
      (pathfind_aux cache tab len 0));;
let rec main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun g ->
      let len = g in
      (Scanf.scanf "%[\n \010]" (fun _ -> let tab = (Array.init_withenv len (fun
       i len ->
      let tmp = 0 in
      Scanf.scanf "%d"
      (fun f ->
          let tmp = f in
          (Scanf.scanf "%[\n \010]" (fun _ -> let e = tmp in
          (len, e))))) len) in
      let result = (pathfind tab len) in
      (Printf.printf "%d" result))));;

