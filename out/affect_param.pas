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
  write(a);
  write(''#10'');
end.


