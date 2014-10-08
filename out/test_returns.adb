
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure test_returns is
function is_pair(i : in Integer) return Boolean is
  j : Integer;
begin
  j := (1);
  if i < (10)
  then
    j := (2);
    if i = (0)
    then
      j := (4);
      return TRUE;
    end if;
    j := (3);
    if i = (2)
    then
      j := (4);
      return TRUE;
    end if;
    j := (5);
  end if;
  j := (6);
  if i < (20)
  then
    if i = (22)
    then
      j := (0);
    end if;
    j := (8);
  end if;
  return (i rem (2)) = (0);
end;


begin
  NULL;
  
end;
