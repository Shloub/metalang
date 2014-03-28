program tuple;

type
    tuple_int_int=^tuple_int_int_r;
    tuple_int_int_r = record
      tuple_int_int_field_0 : integer;
      tuple_int_int_field_1 : integer;
    end;

function f(tuple_ : tuple_int_int) : tuple_int_int;
var
  a : integer;
  b : integer;
  c : tuple_int_int;
  d : tuple_int_int;
begin
  c := tuple_;
  a := c^.tuple_int_int_field_0;
  b := c^.tuple_int_int_field_1;
  new(d);
  d^.tuple_int_int_field_0 := a
  +
  1;
  d^.tuple_int_int_field_1 := b
  +
  1;
  exit(d);
end;


var
  e : tuple_int_int;
  t : tuple_int_int;
begin
  new(e);
  e^.tuple_int_int_field_0 := 0;
  e^.tuple_int_int_field_1 := 1;
  t := f(e);
end.


