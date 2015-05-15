program aaa_04loop;

function h(i : Longint) : boolean;
var
  j : Longint;
begin
  {  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end }
  j := i - 2;
  while j <= i + 2 do
  begin
    if i Mod j = 5
    then
      begin
        exit(true);
      end;
    j := j + 1;
  end;
  exit(false);
end;


var
  i : Longint;
  j : Longint;
  k : Longint;
begin
  j := 0;
  for k := 0 to  10 do
  begin
    j := j + k;
    Write(j);
    Write(''#10'');
  end;
  i := 4;
  while i < 10 do
  begin
    Write(i);
    i := i + 1;
    j := j + i;
  end;
  Write(j);
  Write(i);
  Write('FIN TEST'#10'');
end.


