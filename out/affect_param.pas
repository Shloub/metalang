program affect_param;

procedure foo(a : integer);
begin
  a := 4;
end;


var
  a : integer;
begin
  a := 0;
  foo(a);
  Write(a);
  Write(''#10'');
end.


