program aaa_03binding;

function g(i : Longint) : Longint;
var
  j : Longint;
begin
  j := i * 4;
  if (j Mod 2) = 1
  then
    begin
      exit(0);
    end;
  exit(j);
end;

procedure h(i : Longint);
begin
  Write(i);
  Write(''#10'');
end;


var
  a : Longint;
  b : Longint;
begin
  h(14);
  a := 4;
  b := 5;
  Write(a + b);
  { main }
  h(15);
  a := 2;
  b := 1;
  Write(a + b);
end.


