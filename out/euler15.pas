program euler15;



var
  a : Longint;
  b : Longint;
  i : Longint;
  j : Longint;
  k : Longint;
  l : Longint;
  m : Longint;
  n : Longint;
  o : Longint;
  p : Longint;
  q : Longint;
  r : Longint;
  tab : array of array of Longint;
  tab2 : array of Longint;
begin
  n := 10;
  { normalement on doit mettre 20 mais là on se tape un overflow }
  n := n + 1;
  SetLength(tab, n);
  for i := 0 to  n - 1 do
  begin
    SetLength(tab2, n);
    for j := 0 to  n - 1 do
    begin
      tab2[j] := 0;
    end;
    tab[i] := tab2;
  end;
  for l := 0 to  n - 1 do
  begin
    tab[n - 1][l] := 1;
    tab[l][n - 1] := 1;
  end;
  for o := 2 to  n do
  begin
    r := n - o;
    for p := 2 to  n do
    begin
      q := n - p;
      tab[r][q] := tab[r + 1][q] + tab[r][q + 1];
    end;
  end;
  for m := 0 to  n - 1 do
  begin
    for k := 0 to  n - 1 do
    begin
      a := tab[m][k];
      Write(a);
      Write(' ');
    end;
    Write(''#10'');
  end;
  b := tab[0][0];
  Write(b);
  Write(''#10'');
end.


