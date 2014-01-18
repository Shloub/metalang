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
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*)
let () =
begin
  let input = ' ' in
  let current_pos = 500 in
  let h = 1000 in
  let mem = Array.init (h) (fun i ->
    0) in ()
end
 