let foo a =
  let a = 4 in
  ()
let main =
  let a = 0 in
  (
    (foo a);
    (Printf.printf "%d" a);
    (Printf.printf "%s" "\n")
    )
  

