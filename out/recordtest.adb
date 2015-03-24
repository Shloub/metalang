
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure recordtest is
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

type toto;
type toto_PTR is access toto;
type toto is record
  foo : Integer;
  bar : Integer;
end record;


  param : toto_PTR;
begin
  param := new toto;
  param.foo := 0;
  param.bar := 0;
  Get(param.bar);
  SkipSpaces;
  Get(param.foo);
  PInt(param.bar + param.foo * param.bar);
end;
