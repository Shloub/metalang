program aaa_05array;


var
  a : array of Longint;
  b : Longint;
  i : Longint;
begin
  b := 5;
  SetLength(a, b);
  for i := 0 to  b - 1 do
  begin
    Write(i);
    a[i] := i * 2;
  end;
end.


