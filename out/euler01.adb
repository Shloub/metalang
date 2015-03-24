
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler01 is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

  sum : Integer;
begin
  sum := 0;
  for i in integer range 0..999 loop
    if (i rem 3) = 0 or else (i rem 5) = 0
    then
      sum := sum + i;
    end if;
  end loop;
  PInt(sum);
  PString("" & Character'Val(10));
end;
