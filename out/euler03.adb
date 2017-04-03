
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;
with Ada.Numerics.Elementary_Functions;
procedure euler03 is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;


  sqrtia : Integer;
  maximum : Integer;
  found : Boolean;
  b0 : Integer;
  b : Integer;
  a : Integer;
begin
  maximum := 1;
  b0 := 2;
  a := 408464633;
  sqrtia := Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(a))));
  while a /= 1 loop
    b := b0;
    found := FALSE;
    while b <= sqrtia loop
      if a rem b = 0
      then
        a := a / b;
        b0 := b;
        b := a;
        sqrtia := Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(a))));
        found := TRUE;
      end if;
      b := b + 1;
    end loop;
    if not found
    then
      PInt(a);
      PString(new char_array'( To_C("" & Character'Val(10))));
      a := 1;
    end if;
  end loop;
end;
