
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler06 is

  sumcarres : Integer;
  sum : Integer;
  lim : Integer;
  carressum : Integer;
begin
  lim := (100);
  sum := (lim * (lim + (1))) / (2);
  carressum := sum * sum;
  sumcarres := (lim * (lim + (1)) * ((2) * lim + (1))) / (6);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(carressum -
  sumcarres), Left));
end;