program sqrttest;
Uses math;

function isqrt(c : Longint) : Longint;
begin
  exit(Floor(Sqrt(c)));
end;


var
  a : Longint;
  b : Longint;
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
begin
  b := 4;
  a := Floor(Sqrt(b));
  Write(a);
  Write(' ');
  e := 16;
  d := Floor(Sqrt(e));
  Write(d);
  Write(' ');
  g := 20;
  f := Floor(Sqrt(g));
  Write(f);
  Write(' ');
  i := 1000;
  h := Floor(Sqrt(i));
  Write(h);
  Write(' ');
  k := 500;
  j := Floor(Sqrt(k));
  Write(j);
  Write(' ');
  m := 10;
  l := Floor(Sqrt(m));
  Write(l);
  Write(' ');
end.


