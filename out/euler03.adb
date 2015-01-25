
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;
with Ada.Numerics.Elementary_Functions;
procedure euler03 is

  sqrtia : Integer;
  maximum : Integer;
  found : Boolean;
  e : Integer;
  b0 : Integer;
  b : Integer;
  a : Integer;
begin
  maximum := (1);
  b0 := (2);
  a := (408464633);
  sqrtia := Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(a))));
  while a /= (1) loop
    b := b0;
    found := FALSE;
    while b <= sqrtia loop
      if (a rem b) = (0)
      then
        a := a / b;
        b0 := b;
        b := a;
        e := Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(a))));
        sqrtia := e;
        found := TRUE;
      end if;
      b := b + (1);
    end loop;
    if (not found)
    then
      String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(a), Left));
      String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
      a := (1);
    end if;
  end loop;
end;
