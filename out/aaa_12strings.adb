
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure aaa_12strings is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;


begin
  PString(new char_array'( To_C("tada " & Character'Val(39) & " " & Character'Val(34) & " " & Character'Val(10) & Character'Val(13) & Character'Val(9) & " " & Character'Val(36) & " & todo" & Character'Val(10) & Character'Val(10) & "{foo} " & Character'Val(92) & Character'Val(36) & "{blah}" & Character'Val(10) & "blah" & Character'Val(10))));
end;
