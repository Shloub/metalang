program euler05;

function max2_(a : Longint; b : Longint) : Longint;
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

type p = array of Longint;
function primesfactors(n : Longint) : p;
var
  d : Longint;
  i : Longint;
  tab : p;
begin
  SetLength(tab, n + 1);
  for i := 0 to  n + 1 - 1 do
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
  f : Longint;
  g : Longint;
  h : Longint;
  i : Longint;
  j : Longint;
  k : Longint;
  l : Longint;
  lim : Longint;
  m : Longint;
  o : p;
  product : Longint;
  t : p;
begin
  lim := 20;
  SetLength(o, lim + 1);
  for m := 0 to  lim + 1 - 1 do
  begin
    o[m] := 0;
  end;
  for i := 1 to  lim do
  begin
    t := primesfactors(i);
    for j := 1 to  i do
    begin
      g := o[j];
      h := t[j];
      f := max2_(g, h);
      o[j] := f;
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


