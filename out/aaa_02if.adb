
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure aaa_02if is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;

function f(i : in Integer) return Boolean is
begin
  if i = 0
  then
    return TRUE;
  end if;
  return FALSE;
end;

begin
  if f(4)
  then
    PString(new char_array'( To_C("true <-" & Character'Val(10) & " ->" & Character'Val(10))));
  else
    PString(new char_array'( To_C("false <-" & Character'Val(10) & " ->" & Character'Val(10))));
  end if;
  PString(new char_array'( To_C("small test end" & Character'Val(10))));
end;
