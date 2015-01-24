program tuple;

type
    tuple_int_int=^tuple_int_int_r;
    tuple_int_int_r = record
      tuple_int_int_field_0 : Longint;
      tuple_int_int_field_1 : Longint;
    end;

function f(tuple0 : tuple_int_int) : tuple_int_int;
var
  e : tuple_int_int;
begin
  new(e);
  e^.tuple_int_int_field_0 := tuple0^.tuple_int_int_field_0
  +
  1;
  e^.tuple_int_int_field_1 := tuple0^.tuple_int_int_field_1
  +
  1;
  exit(e);
end;


var
  g : tuple_int_int;
  t : tuple_int_int;
begin
  new(g);
  g^.tuple_int_int_field_0 := 0;
  g^.tuple_int_int_field_1 := 1;
  t := f(g);
  Write(t^.tuple_int_int_field_0);
  Write(' -- ');
  Write(t^.tuple_int_int_field_1);
  Write('--'#10'');
end.


