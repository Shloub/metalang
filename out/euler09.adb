
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure euler09 is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

  cc : Integer;
  c : Integer;
  a2b2 : Integer;
begin
  --
  --	a + b + c = 1000 && a * a + b * b = c * c
  --	
  
  for a in integer range 1..1000 loop
    for b in integer range a + 1..1000 loop
      c := 1000 - a - b;
      a2b2 := a * a + b * b;
      cc := c * c;
      if cc = a2b2 and then c > a
      then
        PInt(a);
        PString(new char_array'( To_C("" & Character'Val(10))));
        PInt(b);
        PString(new char_array'( To_C("" & Character'Val(10))));
        PInt(c);
        PString(new char_array'( To_C("" & Character'Val(10))));
        PInt(a * b * c);
        PString(new char_array'( To_C("" & Character'Val(10))));
      end if;
    end loop;
  end loop;
end;
