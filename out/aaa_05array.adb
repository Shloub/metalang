
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_05array is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
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
    a(i) := (i rem 2) = 0;
  end loop;
  PInt(j);
  PString(" ");
  c := a(0);
  if c
  then
    PString("True");
  else
    PString("False");
  end if;
  PString("" & Character'Val(10));
  g(id(a), 0);
  d := a(0);
  if d
  then
    PString("True");
  else
    PString("False");
  end if;
  PString("" & Character'Val(10));
end;
