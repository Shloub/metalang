program euler10;

type b = array of Longint;
function eratostene(t : b; max_ : Longint) : Longint;
var
  i : Longint;
  j : Longint;
  sum : Longint;
begin
  sum := 0;
  for i := 2 to  max_ - 1 do
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
            while (j < max_) and (j > 0) do
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
  a : Longint;
  i : Longint;
  n : Longint;
  t : b;
begin
  n := 100000;
  { normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages }
  SetLength(t, n);
  for i := 0 to  n - 1 do
  begin
    t[i] := i;
  end;
  t[1] := 0;
  a := eratostene(t, n);
  Write(a);
  Write(''#10'');
end.


