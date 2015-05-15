program euler03;
Uses math;


var
  a : Longint;
  b : Longint;
  b0 : Longint;
  found : boolean;
  maximum : Longint;
  sqrtia : Longint;
begin
  maximum := 1;
  b0 := 2;
  a := 408464633;
  sqrtia := Floor(Sqrt(a));
  while a <> 1 do
  begin
    b := b0;
    found := false;
    while b <= sqrtia do
    begin
      if a Mod b = 0
      then
        begin
          a := a Div b;
          b0 := b;
          b := a;
          sqrtia := Floor(Sqrt(a));
          found := true;
        end;
      b := b + 1;
    end;
    if not(found)
    then
      begin
        Write(a);
        Write(''#10'');
        a := 1;
      end;
  end;
end.


