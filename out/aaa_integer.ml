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

let () =
begin
  let i = ref( 0 ) in
  i := (!i) + 1;
  Printf.printf "%d" (!i);
  i := (!i) + 55;
  Printf.printf "%d" (!i);
  i := (!i) * 13;
  Printf.printf "%d" (!i);
  i := (!i) / 2;
  Printf.printf "%d" (!i);
  i := (!i) + 1;
  Printf.printf "%d" (!i);
  i := (!i) / 3;
  Printf.printf "%d" (!i);
  i := (!i) - 1;
  Printf.printf "%d" (!i)
end
 