
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure aaa_01hello is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;


  a : Integer;
begin
  PString(new char_array'( To_C("Hello World")));
  a := 5;
  PInt((4 + 6) * 2);
  PString(new char_array'( To_C(" " & Character'Val(10))));
  PInt(a);
  PString(new char_array'( To_C("foo")));
  if 1 + 2 * 2 * (3 + 8) / 4 - 2 = 12 and then TRUE
  then
    PString(new char_array'( To_C("True")));
  else
    PString(new char_array'( To_C("False")));
  end if;
  PString(new char_array'( To_C("" & Character'Val(10))));
  if (3 * (4 + 11) * 2 = 45) = FALSE
  then
    PString(new char_array'( To_C("True")));
  else
    PString(new char_array'( To_C("False")));
  end if;
  PString(new char_array'( To_C(" ")));
  if (2 = 1) = FALSE
  then
    PString(new char_array'( To_C("True")));
  else
    PString(new char_array'( To_C("False")));
  end if;
  PString(new char_array'( To_C(" ")));
  PInt(5 / 3 / 3);
  PInt(4 * 1 / 3 / 2 * 1);
  if not (not (a = 0) and then not (a = 4))
  then
    PString(new char_array'( To_C("True")));
  else
    PString(new char_array'( To_C("False")));
  end if;
  if (TRUE and then not FALSE) and then not (TRUE and then FALSE)
  then
    PString(new char_array'( To_C("True")));
  else
    PString(new char_array'( To_C("False")));
  end if;
  PString(new char_array'( To_C("" & Character'Val(10))));
end;
