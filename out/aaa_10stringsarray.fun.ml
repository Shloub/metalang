type toto = {mutable s : string; mutable v : int;}
let idstring s =
  s
let printstring s =
  Printf.printf "%s\n" (idstring s)
let print_toto t =
  Printf.printf "%s = %d\n" t.s t.v
let main =
  let tab = Array.init 2 (fun i -> idstring "chaine de test") in
  let rec a j =
    if j <= 1
    then ( printstring (idstring tab.(j));
           a (j + 1))
    else ( print_toto {s="one";
                       v=1};
           ()) in
    a 0

