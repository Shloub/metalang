program aaa_04loop;


var
  i : Longint;
  j : Longint;
  k : Longint;
begin
  j := 0;
  for k := 0 to  10 do
  begin
    j := j + k;
    Write(j);
    Write(''#10'');
  end;
  i := 4;
  while i < 10 do
  begin
    Write(i);
    i := i + 1;
    j := j + i;
  end;
  Write(j);
  Write(i);
  Write('FIN TEST'#10'');
end.


