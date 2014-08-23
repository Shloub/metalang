program min3;

function min2(a : Longint; b : Longint) : Longint;
begin
  if a < b
  then
    begin
      exit(a);
    end
  else
    begin
      exit(b);
    end;
end;


var
  ba : Longint;
  e : Longint;
  f : Longint;
  g : Longint;
  i : Longint;
  j : Longint;
  k : Longint;
  m : Longint;
  n : Longint;
  o : Longint;
  q : Longint;
  r : Longint;
  s : Longint;
  u : Longint;
  v : Longint;
  w : Longint;
  y : Longint;
  z : Longint;
begin
  e := 2;
  f := 3;
  g := 4;
  Write(min2(min2(e, f), g));
  Write(' ');
  i := 2;
  j := 4;
  k := 3;
  Write(min2(min2(i, j), k));
  Write(' ');
  m := 3;
  n := 2;
  o := 4;
  Write(min2(min2(m, n), o));
  Write(' ');
  q := 3;
  r := 4;
  s := 2;
  Write(min2(min2(q, r), s));
  Write(' ');
  u := 4;
  v := 2;
  w := 3;
  Write(min2(min2(u, v), w));
  Write(' ');
  y := 4;
  z := 3;
  ba := 2;
  Write(min2(min2(y, z), ba));
  Write(''#10'');
end.


