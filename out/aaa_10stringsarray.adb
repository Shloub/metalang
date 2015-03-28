
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure aaa_10stringsarray is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
--
--TODO ajouter un record qui contient des chaines.
--

function idstring(s : in stringptr) return stringptr is
begin
  return s;
end;

procedure printstring(s : in stringptr) is
begin
  PString(idstring(s));
  PString(new char_array'( To_C("" & Character'Val(10))));
end;

type a is Array (Integer range <>) of stringptr;
type a_PTR is access a;

  tab : a_PTR;
begin
  tab := new a (0..2);
  for i in integer range 0..2 - 1 loop
    tab(i) := idstring(new char_array'( To_C("chaine de test")));
  end loop;
  for j in integer range 0..1 loop
    printstring(idstring(tab(j)));
  end loop;
end;
