program aaa_02if;

function f(i : Longint) : boolean;
begin
  if i = 0
  then
    begin
      exit(true);
    end;
  exit(false);
end;


begin
  if f(4)
  then
    begin
      Write('true <-'#10' ->'#10'');
    end
  else
    begin
      Write('false <-'#10' ->'#10'');
    end;
  Write('small test end'#10'');
end.


