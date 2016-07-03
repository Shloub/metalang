program aaa_01hello;


var
  a : Longint;
begin
  Write('Hello World');
  a := 5;
  Write((4 + 6) * 2);
  Write(' '#10'');
  Write(a);
  Write('foo');
  if (1 + 2 * 2 * (3 + 8) Div 4 - 2 = 12) and true
  then
    begin
      Write('True');
    end
  else
    begin
      Write('False');
    end;
  Write(''#10'');
  if (3 * (4 + 11) * 2 = 45) = false
  then
    begin
      Write('True');
    end
  else
    begin
      Write('False');
    end;
  Write(' ');
  if (2 = 1) = false
  then
    begin
      Write('True');
    end
  else
    begin
      Write('False');
    end;
  Write(' ');
  Write(5 Div 3 Div 3);
  Write(4 * 1 Div 3 Div 2 * 1);
  if not(not(a = 0) and not(a = 4))
  then
    begin
      Write('True');
    end
  else
    begin
      Write('False');
    end;
  if true and not(false) and not(true and false)
  then
    begin
      Write('True');
    end
  else
    begin
      Write('False');
    end;
  Write(''#10'');
end.


