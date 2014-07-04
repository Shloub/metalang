program euler06;


var
  a : Longint;
  carressum : Longint;
  lim : Longint;
  sum : Longint;
  sumcarres : Longint;
begin
  lim := 100;
  sum := (lim * (lim + 1)) Div 2;
  carressum := sum * sum;
  sumcarres := (lim * (lim + 1) * (2 * lim + 1)) Div 6;
  a := carressum - sumcarres;
  Write(a);
end.


