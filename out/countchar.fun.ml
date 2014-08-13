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
      let out_ = 0 in
      let c = 0 in
      let d = (len - 1) in
      let rec a i out_ tab tofind len =
        (if (i <= d)
         then let b = (fun out_ tab tofind len ->
                          (a (i + 1) out_ tab tofind len)) in
         (if (tab.(i) = tofind)
          then let out_ = (out_ + 1) in
          (b out_ tab tofind len)
          else (b out_ tab tofind len))
         else out_) in
        (a c out_ tab tofind len));;
let rec main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun h ->
      let len = h in
      (Scanf.scanf "%[\n \010]" (fun _ -> let tofind = '\000' in
      Scanf.scanf "%c"
      (fun g ->
          let tofind = g in
          (Scanf.scanf "%[\n \010]" (fun _ -> let tab = (Array.init_withenv len (fun
           i ->
          (fun (tofind, len) ->
              let tmp = '\000' in
              Scanf.scanf "%c"
              (fun f ->
                  let tmp = f in
                  let e = tmp in
                  ((tofind, len), e)))) (tofind, len)) in
          let result = (nth tab tofind len) in
          (Printf.printf "%d" result)))))));;

