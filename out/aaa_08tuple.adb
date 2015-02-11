
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_08tuple is
procedure SkipSpaces is
  C : Character;
  Eol : Boolean;
begin
  loop
    Look_Ahead(C, Eol);
    exit when Eol or C /= ' ';
    Get(C);
  end loop;
end;

type tuple_int_int;
type tuple_int_int_PTR is access tuple_int_int;
type tuple_int_int is record
  tuple_int_int_field_0 : Integer;
  tuple_int_int_field_1 : Integer;
end record;


type toto;
type toto_PTR is access toto;
type toto is record
  foo : tuple_int_int_PTR;
  bar : Integer;
end record;


  t : toto_PTR;
  f : tuple_int_int_PTR;
  e : tuple_int_int_PTR;
  d : Integer;
  c : Integer;
  bar_0 : Integer;
  b : Integer;
  a : Integer;
begin
  Get(bar_0);
  SkipSpaces;
  Get(c);
  SkipSpaces;
  Get(d);
  SkipSpaces;
  e := new tuple_int_int;
  e.tuple_int_int_field_0 := c;
  e.tuple_int_int_field_1 := d;
  t := new toto;
  t.foo := e;
  t.bar := bar_0;
  f := t.foo;
  a := f.tuple_int_int_field_0;
  b := f.tuple_int_int_field_1;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(a), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(b), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(t.bar), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
end;
