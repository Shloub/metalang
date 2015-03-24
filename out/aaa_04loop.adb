
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_04loop is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

function h(i : in Integer) return Boolean is
  j : Integer;
begin
  --  for j = i - 2 to i + 2 do
  --    if i % j == 5 then return true end
  --  end 
  
  j := i - 2;
  while j <= i + 2 loop
    if (i rem j) = 5
    then
      return TRUE;
    end if;
    j := j + 1;
  end loop;
  return FALSE;
end;


  j : Integer;
  i : Integer;
begin
  j := 0;
  for k in integer range 0..10 loop
    j := j + k;
    PInt(j);
    PString("" & Character'Val(10));
  end loop;
  i := 4;
  while i < 10 loop
    PInt(i);
    i := i + 1;
    j := j + i;
  end loop;
  PInt(j);
  PInt(i);
  PString("FIN TEST" & Character'Val(10));
end;
