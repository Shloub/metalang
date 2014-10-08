
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure devine is
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
type b is Array (Integer range <>) of Integer;
type b_PTR is access b;
function devine0(nombre : in Integer; tab : in b_PTR;
len : in Integer) return Boolean is
  min0 : Integer;
  max0 : Integer;
begin
  min0 := tab((0));
  max0 := tab((1));
  for i in integer range (2)..len - (1) loop
    if tab(i) > max0 or else tab(i) < min0
    then
      return FALSE;
    end if;
    if tab(i) < nombre
    then
      min0 := tab(i);
    end if;
    if tab(i) > nombre
    then
      max0 := tab(i);
    end if;
    if tab(i) = nombre and then len /= i + (1)
    then
      return FALSE;
    end if;
  end loop;
  return TRUE;
end;


  tmp : Integer;
  tab : b_PTR;
  nombre : Integer;
  len : Integer;
  a : Boolean;
begin
  Get(nombre);
  SkipSpaces;
  Get(len);
  SkipSpaces;
  tab := new b (0..len);
  for i in integer range (0)..len - (1) loop
    Get(tmp);
    SkipSpaces;
    tab(i) := tmp;
  end loop;
  a := devine0(nombre, tab, len);
  if a
  then
    String'Write (Text_Streams.Stream (Current_Output), "True");
  else
    String'Write (Text_Streams.Stream (Current_Output), "False");
  end if;
end;
