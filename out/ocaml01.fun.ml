let foo () =
  let rec b i =
    if i <= 10
    then b (i + 1)
    else 0 in
    b 0
let bar () =
  let rec c i =
    if i <= 10
    then let a = 0 in
    c (i + 1)
    else 0 in
    c 0
let main =
  ()

