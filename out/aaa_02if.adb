
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_02if is
function f(i : in Integer) return Boolean is
begin
  if i = (0)
  then
    return TRUE;
  end if;
  return FALSE;
end;


begin
  if f((4))
  then
    String'Write (Text_Streams.Stream (Current_Output), "true <-" & Character'Val(10) & " ->" & Character'Val(10));
  else
    String'Write (Text_Streams.Stream (Current_Output), "false <-" & Character'Val(10) & " ->" & Character'Val(10));
  end if;
  String'Write (Text_Streams.Stream (Current_Output), "small test end" & Character'Val(10));
end;
