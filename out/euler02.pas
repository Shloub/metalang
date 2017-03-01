program euler02;



var
  a : Longint;
  b : Longint;
  c : Longint;
  sum : Longint;
begin
  a := 1;
  b := 2;
  sum := 0;
  while a < 4000000 do
  begin
    if a Mod 2 = 0
    then
      begin
        sum := sum + a;
      end;
    c := a;
    a := b;
    b := b + c;
  end;
  Write(sum);
  Write(''#10'');
end.


