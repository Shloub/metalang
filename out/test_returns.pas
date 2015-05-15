program test_returns;

function is_pair(i : Longint) : boolean;
var
  j : Longint;
begin
  j := 1;
  if i < 10
  then
    begin
      j := 2;
      if i = 0
      then
        begin
          j := 4;
          exit(true);
        end;
      j := 3;
      if i = 2
      then
        begin
          j := 4;
          exit(true);
        end;
      j := 5;
    end;
  j := 6;
  if i < 20
  then
    begin
      if i = 22
      then
        begin
          j := 0;
        end;
      j := 8;
    end;
  exit(i Mod 2 = 0);
end;


begin
  
end.


