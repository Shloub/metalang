module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let nth tab tofind len =
  let out0 = 0 in
  let b = 0 in
  let c = (len - 1) in
  let rec a i out0 =
    (if (i <= c)
     then let out0 = (if (tab.(i) = tofind)
                      then let out0 = (out0 + 1) in
                      out0
                      else out0) in
     (a (i + 1) out0)
     else out0) in
    (a b out0)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  h -> let len = h in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tofind = '\000' in
    Scanf.scanf "%c"
    (fun  g -> let tofind = g in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      ((fun  (e, tab) -> (
                           e;
                           let result = (nth tab tofind len) in
                           (Printf.printf "%d" result)
                           )
      ) (Array.init_withenv len (fun  i () -> let tmp = '\000' in
      Scanf.scanf "%c"
      (fun  f -> let tmp = f in
      let d = tmp in
      ((), d))) ()))
      )
    )
    )
  )

