
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure min3 is
function min2_0(a : in Integer; b : in Integer) return Integer is
begin
  if a < b
  then
    return a;
  else
    return b;
  end if;
end;


begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(min2_0(min2_0((2),
  (3)), (4))), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(min2_0(min2_0((2),
  (4)), (3))), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(min2_0(min2_0((3),
  (2)), (4))), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(min2_0(min2_0((3),
  (4)), (2))), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(min2_0(min2_0((4),
  (2)), (3))), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(min2_0(min2_0((4),
  (3)), (2))), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
end;
