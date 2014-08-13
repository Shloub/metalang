module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    )
end

let rec foo =
  (fun () -> let a = 0 in
  (*  test  *)
  let a = (a + 1) in
  (*  test 2  *)
  ());;
let rec foo2 =
  (fun () -> ());;
let rec foo3 =
  (fun () -> let f = (fun () -> ()) in
  (if (1 = 1)
   then (f ())
   else (f ())));;
let rec sumdiv =
  (fun n ->
      (*  On désire renvoyer la somme des diviseurs  *)
      let out_ = 0 in
      (*  On déclare un entier qui contiendra la somme  *)
      let d = 1 in
      let e = n in
      let rec b i out_ n =
        (if (i <= e)
         then (*  La boucle : i est le diviseur potentiel *)
         let c = (fun out_ n ->
                     (b (i + 1) out_ n)) in
         (if ((n mod i) = 0)
          then (*  Si i divise  *)
          let out_ = (out_ + i) in
          (*  On incrémente  *)
          (c out_ n)
          else (*  nop  *)
          (c out_ n))
         else out_) in
        (b d out_ n));;
let rec main =
  (*  Programme principal  *)
  let n = 0 in
  Scanf.scanf "%d"
  (fun g ->
      let n = g in
      (*  Lecture de l'entier  *)
      (Printf.printf "%d" (sumdiv n)));;

