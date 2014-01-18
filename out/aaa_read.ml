

type lng = 
    LANG_C
  | LANG_Pas
  | LANG_Cc
  | LANG_Cs
  | LANG_Java
  | LANG_Js
  | LANG_Ml
  | LANG_Php
  | LANG_Rb
  | LANG_Py
  | LANG_Tex
  | LANG_Metalang

(*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*)
let () =
begin
  let len = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Printf.printf "%d" len;
  Printf.printf "%s" "=len\n";
  let tab = Array.init (len) (fun i ->
    let tmpi1 = Scanf.scanf "%d" (fun x -> x) in
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    Printf.printf "%d" i;
    Printf.printf "%s" "=>";
    Printf.printf "%d" tmpi1;
    Printf.printf "%s" " ";
    tmpi1) in
  Printf.printf "%s" "\n";
  let tab2 = Array.init (len) (fun i_ ->
    let tmpi2 = Scanf.scanf "%d" (fun x -> x) in
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    Printf.printf "%d" i_;
    Printf.printf "%s" "==>";
    Printf.printf "%d" tmpi2;
    Printf.printf "%s" " ";
    tmpi2) in
  let strlen = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Printf.printf "%d" strlen;
  Printf.printf "%s" "=strlen\n";
  let tab4 = Array.init (strlen) (fun toto ->
    let tmpc = Scanf.scanf "%c" (fun x -> x) in
    let c = ref( int_of_char (tmpc) ) in
    Printf.printf "%c" tmpc;
    Printf.printf "%s" ":";
    Printf.printf "%d" (!c);
    Printf.printf "%s" " ";
    if tmpc <> ' ' then
      c := (((!c) - int_of_char ('a')) + 13) mod 26 + int_of_char ('a');
    char_of_int ((!c))) in
  for j = 0 to strlen - 1 do
    let h = tab4.(j) in
    Printf.printf "%c" h
  done
end
 