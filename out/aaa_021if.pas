program aaa_021if;

procedure testA(a : boolean; b : boolean);
begin
  if a then
    begin
      if b
      then
        begin
          Write('A');
        end
      else
        begin
          Write('B');
        end;
    end
  else if b
  then
    begin
      Write('C');
    end
  else
    begin
      Write('D');
    end;;
end;

procedure testB(a : boolean; b : boolean);
begin
  if a then
    begin
      Write('A');
    end
  else if b
  then
    begin
      Write('B');
    end
  else
    begin
      Write('C');
    end;;
end;

procedure testC(a : boolean; b : boolean);
begin
  if a
  then
    begin
      if b
      then
        begin
          Write('A');
        end
      else
        begin
          Write('B');
        end;
    end
  else
    begin
      Write('C');
    end;
end;

procedure testD(a : boolean; b : boolean);
begin
  if a
  then
    begin
      if b
      then
        begin
          Write('A');
        end
      else
        begin
          Write('B');
        end;
      Write('C');
    end
  else
    begin
      Write('D');
    end;
end;

procedure testE(a : boolean; b : boolean);
begin
  if a
  then
    begin
      if b
      then
        begin
          Write('A');
        end;
    end
  else
    begin
      if b
      then
        begin
          Write('C');
        end
      else
        begin
          Write('D');
        end;
      Write('E');
    end;
end;

procedure test(a : boolean; b : boolean);
begin
  testD(a, b);
  testE(a, b);
  Write(''#10'');
end;


begin
  test(true, true);
  test(true, false);
  test(false, true);
  test(false, false);
end.


