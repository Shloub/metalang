program brainfuck_compiler;

{
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
}

var
  current_pos : Longint;
  i : Longint;
  input : char;
  mem : array of Longint;
begin
  input := #32;
  current_pos := 500;
  SetLength(mem, 1000);
  for i := 0 to  1000 - 1 do
  begin
    mem[i] := 0;
  end;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  current_pos := current_pos + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  while mem[current_pos] <> 0 do
  begin
    mem[current_pos] := mem[current_pos] - 1;
    current_pos := current_pos - 1;
    mem[current_pos] := mem[current_pos] + 1;
    Write(chr(mem[current_pos]));
    current_pos := current_pos + 1;
  end;
end.


