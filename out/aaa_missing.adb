
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_missing is
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
--
--  Ce test a été généré par Metalang.
--

type b is Array (Integer range <>) of Boolean;
type b_PTR is access b;
type c is Array (Integer range <>) of Integer;
type c_PTR is access c;
function result(len : in Integer; tab : in c_PTR) return Integer is
  tab2 : b_PTR;
begin
  tab2 := new b (0..len);
  for i in integer range (0)..len - (1) loop
    tab2(i) := FALSE;
  end loop;
  for i1 in integer range (0)..len - (1) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(tab(i1)), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
    tab2(tab(i1)) := TRUE;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  for i2 in integer range (0)..len - (1) loop
    if (not tab2(i2))
    then
      return i2;
    end if;
  end loop;
  return (-(1));
end;


  tab : c_PTR;
  len : Integer;
begin
  Get(len);
  SkipSpaces;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(len), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  tab := new c (0..len);
  for a in integer range (0)..len - (1) loop
    Get(tab(a));
    SkipSpaces;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(result(len,
  tab)), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
end;
