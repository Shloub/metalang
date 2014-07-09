let foo () =
  let a = ref( 0 ) in
  (* test *)
  a := (!a) + 1
  (* test 2 *)

let foo2 () =
   ()

let foo3 () =
  if 1 = 1 then
    begin
       ()
    end

let sumdiv n =
  (* On désire renvoyer la somme des diviseurs *)
  let out_ = ref( 0 ) in
  (* On déclare un entier qui contiendra la somme *)
  for i = 1 to n do
    (* La boucle : i est le diviseur potentiel*)
    if (n mod i) = 0 then
      begin
        (* Si i divise *)
        out_ := (!out_) + i
        (* On incrémente *)
      end
    else
      begin
        (* nop *) ()
      end
  done;
  (!out_)
  (*On renvoie out*)

let () =
begin
  (* Programme principal *)
  let n = ref( 0 ) in
  Scanf.scanf "%d" (fun v_0 -> n := v_0);
  (* Lecture de l'entier *)
  Printf.printf "%d" (sumdiv (!n))
end
 