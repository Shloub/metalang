
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_03binding is
function g(i : in Integer) return Integer is
  j : Integer;
begin
  j := i * (4);
  if (j rem (2)) = (1)
  then
    return (0);
  end if;
  return j;
end;

procedure h(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
end;


  b : Integer;
  a : Integer;
begin
  h((14));
  a := (4);
  b := (5);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(a +
  b), Left));
  -- main 
  
  h((15));
  a := (2);
  b := (1);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(a +
  b), Left));
end;
