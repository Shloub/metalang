
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;
with Ada.Numerics.Elementary_Functions;
procedure euler39 is
type d is Array (Integer range <>) of Integer;
type d_PTR is access d;

  t : d_PTR;
  p : Integer;
  j : Integer;
  c2 : Integer;
  c : Integer;
begin
  t := new d (0..(1001));
  for i in integer range (0)..(1001) - (1) loop
    t(i) := (0);
  end loop;
  for a in integer range (1)..(1000) loop
    for b in integer range (1)..(1000) loop
      c2 := a * a + b * b;
      c := Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(c2))));
      if c * c = c2
      then
        p := a + b + c;
        if p <= (1000)
        then
          t(p) := t(p) + (1);
        end if;
      end if;
    end loop;
  end loop;
  j := (0);
  for k in integer range (1)..(1000) loop
    if t(k) > t(j)
    then
      j := k;
    end if;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(j), Left));
end;
