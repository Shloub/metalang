program euler01;



var
  i : Longint;
  sum : Longint;
begin
  sum := 0;
  for i := 0 to  999 do
  begin
    if (i Mod 3 = 0) or (i Mod 5 = 0)
    then
      begin
        sum := sum + i;
      end;
  end;
  Write(sum);
  Write(''#10'');
end.


