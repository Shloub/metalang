
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure euler28 is


type stringptr is access all char_array;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;
--
--
--43 44 45 46 47 48 49
--42 21 22 23 24 25 26
--41 20  7  8  9 10 27
--40 19  6  1  2 11 28
--39 18  5  4  3 12 29
--38 17 16 15 14 13 30
--37 36 35 34 33 32 31
--
--1 3 5 7 9 13 17 21 25 31 37 43 49
--  2 2 2 2 4  4  4  4  6   6  6  6
--
--
--

function sumdiag(n : in Integer) return Integer is
  un : Integer;
  sum : Integer;
  nterms : Integer;
  d : Integer;
begin
  nterms := n * 2 - 1;
  un := 1;
  sum := 1;
  for i in integer range 0..nterms - 2 loop
    d := 2 * (1 + i / 4);
    un := un + d;
    -- print int d print "=>" print un print " " 
    
    sum := sum + un;
  end loop;
  return sum;
end;


begin
  PInt(sumdiag(1001));
end;
