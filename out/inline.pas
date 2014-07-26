program inline;

procedure foo(i : Longint);
begin
  Write(i);
  Write(''#10'');
end;

procedure foobar(i : Longint);
begin
  Write(i);
  Write(''#10'');
  Write('foobar');
end;


var
  a : Longint;
  b : Longint;
  c : Longint;
begin
  a := 0;
  Write(a);
  Write(''#10'');
  b := 12;
  Write(b);
  Write(''#10'');
  Write('foobar');
  c := 1;
  Write(c);
  Write(''#10'');
end.


