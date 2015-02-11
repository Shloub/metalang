
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure loop_unroll is
--
--Ce test permet de vérifier le comportement des macros
--Il effectue du loop unrolling
--


  j : Integer;
begin
  j := (0);
  j := (0);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(j), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  j := (1);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(j), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  j := (2);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(j), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  j := (3);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(j), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  j := (4);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(j), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
end;
