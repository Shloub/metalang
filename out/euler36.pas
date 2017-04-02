program euler36;

type e = array of boolean;
type f = array of Longint;
function palindrome2(pow2 : f; n : Longint) : boolean;
var
  i : Longint;
  j : Longint;
  k : Longint;
  nnum : Longint;
  t : e;
begin
  SetLength(t, 20);
  for i := 0 to  19 do
  begin
    t[i] := n Div pow2[i] Mod 2 = 1;
  end;
  nnum := 0;
  for j := 1 to  19 do
  begin
    if t[j]
    then
      begin
        nnum := j;
      end;
  end;
  for k := 0 to  nnum Div 2 do
  begin
    if t[k] <> t[nnum - k]
    then
      begin
        exit(false);
      end;
  end;
  exit(true);
end;


var
  a : Longint;
  a0 : Longint;
  b : Longint;
  c : Longint;
  d : Longint;
  i : Longint;
  num0 : Longint;
  num1 : Longint;
  num2 : Longint;
  num3 : Longint;
  p : Longint;
  pow2 : f;
  sum : Longint;
begin
  p := 1;
  SetLength(pow2, 20);
  for i := 0 to  19 do
  begin
    p := p * 2;
    pow2[i] := p Div 2;
  end;
  sum := 0;
  for d := 1 to  9 do
  begin
    if palindrome2(pow2, d)
    then
      begin
        Write(d);
        Write(''#10'');
        sum := sum + d;
      end;
    if palindrome2(pow2, d * 10 + d)
    then
      begin
        Write(d * 10 + d);
        Write(''#10'');
        sum := sum + d * 10 + d;
      end;
  end;
  for a0 := 0 to  4 do
  begin
    a := a0 * 2 + 1;
    for b := 0 to  9 do
    begin
      for c := 0 to  9 do
      begin
        num0 := a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a;
        if palindrome2(pow2, num0)
        then
          begin
            Write(num0);
            Write(''#10'');
            sum := sum + num0;
          end;
        num1 := a * 10000 + b * 1000 + c * 100 + b * 10 + a;
        if palindrome2(pow2, num1)
        then
          begin
            Write(num1);
            Write(''#10'');
            sum := sum + num1;
          end;
      end;
      num2 := a * 100 + b * 10 + a;
      if palindrome2(pow2, num2)
      then
        begin
          Write(num2);
          Write(''#10'');
          sum := sum + num2;
        end;
      num3 := a * 1000 + b * 100 + b * 10 + a;
      if palindrome2(pow2, num3)
      then
        begin
          Write(num3);
          Write(''#10'');
          sum := sum + num3;
        end;
    end;
  end;
  Write('sum=');
  Write(sum);
  Write(''#10'');
end.


