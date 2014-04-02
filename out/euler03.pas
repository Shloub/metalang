program euler03;



var
  a : Longint;
  b : Longint;
  b0 : Longint;
  found : boolean;
  maximum : Longint;
begin
  maximum := 1;
  b0 := 2;
  a := 408464633;
  while a <> 1 do
  begin
    b := b0;
    found := false;
    while (b * b) < a do
    begin
      if (a Mod b) = 0
      then
        begin
          a := a Div b;
          b0 := b;
          b := a;
          found := true;
        end;
      b := b + 1;
    end;
    if not found
    then
      begin
        Write(a);
        Write(''#10'');
        a := 1;
      end;
  end;
end.


