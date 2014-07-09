program euler06;


var
  carressum : Longint;
  lim : Longint;
  sum : Longint;
  sumcarres : Longint;
begin
  lim := 100;
  sum := (lim * (lim + 1)) Div 2;
  carressum := sum * sum;
  sumcarres := (lim * (lim + 1) * (2 * lim + 1)) Div 6;
  Write(carressum - sumcarres);
end.


