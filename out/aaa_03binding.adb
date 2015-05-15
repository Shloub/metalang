
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure aaa_03binding is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

function g(i : in Integer) return Integer is
  j : Integer;
begin
  j := i * 4;
  if j rem 2 = 1
  then
    return 0;
  end if;
  return j;
end;

procedure h(i : in Integer) is
begin
  PInt(i);
  PString(new char_array'( To_C("" & Character'Val(10))));
end;


  b : Integer;
  a : Integer;
begin
  h(14);
  a := 4;
  b := 5;
  PInt(a + b);
  -- main 
  
  h(15);
  a := 2;
  b := 1;
  PInt(a + b);
end;
