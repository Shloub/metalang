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
  e : tuple_int_int;
begin
  c := tuple_;
  a := c^.tuple_int_int_field_0;
  b := c^.tuple_int_int_field_1;
  new(e);
  e^.tuple_int_int_field_0 := a
  +
  1;
  e^.tuple_int_int_field_1 := b
  +
  1;
  exit(e);
end;


var
  a : integer;
  b : integer;
  d : tuple_int_int;
  g : tuple_int_int;
  t : tuple_int_int;
begin
  new(g);
  g^.tuple_int_int_field_0 := 0;
  g^.tuple_int_int_field_1 := 1;
  t := f(g);
  d := t;
  a := d^.tuple_int_int_field_0;
  b := d^.tuple_int_int_field_1;
  Write(a);
  Write(' -- ');
  Write(b);
  Write('--'#10'');
end.


