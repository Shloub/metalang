
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure test_instant is
function foo(a : in Integer; b : in Integer) return Integer is
begin
  return a + b;
end;


begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image((10)), Left));
end;
