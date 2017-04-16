program tuple;

type tuple_int_int=^tuple_int_int_r;
  tuple_int_int_r = record
    tuple_int_int_field_0 : Longint;
    tuple_int_int_field_1 : Longint;
  end;

function f(tuple0 : tuple_int_int) : tuple_int_int;
var
  a : Longint;
  b : Longint;
  c : tuple_int_int;
  d : tuple_int_int;
begin
  c := tuple0;
  a := c^.tuple_int_int_field_0;
  b := c^.tuple_int_int_field_1;
  new(d);
  d^.tuple_int_int_field_0 := a + 1;
  d^.tuple_int_int_field_1 := b + 1;
  exit(d);
end;


var
  a : Longint;
  b : Longint;
  e : tuple_int_int;
  g : tuple_int_int;
  t : tuple_int_int;
begin
  new(e);
  e^.tuple_int_int_field_0 := 0;
  e^.tuple_int_int_field_1 := 1;
  t := f(e);
  g := t;
  a := g^.tuple_int_int_field_0;
  b := g^.tuple_int_int_field_1;
  Write(a);
  Write(' -- ');
  Write(b);
  Write('--'#10'');
end.


