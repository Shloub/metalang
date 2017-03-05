let foo () =
  let a = 0 in
  (* test *)
  let a = a + 1 in
  (* test 2 *)
  ()

let foo2 () =
  
  ()

let foo3 () =
  if 1 = 1 then
    
    ()

let sumdiv n =
  (* On désire renvoyer la somme des diviseurs *)
  let out0 = ref( 0 ) in
  (* On déclare un entier qui contiendra la somme *)
  for i = 1 to n do
    (* La boucle : i est le diviseur potentiel*)
    if n mod i = 0 then
      (* Si i divise *)
      out0 := (!out0) + i
      (* On incrémente *)
    else
      (* nop *)
      ()
  done;
  (!out0)
  (*On renvoie out*)
let () =
 (* Programme principal *)
  let n = 0 in
  let n = Scanf.scanf "%d" (fun n -> n) in
  (* Lecture de l'entier *)
  Printf.printf "%d" (sumdiv n) 
 