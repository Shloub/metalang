
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure loop_unroll is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
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
  PString(new char_array'( To_C("" & Character'Val(10))));
  j := 1;
  PInt(j);
  PString(new char_array'( To_C("" & Character'Val(10))));
  j := 2;
  PInt(j);
  PString(new char_array'( To_C("" & Character'Val(10))));
  j := 3;
  PInt(j);
  PString(new char_array'( To_C("" & Character'Val(10))));
  j := 4;
  PInt(j);
  PString(new char_array'( To_C("" & Character'Val(10))));
end;
