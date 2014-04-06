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
begin
  a := isqrt(4);
  Write(a);
  Write(' ');
  b := isqrt(16);
  Write(b);
  Write(' ');
  d := isqrt(20);
  Write(d);
  Write(' ');
  e := isqrt(1000);
  Write(e);
  Write(' ');
  f := isqrt(500);
  Write(f);
  Write(' ');
  g := isqrt(10);
  Write(g);
  Write(' ');
end.


