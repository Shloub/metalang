
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_01hello is

  a : Integer;
begin
  String'Write (Text_Streams.Stream (Current_Output), "Hello World");
  a := (5);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(
  ((4) + (6)) * (2)), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(a), Left));
  String'Write (Text_Streams.Stream (Current_Output), "foo");
  String'Write (Text_Streams.Stream (Current_Output), "");
end;
