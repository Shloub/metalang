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
  let b = (len - 1) in
  let rec a i out0 =
    (if (i <= b)
     then (if (tab.(i) = tofind)
           then let out0 = (out0 + 1) in
           (a (i + 1) out0)
           else (a (i + 1) out0))
     else out0) in
    (a 0 out0)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  g -> let len = g in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tofind = '\000' in
    Scanf.scanf "%c"
    (fun  f -> let tofind = f in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      ((fun  (d, tab) -> let result = (nth tab tofind len) in
      (Printf.printf "%d" result)) (Array.init_withenv len (fun  i d -> let tmp = '\000' in
      Scanf.scanf "%c"
      (fun  e -> let tmp = e in
      let c = tmp in
      ((), c))) ()))
      )
    )
    )
  )

