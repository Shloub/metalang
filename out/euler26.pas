program euler26;

type c = array of Longint;
function periode(restes : c; len : Longint; a : Longint; b : Longint) : Longint;
var
  chiffre : Longint;
  i : Longint;
  reste : Longint;
begin
  while a <> 0 do
  begin
    chiffre := a Div b;
    reste := a Mod b;
    for i := 0 to  len - 1 do
    begin
      if restes[i] = reste
      then
        begin
          exit(len - i);
        end;
    end;
    restes[len] := reste;
    len := len + 1;
    a := reste * 10;
  end;
  exit(0);
end;


var
  i : Longint;
  j : Longint;
  m : Longint;
  mi : Longint;
  p : Longint;
  t : c;
begin
  SetLength(t, 1000);
  for j := 0 to  999 do
  begin
    t[j] := 0;
  end;
  m := 0;
  mi := 0;
  for i := 1 to  1000 do
  begin
    p := periode(t, 0, 1, i);
    if p > m
    then
      begin
        mi := i;
        m := p;
      end;
  end;
  Write(mi);
  Write(''#10'');
  Write(m);
  Write(''#10'');
end.


