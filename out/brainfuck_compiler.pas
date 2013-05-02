program brainfuck_compiler;


{
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
}

var
  c : integer;
  current_pos : integer;
  d : char;
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
    d := chr(mem[current_pos]);
    write(d);
    current_pos := current_pos + 1;
  end;
end.


