
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
  e : tuple_int_int_PTR;
begin
  e := new tuple_int_int;
  e.tuple_int_int_field_0 := tuple0.tuple_int_int_field_0 +
  (1);
  e.tuple_int_int_field_1 := tuple0.tuple_int_int_field_1 +
  (1);
  return e;
end;


  t : tuple_int_int_PTR;
  g : tuple_int_int_PTR;
begin
  g := new tuple_int_int;
  g.tuple_int_int_field_0 := (0);
  g.tuple_int_int_field_1 := (1);
  t := f(g);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(t.tuple_int_int_field_0), Left));
  String'Write (Text_Streams.Stream (Current_Output), " -- ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(t.tuple_int_int_field_1), Left));
  String'Write (Text_Streams.Stream (Current_Output), "--" & Character'Val(10) & "");
end;
