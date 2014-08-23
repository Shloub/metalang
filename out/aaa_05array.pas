program aaa_05array;

type e = array of boolean;
function id(b : e) : e;
begin
  exit(b);
end;

procedure g(t : e; index : Longint);
begin
  t[index] := false;
end;


var
  a : e;
  c : boolean;
  d : boolean;
  i : Longint;
begin
  SetLength(a, 5);
  for i := 0 to  5 - 1 do
  begin
    Write(i);
    a[i] := (i Mod 2) = 0;
  end;
  c := a[0];
  if c
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
  d := a[0];
  if d
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


