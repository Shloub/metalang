
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure affect_param is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

procedure foo(b : in Integer) is
  a : Integer;
begin
  a := b;
  a := 4;
end;


  a : Integer;
begin
  a := 0;
  foo(a);
  PInt(a);
  PString(new char_array'( To_C("" & Character'Val(10))));
end;
