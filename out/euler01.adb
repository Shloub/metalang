
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure euler01 is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
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
  PString(new char_array'( To_C("" & Character'Val(10))));
end;
