
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;
with Ada.Numerics.Elementary_Functions;
procedure euler42 is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
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


function is_triangular(n : in Integer) return Boolean is
  a : Integer;
begin
  --
  --   n = k * (k + 1) / 2
  --	  n * 2 = k * (k + 1)
  --   
  
  a := Integer(Float'Truncation(Ada.Numerics.Elementary_Functions.Sqrt(Float(n * 2))));
  return a * (a + 1) = n * 2;
end;

function score return Integer is
  sum : Integer;
  len : Integer;
  c : Character;
begin
  SkipSpaces;
  Get(len);
  SkipSpaces;
  sum := 0;
  for i in integer range 1..len loop
    Get(c);
    sum := sum + Character'Pos(c) - Character'Pos('A') + 1;
    --		print c print " " print sum print " " 
    
  end loop;
  if is_triangular(sum)
  then
    return 1;
  else
    return 0;
  end if;
end;

  sum : Integer;
  n : Integer;
begin
  for i in integer range 1..55 loop
    if is_triangular(i)
    then
      PInt(i);
      PString(new char_array'( To_C(" ")));
    end if;
  end loop;
  PString(new char_array'( To_C("" & Character'Val(10))));
  sum := 0;
  Get(n);
  for i in integer range 1..n loop
    sum := sum + score;
  end loop;
  PInt(sum);
  PString(new char_array'( To_C("" & Character'Val(10))));
end;
