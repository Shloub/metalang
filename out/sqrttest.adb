
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;
with Ada.Numerics.Elementary_Functions;
procedure sqrttest is

begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float((4)))))), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float((16)))))), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float((20)))))), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float((1000)))))), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float((500)))))), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float((10)))))), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
end;
