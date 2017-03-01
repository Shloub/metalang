
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure aaa_08tuple is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

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
  PInt(a);
  PString(new char_array'( To_C(" ")));
  PInt(b);
  PString(new char_array'( To_C(" ")));
  PInt(t.bar);
  PString(new char_array'( To_C("" & Character'Val(10))));
end;
