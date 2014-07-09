program euler09;


var
  a : Longint;
  a2b2 : Longint;
  b : Longint;
  c : Longint;
  cc : Longint;
begin
  {
	a + b + c = 1000 && a * a + b * b = c * c
	}
  for a := 1 to  1000 do
  begin
    for b := a + 1 to  1000 do
    begin
      c := 1000 - a - b;
      a2b2 := a * a + b * b;
      cc := c * c;
      if (cc = a2b2) and (c > a)
      then
        begin
          Write(a);
          Write(''#10'');
          Write(b);
          Write(''#10'');
          Write(c);
          Write(''#10'');
          Write(a * b * c);
          Write(''#10'');
        end;
    end;
  end;
end.


