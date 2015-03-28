let idstring s =
  s
let printstring s =
  (Printf.printf "%s\n" (idstring s))
let main =
  let tab = (Array.init 2 (fun  i -> (idstring "chaine de test"))) in
  let rec c j =
    (if (j <= 1)
     then (
            (printstring (idstring tab.(j)));
            (c (j + 1))
            )
     
     else ()) in
    (c 0)

