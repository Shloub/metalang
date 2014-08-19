let foo () =
  let a = 0 in
  (*  test  *)
  let a = (a + 1) in
  (*  test 2  *)
  ()
let foo2 () =
  ()
let foo3 () =
  (
    (if (1 = 1)
     then ()
     else ());
    ()
    )
  
let sumdiv n =
  (*  On désire renvoyer la somme des diviseurs  *)
  let out_ = 0 in
  (*  On déclare un entier qui contiendra la somme  *)
  let c = 1 in
  let d = n in
  let rec b i out_ =
    (if (i <= d)
     then (*  La boucle : i est le diviseur potentiel *)
     let out_ = (if ((n mod i) = 0)
                 then (*  Si i divise  *)
                 let out_ = (out_ + i) in
                 (*  On incrémente  *)
                 out_
                 else (*  nop  *)
                 out_) in
     (b (i + 1) out_)
     else out_) in
    (b c out_)
let main =
  (*  Programme principal  *)
  let n = 0 in
  Scanf.scanf "%d"
  (fun  e -> let n = e in
  (*  Lecture de l'entier  *)
  (Printf.printf "%d" (sumdiv n)))

