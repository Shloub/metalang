
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure loop_unroll is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;
--
--Ce test permet de vérifier le comportement des macros
--Il effectue du loop unrolling
--


  j : Integer;
begin
  j := 0;
  j := 0;
  PInt(j);
  PString("" & Character'Val(10));
  j := 1;
  PInt(j);
  PString("" & Character'Val(10));
  j := 2;
  PInt(j);
  PString("" & Character'Val(10));
  j := 3;
  PInt(j);
  PString("" & Character'Val(10));
  j := 4;
  PInt(j);
  PString("" & Character'Val(10));
end;
