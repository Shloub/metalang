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

let rec foo a =
  let a = ref a in
  a := 4

let () =
begin
  let a = 0 in
  foo a;
  Printf.printf "%d" a;
  Printf.printf "%s" "\n"
end
 