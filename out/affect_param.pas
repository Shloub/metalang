program affect_param;

procedure foo(a : Longint);
begin
  a := 4;
end;


var
  a : Longint;
begin
  a := 0;
  foo(a);
  Write(a);
  Write(''#10'');
end.


