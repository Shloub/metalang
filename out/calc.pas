program calc;

{
La suite de fibonaci
}
function fibo(a : integer; b : integer; i : integer) : integer;
var
  a2 : integer;
  b2 : integer;
  j : integer;
  out_ : integer;
  tmp : integer;
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


var
  c : integer;
begin
  c := fibo(1, 2, 4);
  Write(c);
end.


