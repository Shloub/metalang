
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure ocaml01 is


type stringptr is access all char_array;
function foo return Integer is
begin
  for i in integer range 0..10 loop
    NULL;
    
  end loop;
  return 0;
end;
function bar return Integer is
  a : Integer;
begin
  for i in integer range 0..10 loop
    a := 0;
  end loop;
  return 0;
end;

begin
  NULL;
  
end;
