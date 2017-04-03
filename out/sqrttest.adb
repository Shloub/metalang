
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;
with Ada.Numerics.Elementary_Functions;
procedure sqrttest is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;


begin
  PInt(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(4)))));
  PString(new char_array'( To_C(" ")));
  PInt(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(16)))));
  PString(new char_array'( To_C(" ")));
  PInt(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(20)))));
  PString(new char_array'( To_C(" ")));
  PInt(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(1000)))));
  PString(new char_array'( To_C(" ")));
  PInt(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(500)))));
  PString(new char_array'( To_C(" ")));
  PInt(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(10)))));
  PString(new char_array'( To_C(" ")));
end;
