
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure record2 is
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

type toto;
type toto_PTR is access toto;
type toto is record
  foo : Integer;
  bar : Integer;
  blah : Integer;
end record;

function mktoto(v1 : in Integer) return toto_PTR is
  t : toto_PTR;
begin
  t := new toto;
  t.foo := v1;
  t.bar := (0);
  t.blah := (0);
  return t;
end;

function result(t : in toto_PTR) return Integer is
begin
  t.blah := t.blah + (1);
  return t.foo + t.blah * t.bar + t.bar * t.foo;
end;


  t : toto_PTR;
begin
  t := mktoto((4));
  Get(t.bar);
  SkipSpaces;
  Get(t.blah);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(result(t)), Left));
end;
