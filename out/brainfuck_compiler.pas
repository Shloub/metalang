program brainfuck_compiler;


{
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
}

var
  a : integer;
  b : char;
  current_pos : integer;
  i : integer;
  input : char;
  mem_ : array of integer;
begin
  input := #32;
  current_pos := 500;
  a := 1000;
  SetLength(mem_, a);
  for i := 0 to  a - 1 do
  begin
    mem_[i] := 0;
  end;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  current_pos := current_pos + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  mem_[current_pos] := mem_[current_pos] + 1;
  while mem_[current_pos] <> 0 do
  begin
    mem_[current_pos] := mem_[current_pos] - 1;
    current_pos := current_pos - 1;
    mem_[current_pos] := mem_[current_pos] + 1;
    b := chr(mem_[current_pos]);
    Write(b);
    current_pos := current_pos + 1;
  end;
end.


