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
  (fun () -> ((fun a ->
                  (*  test  *)
                  ((fun a ->
                       (*  test 2  *)
                       ()) (a + 1))) 0));;
let rec foo2 =
  (fun () -> ());;
let rec foo3 =
  (fun () -> ((fun f ->
                  (if (1 = 1)
                   then (f ())
                   else (f ()))) (fun () -> ())));;
let rec sumdiv =
  (fun n ->
      (*  On désire renvoyer la somme des diviseurs  *)
      ((fun out_ ->
           (*  On déclare un entier qui contiendra la somme  *)
           ((fun d e ->
                let rec b i out_ n =
                  (if (i <= e)
                   then (*  La boucle : i est le diviseur potentiel *)
                   ((fun c ->
                        (if ((n mod i) = 0)
                         then (*  Si i divise  *)
                         ((fun out_ ->
                              (*  On incrémente  *)
                              (c out_ n)) (out_ + i))
                         else (*  nop  *)
                         (c out_ n))) (fun out_ n ->
                                          (b (i + 1) out_ n)))
                   else out_) in
                  (b d out_ n)) 1 n)) 0));;
let rec main =
  (*  Programme principal  *)
  ((fun n ->
       Scanf.scanf "%d" (fun g ->
                            ((fun n ->
                                 (*  Lecture de l'entier  *)
                                 (Printf.printf "%d" (sumdiv n);
                                 ())) g))) 0);;

