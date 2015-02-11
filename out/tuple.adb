
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure tuple is

type tuple_int_int;
type tuple_int_int_PTR is access tuple_int_int;
type tuple_int_int is record
  tuple_int_int_field_0 : Integer;
  tuple_int_int_field_1 : Integer;
end record;

function f(tuple0 : in tuple_int_int_PTR) return tuple_int_int_PTR is
  d : tuple_int_int_PTR;
  c : tuple_int_int_PTR;
  b : Integer;
  a : Integer;
begin
  c := tuple0;
  a := c.tuple_int_int_field_0;
  b := c.tuple_int_int_field_1;
  d := new tuple_int_int;
  d.tuple_int_int_field_0 := a +
  (1);
  d.tuple_int_int_field_1 := b +
  (1);
  return d;
end;


  t : tuple_int_int_PTR;
  g : tuple_int_int_PTR;
  e : tuple_int_int_PTR;
  b : Integer;
  a : Integer;
begin
  e := new tuple_int_int;
  e.tuple_int_int_field_0 := (0);
  e.tuple_int_int_field_1 := (1);
  t := f(e);
  g := t;
  a := g.tuple_int_int_field_0;
  b := g.tuple_int_int_field_1;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(a), Left));
  String'Write (Text_Streams.Stream (Current_Output), " -- ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(b), Left));
  String'Write (Text_Streams.Stream (Current_Output), "--" & Character'Val(10));
end;
