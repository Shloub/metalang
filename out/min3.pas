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

function min3_(a : Longint; b : Longint; c : Longint) : Longint;
begin
  exit(min2(min2(a, b), c));
end;


var
  ba : Longint;
  d : Longint;
  e : Longint;
  f : Longint;
  g : Longint;
  h : Longint;
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
  s : Longint;
  t : Longint;
  u : Longint;
  v : Longint;
  w : Longint;
  x : Longint;
  y : Longint;
  z : Longint;
begin
  e := 2;
  f := 3;
  g := 4;
  d := min2(min2(e, f), g);
  Write(d);
  Write(' ');
  i := 2;
  j := 4;
  k := 3;
  h := min2(min2(i, j), k);
  Write(h);
  Write(' ');
  m := 3;
  n := 2;
  o := 4;
  l := min2(min2(m, n), o);
  Write(l);
  Write(' ');
  q := 3;
  r := 4;
  s := 2;
  p := min2(min2(q, r), s);
  Write(p);
  Write(' ');
  u := 4;
  v := 2;
  w := 3;
  t := min2(min2(u, v), w);
  Write(t);
  Write(' ');
  y := 4;
  z := 3;
  ba := 2;
  x := min2(min2(y, z), ba);
  Write(x);
  Write(''#10'');
end.


