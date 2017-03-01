
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure calc is


type stringptr is access all char_array;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;
--
--La suite de fibonaci
--

function fibo(a : in Integer; b : in Integer; i : in Integer) return Integer is
  tmp : Integer;
  out_0 : Integer;
  b2 : Integer;
  a2 : Integer;
begin
  out_0 := 0;
  a2 := a;
  b2 := b;
  for j in integer range 0..i + 1 loop
    PInt(j);
    out_0 := out_0 + a2;
    tmp := b2;
    b2 := b2 + a2;
    a2 := tmp;
  end loop;
  return out_0;
end;

begin
  PInt(fibo(1, 2, 4));
end;
