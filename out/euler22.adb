
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure euler22 is


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
    sum := sum + (Character'Pos(c) - Character'Pos('A')) + 1;
    --		print c print " " print sum print " " 
    
  end loop;
  return sum;
end;


  sum : Integer;
  n : Integer;
begin
  sum := 0;
  Get(n);
  for i in integer range 1..n loop
    sum := sum + i * score;
  end loop;
  PInt(sum);
  PString(new char_array'( To_C("" & Character'Val(10))));
end;
