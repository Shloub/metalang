program euler14;

function next_(n : Longint) : Longint;
begin
  if (n Mod 2) = 0
  then
    begin
      exit(n Div 2);
    end
  else
    begin
      exit(3 * n + 1);
    end;
end;

type a = array of Longint;
function find(n : Longint; m : a) : Longint;
begin
  if n = 1 then
    begin
      exit(1);
    end
  else if n >= 1000000 then
    begin
      exit(1 + find(next_(n), m));
    end
  else if m[n] <> 0
  then
    begin
      exit(m[n]);
    end
  else
    begin
      m[n] := 1 + find(next_(n), m);
      exit(m[n]);
    end;;;
end;


var
  i : Longint;
  j : Longint;
  m : a;
  max_ : Longint;
  maxi : Longint;
  n2 : Longint;
begin
  SetLength(m, 1000000);
  for j := 0 to  1000000 - 1 do
  begin
    m[j] := 0;
  end;
  max_ := 0;
  maxi := 0;
  for i := 1 to  999 do
  begin
    { normalement on met 999999 mais ça dépasse les int32... }
    n2 := find(i, m);
    if n2 > max_
    then
      begin
        max_ := n2;
        maxi := i;
      end;
  end;
  Write(max_);
  Write(''#10'');
  Write(maxi);
  Write(''#10'');
end.


