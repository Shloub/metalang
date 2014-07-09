program sqrttest;
Uses math;

function isqrt(c : Longint) : Longint;
begin
  exit(Floor(Sqrt(c)));
end;


begin
  Write(isqrt(4));
  Write(' ');
  Write(isqrt(16));
  Write(' ');
  Write(isqrt(20));
  Write(' ');
  Write(isqrt(1000));
  Write(' ');
  Write(isqrt(500));
  Write(' ');
  Write(isqrt(10));
  Write(' ');
end.


