
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure euler02 is


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
  c : Integer;
  b : Integer;
  a : Integer;
begin
  a := 1;
  b := 2;
  sum := 0;
  while a < 4000000 loop
    if a rem 2 = 0
    then
      sum := sum + a;
    end if;
    c := a;
    a := b;
    b := b + c;
  end loop;
  PInt(sum);
  PString(new char_array'( To_C("" & Character'Val(10))));
end;
