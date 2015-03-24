
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure fibo is
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

procedure SkipSpaces is
  C : Character;
  Eol : Boolean;
begin
  loop
    Look_Ahead(C, Eol);
    exit when Eol or C /= ' ';
    Get(C);
  end loop;
end;
--
--La suite de fibonaci
--

function fibo0(a : in Integer; b : in Integer; i : in Integer) return Integer is
  tmp : Integer;
  out0 : Integer;
  b2 : Integer;
  a2 : Integer;
begin
  out0 := 0;
  a2 := a;
  b2 := b;
  for j in integer range 0..i + 1 loop
    out0 := out0 + a2;
    tmp := b2;
    b2 := b2 + a2;
    a2 := tmp;
  end loop;
  return out0;
end;


  i : Integer;
  b : Integer;
  a : Integer;
begin
  a := 0;
  b := 0;
  i := 0;
  Get(a);
  SkipSpaces;
  Get(b);
  SkipSpaces;
  Get(i);
  PInt(fibo0(a, b, i));
end;
