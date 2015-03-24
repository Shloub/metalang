
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_02if is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
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
    PString("true <-" & Character'Val(10) & " ->" & Character'Val(10));
  else
    PString("false <-" & Character'Val(10) & " ->" & Character'Val(10));
  end if;
  PString("small test end" & Character'Val(10));
end;
