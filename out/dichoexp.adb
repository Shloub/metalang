
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure dichoexp is
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
function exp0(a : in Integer; b : in Integer) return Integer is
  o : Integer;
begin
  if b = (0)
  then
    return (1);
  end if;
  if (b rem (2)) = (0)
  then
    o := exp0(a, b / (2));
    return o * o;
  else
    return a * exp0(a, b - (1));
  end if;
end;


  b : Integer;
  a : Integer;
begin
  a := (0);
  b := (0);
  Get(a);
  SkipSpaces;
  Get(b);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(exp0(a,
  b)), Left));
end;
