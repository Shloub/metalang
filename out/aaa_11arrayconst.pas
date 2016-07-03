program aaa_11arrayconst;

type a = array of Longint;
procedure test(tab : a; len : Longint);
var
  i : Longint;
begin
  for i := 0 to  len - 1 do
  begin
    Write(tab[i]);
    Write(' ');
  end;
  Write(''#10'');
end;


var
  i : Longint;
  t : a;
begin
  SetLength(t, 5);
  for i := 0 to  4 do
  begin
    t[i] := 1;
  end;
  test(t, 5);
end.


