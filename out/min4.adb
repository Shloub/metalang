
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure min4 is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

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
  PInt(min2_0(min2_0(min2_0(1, 2), 3), 4));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(1, 2), 4), 3));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(1, 3), 2), 4));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(1, 3), 4), 2));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(1, 4), 2), 3));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(1, 4), 3), 2));
  PString(new char_array'( To_C("" & Character'Val(10))));
  PInt(min2_0(min2_0(min2_0(2, 1), 3), 4));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(2, 1), 4), 3));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(2, 3), 1), 4));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(2, 3), 4), 1));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(2, 4), 1), 3));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(2, 4), 3), 1));
  PString(new char_array'( To_C("" & Character'Val(10))));
  PInt(min2_0(min2_0(min2_0(3, 1), 2), 4));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(3, 1), 4), 2));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(3, 2), 1), 4));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(3, 2), 4), 1));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(3, 4), 1), 2));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(3, 4), 2), 1));
  PString(new char_array'( To_C("" & Character'Val(10))));
  PInt(min2_0(min2_0(min2_0(4, 1), 2), 3));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(4, 1), 3), 2));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(4, 2), 1), 3));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(4, 2), 3), 1));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(4, 3), 1), 2));
  PString(new char_array'( To_C(" ")));
  PInt(min2_0(min2_0(min2_0(4, 3), 2), 1));
  PString(new char_array'( To_C("" & Character'Val(10))));
end;
