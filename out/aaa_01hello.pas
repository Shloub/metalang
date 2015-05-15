program aaa_01hello;


var
  a : Longint;
  b : boolean;
  c : boolean;
  d : boolean;
  e : boolean;
  f : boolean;
begin
  Write('Hello World');
  a := 5;
  Write((4 + 6) * 2);
  Write(' ');
  Write(''#10'');
  Write(a);
  Write('foo');
  Write('');
  b := (1 + (1 + 1) * 2 * (3 + 8) Div 4 - (1 - 2) - 3 = 12) and true;
  if b
  then
    begin
      Write('True');
    end
  else
    begin
      Write('False');
    end;
  Write(''#10'');
  c := (3 * (4 + 5 + 6) * 2 = 45) = false;
  if c
  then
    begin
      Write('True');
    end
  else
    begin
      Write('False');
    end;
  Write(' ');
  d := (2 = 1) = false;
  if d
  then
    begin
      Write('True');
    end
  else
    begin
      Write('False');
    end;
  Write(' ');
  Write((4 + 1) Div 3 Div (2 + 1));
  Write(4 * 1 Div 3 Div 2 * 1);
  e := not(not(a = 0) and not(a = 4));
  if e
  then
    begin
      Write('True');
    end
  else
    begin
      Write('False');
    end;
  f := true and not(false) and not(true and false);
  if f
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


