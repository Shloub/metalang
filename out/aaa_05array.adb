
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure aaa_05array is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;
type e is Array (Integer range <>) of Boolean;
type e_PTR is access e;
function id(b : in e_PTR) return e_PTR is
begin
  return b;
end;

procedure g(t : in e_PTR; index : in Integer) is
begin
  t(index) := FALSE;
end;


  j : Integer;
  d : Boolean;
  c : Boolean;
  a : e_PTR;
begin
  j := 0;
  a := new e (0..5);
  for i in integer range 0..5 - 1 loop
    PInt(i);
    j := j + i;
    a(i) := i rem 2 = 0;
  end loop;
  PInt(j);
  PString(new char_array'( To_C(" ")));
  c := a(0);
  if c
  then
    PString(new char_array'( To_C("True")));
  else
    PString(new char_array'( To_C("False")));
  end if;
  PString(new char_array'( To_C("" & Character'Val(10))));
  g(id(a), 0);
  d := a(0);
  if d
  then
    PString(new char_array'( To_C("True")));
  else
    PString(new char_array'( To_C("False")));
  end if;
  PString(new char_array'( To_C("" & Character'Val(10))));
end;
