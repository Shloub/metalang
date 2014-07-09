program calc;

{
La suite de fibonaci
}
function fibo(a : Longint; b : Longint; i : Longint) : Longint;
var
  a2 : Longint;
  b2 : Longint;
  j : Longint;
  out_ : Longint;
  tmp : Longint;
begin
  out_ := 0;
  a2 := a;
  b2 := b;
  for j := 0 to  i + 1 do
  begin
    Write(j);
    out_ := out_ + a2;
    tmp := b2;
    b2 := b2 + a2;
    a2 := tmp;
  end;
  exit(out_);
end;


begin
  Write(fibo(1, 2, 4));
end.


