program brainfuck_compiler;

Type lng = (
  LANG_C,
   LANG_Pas,
   LANG_Cc,
   LANG_Cs,
   LANG_Java,
   LANG_Js,
   LANG_Ml,
   LANG_Php,
   LANG_Rb,
   LANG_Py,
   LANG_Tex,
   LANG_Metalang);

{
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
}

var
  c : integer;
  current_pos : integer;
  i : integer;
  input : char;
  mem : array of integer;
begin
  input := #32;
  current_pos := 500;
  c := 1000;
  SetLength(mem, c);
  for i := 0 to  c - 1 do
  begin
    mem[i] := 0;
  end;
end.


