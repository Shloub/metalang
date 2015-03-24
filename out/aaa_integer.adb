
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_integer is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

  i : Integer;
begin
  i := 0;
  i := i - 1;
  PInt(i);
  PString("" & Character'Val(10));
  i := i + 55;
  PInt(i);
  PString("" & Character'Val(10));
  i := i * 13;
  PInt(i);
  PString("" & Character'Val(10));
  i := i / 2;
  PInt(i);
  PString("" & Character'Val(10));
  i := i + 1;
  PInt(i);
  PString("" & Character'Val(10));
  i := i / 3;
  PInt(i);
  PString("" & Character'Val(10));
  i := i - 1;
  PInt(i);
  PString("" & Character'Val(10));
  --
  --http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
  --
  
  PInt(117 / 17);
  PString("" & Character'Val(10));
  PInt(117 / (-17));
  PString("" & Character'Val(10));
  PInt((-117) / 17);
  PString("" & Character'Val(10));
  PInt((-117) / (-17));
  PString("" & Character'Val(10));
  PInt(117 rem 17);
  PString("" & Character'Val(10));
  PInt(117 rem (-17));
  PString("" & Character'Val(10));
  PInt((-117) rem 17);
  PString("" & Character'Val(10));
  PInt((-117) rem (-17));
  PString("" & Character'Val(10));
end;
