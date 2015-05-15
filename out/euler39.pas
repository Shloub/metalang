program euler39;
Uses math;

type d = array of Longint;

var
  a : Longint;
  b : Longint;
  c : Longint;
  c2 : Longint;
  i : Longint;
  j : Longint;
  k : Longint;
  p : Longint;
  t : d;
begin
  SetLength(t, 1001);
  for i := 0 to  1001 - 1 do
  begin
    t[i] := 0;
  end;
  for a := 1 to  1000 do
  begin
    for b := 1 to  1000 do
    begin
      c2 := a * a + b * b;
      c := Floor(Sqrt(c2));
      if c * c = c2
      then
        begin
          p := a + b + c;
          if p <= 1000
          then
            begin
              t[p] := t[p] + 1;
            end;
        end;
    end;
  end;
  j := 0;
  for k := 1 to  1000 do
  begin
    if t[k] > t[j]
    then
      begin
        j := k;
      end;
  end;
  Write(j);
end.


