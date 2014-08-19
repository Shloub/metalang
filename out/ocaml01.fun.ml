let foo () =
  let f = 0 in
  let g = 10 in
  let rec e i =
    (if (i <= g)
     then (e (i + 1))
     else 0) in
    (e f)
let bar () =
  let c = 0 in
  let d = 10 in
  let rec b i =
    (if (i <= d)
     then let a = 0 in
     (b (i + 1))
     else 0) in
    (b c)
let main =
  ()

