
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_01hello is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

  e : Boolean;
  d : Boolean;
  c : Boolean;
  b : Boolean;
  a : Integer;
begin
  PString("Hello World");
  a := 5;
  PInt((4 + 6) * 2);
  PString(" ");
  PString("" & Character'Val(10));
  PInt(a);
  PString("foo");
  PString("");
  b := 1 + ((1 + 1) * 2 * (3 + 8)) / 4 - (1 - 2) - 3 = 12 and then TRUE;
  if b
  then
    PString("True");
  else
    PString("False");
  end if;
  PString("" & Character'Val(10));
  c := (3 * (4 + 5 + 6) * 2 = 45) = FALSE;
  if c
  then
    PString("True");
  else
    PString("False");
  end if;
  PInt(((4 + 1) / 3) / (2 + 1));
  PInt(((4 * 1) / 3) / (2 * 1));
  d := (not ((not (a = 0)) and then (not (a = 4))));
  if d
  then
    PString("True");
  else
    PString("False");
  end if;
  e := TRUE and then (not FALSE) and then (not (TRUE and then FALSE));
  if e
  then
    PString("True");
  else
    PString("False");
  end if;
  PString("" & Character'Val(10));
end;
