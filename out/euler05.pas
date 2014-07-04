program euler05;

function max2(a : Longint; b : Longint) : Longint;
begin
  if a > b
  then
    begin
      exit(a);
    end
  else
    begin
      exit(b);
    end;
end;

type f = array of Longint;
function primesfactors(n : Longint) : f;
var
  c : Longint;
  d : Longint;
  i : Longint;
  tab : f;
begin
  c := n + 1;
  SetLength(tab, c);
  for i := 0 to  c - 1 do
  begin
    tab[i] := 0;
  end;
  d := 2;
  while (n <> 1) and ((d * d) <= n) do
  begin
    if (n Mod d) = 0
    then
      begin
        tab[d] := tab[d] + 1;
        n := n Div d;
      end
    else
      begin
        d := d + 1;
      end;
  end;
  tab[n] := tab[n] + 1;
  exit(tab);
end;


var
  e : Longint;
  i : Longint;
  j : Longint;
  k : Longint;
  l : Longint;
  lim : Longint;
  m : Longint;
  o : f;
  product : Longint;
  t : f;
begin
  lim := 20;
  e := lim + 1;
  SetLength(o, e);
  for m := 0 to  e - 1 do
  begin
    o[m] := 0;
  end;
  for i := 1 to  lim do
  begin
    t := primesfactors(i);
    for j := 1 to  i do
    begin
      o[j] := max2(o[j], t[j]);
    end;
  end;
  product := 1;
  for k := 1 to  lim do
  begin
    for l := 1 to  o[k] do
    begin
      product := product * k;
    end;
  end;
  Write(product);
  Write(''#10'');
end.


