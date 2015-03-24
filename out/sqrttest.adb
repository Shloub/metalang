
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;
with Ada.Numerics.Elementary_Functions;
procedure sqrttest is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

begin
  PInt(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(4)))));
  PString(" ");
  PInt(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(16)))));
  PString(" ");
  PInt(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(20)))));
  PString(" ");
  PInt(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(1000)))));
  PString(" ");
  PInt(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(500)))));
  PString(" ");
  PInt(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(10)))));
  PString(" ");
end;
