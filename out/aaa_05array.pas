program aaa_05array;

type c = array of boolean;
function id(b : c) : c;
begin
  exit(b);
end;

procedure g(t : c; index : Longint);
begin
  t[index] := false;
end;


var
  a : c;
  i : Longint;
  j : Longint;
begin
  j := 0;
  SetLength(a, 5);
  for i := 0 to  5 - 1 do
  begin
    Write(i);
    j := j + i;
    a[i] := i Mod 2 = 0;
  end;
  Write(j);
  Write(' ');
  if a[0]
  then
    begin
      Write('True');
    end
  else
    begin
      Write('False');
    end;
  Write(''#10'');
  g(id(a), 0);
  if a[0]
  then
    begin
      Write('True');
    end
  else
    begin
      Write('False');
    end;
  Write(''#10'');
end.


