
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_05array is
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


  d : Boolean;
  c : Boolean;
  a : e_PTR;
begin
  a := new e (0..(5));
  for i in integer range (0)..(5) - (1) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
    a(i) := (i rem (2)) = (0);
  end loop;
  c := a((0));
  if c
  then
    String'Write (Text_Streams.Stream (Current_Output), "True");
  else
    String'Write (Text_Streams.Stream (Current_Output), "False");
  end if;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  g(id(a), (0));
  d := a((0));
  if d
  then
    String'Write (Text_Streams.Stream (Current_Output), "True");
  else
    String'Write (Text_Streams.Stream (Current_Output), "False");
  end if;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;
