program euler24;

function fact(n : Longint) : Longint;
var
  i : Longint;
  prod : Longint;
begin
  prod := 1;
  for i := 2 to  n do
  begin
    prod := prod * i;
  end;
  exit(prod);
end;

type a = array of Longint;
type b = array of boolean;
procedure show(lim : Longint; nth : Longint);
var
  i : Longint;
  j : Longint;
  k : Longint;
  l : Longint;
  m : Longint;
  n : Longint;
  nchiffre : Longint;
  pris : b;
  t : a;
begin
  SetLength(t, lim);
  for i := 0 to  lim - 1 do
  begin
    t[i] := i;
  end;
  SetLength(pris, lim);
  for j := 0 to  lim - 1 do
  begin
    pris[j] := false;
  end;
  for k := 1 to  lim - 1 do
  begin
    n := fact(lim - k);
    nchiffre := nth Div n;
    nth := nth Mod n;
    for l := 0 to  lim - 1 do
    begin
      if not(pris[l])
      then
        begin
          if nchiffre = 0
          then
            begin
              Write(l);
              pris[l] := true;
            end;
          nchiffre := nchiffre - 1;
        end;
    end;
  end;
  for m := 0 to  lim - 1 do
  begin
    if not(pris[m])
    then
      begin
        Write(m);
      end;
  end;
  Write(''#10'');
end;


begin
  show(10, 999999);
end.


