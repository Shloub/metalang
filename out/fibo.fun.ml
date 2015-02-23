let fibo0 a b i =
  let out0 = 0 in
  let a2 = a in
  let b2 = b in
  let d = (i + 1) in
  let rec c j a2 b2 out0 =
    (if (j <= d)
     then let out0 = (out0 + a2) in
     let tmp = b2 in
     let b2 = (b2 + a2) in
     let a2 = tmp in
     (c (j + 1) a2 b2 out0)
     else out0) in
    (c 0 a2 b2 out0)
let main =
  let a = 0 in
  let b = 0 in
  let i = 0 in
  Scanf.scanf "%d"
  (fun  g -> let a = g in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    Scanf.scanf "%d"
    (fun  f -> let b = f in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      Scanf.scanf "%d"
      (fun  e -> let i = e in
      (Printf.printf "%d" (fibo0 a b i)))
      )
    )
    )
  )

