let nth tab tofind len =
  let out0 = 0 in
  let rec a i out0 =
    (if (i <= (len - 1))
     then (if (tab.(i) = tofind)
           then let out0 = (out0 + 1) in
           (a (i + 1) out0)
           else (a (i + 1) out0))
     else out0) in
    (a 0 out0)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  b -> let len = b in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tofind = '\000' in
    Scanf.scanf "%c"
    (fun  c -> let tofind = c in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let tab = (Array.init len (fun  i -> let tmp = '\000' in
      Scanf.scanf "%c"
      (fun  d -> d))) in
      let result = (nth tab tofind len) in
      (Printf.printf "%d" result)
      )
    )
    )
  )

