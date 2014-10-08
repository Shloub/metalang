program euler10;

type a = array of Longint;
function eratostene(t : a; max0 : Longint) : Longint;
var
  i : Longint;
  j : Longint;
  sum : Longint;
begin
  sum := 0;
  for i := 2 to  max0 - 1 do
  begin
    if t[i] = i
    then
      begin
        sum := sum + i;
        j := i * i;
        {
			detect overflow
			}
        if (j Div i) = i
        then
          begin
            while (j < max0) and (j > 0) do
            begin
              t[j] := 0;
              j := j + i;
            end;
          end;
      end;
  end;
  exit(sum);
end;


var
  i : Longint;
  n : Longint;
  t : a;
begin
  n := 100000;
  { normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages }
  SetLength(t, n);
  for i := 0 to  n - 1 do
  begin
    t[i] := i;
  end;
  t[1] := 0;
  Write(eratostene(t, n));
  Write(''#10'');
end.


