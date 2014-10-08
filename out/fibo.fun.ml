let fibo0 a b i =
  let out0 = 0 in
  let a2 = a in
  let b2 = b in
  let d = 0 in
  let e = (i + 1) in
  let rec c j a2 b2 out0 =
    (if (j <= e)
     then let out0 = (out0 + a2) in
     let tmp = b2 in
     let b2 = (b2 + a2) in
     let a2 = tmp in
     (c (j + 1) a2 b2 out0)
     else out0) in
    (c d a2 b2 out0)
let main =
  let a = 0 in
  let b = 0 in
  let i = 0 in
  Scanf.scanf "%d"
  (fun  h -> let a = h in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    Scanf.scanf "%d"
    (fun  g -> let b = g in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      Scanf.scanf "%d"
      (fun  f -> let i = f in
      (Printf.printf "%d" (fibo0 a b i)))
      )
    )
    )
  )

