
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure affect_param is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
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
  PString("" & Character'Val(10));
end;
