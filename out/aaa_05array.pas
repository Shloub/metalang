program aaa_05array;

type f = array of boolean;
function id(b : f) : f;
begin
  exit(b);
end;

procedure g(t : f; index : Longint);
begin
  t[index] := false;
end;


var
  a : f;
  c : Longint;
  d : boolean;
  e : boolean;
  i : Longint;
begin
  c := 5;
  SetLength(a, c);
  for i := 0 to  c - 1 do
  begin
    Write(i);
    a[i] := (i Mod 2) = 0;
  end;
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
  g(id(a), 0);
  e := a[0];
  if e
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


