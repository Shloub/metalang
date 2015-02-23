let foo () =
  let a = 0 in
  (*  test  *)
  let a = (a + 1) in
  (*  test 2  *)
  ()
let foo2 () =
  ()
let foo3 () =
  (if (1 = 1)
   then ()
   else ())
let sumdiv n =
  (*  On désire renvoyer la somme des diviseurs  *)
  let out0 = 0 in
  (*  On déclare un entier qui contiendra la somme  *)
  let rec b i out0 =
    (if (i <= n)
     then (*  La boucle : i est le diviseur potentiel *)
     (if ((n mod i) = 0)
      then (*  Si i divise  *)
      let out0 = (out0 + i) in
      (*  On incrémente  *)
      (b (i + 1) out0)
      else (*  nop  *)
      (b (i + 1) out0))
     else out0) in
    (b 1 out0)
let main =
  (*  Programme principal  *)
  let n = 0 in
  Scanf.scanf "%d"
  (fun  c -> let n = c in
  (*  Lecture de l'entier  *)
  (Printf.printf "%d" (sumdiv n)))

