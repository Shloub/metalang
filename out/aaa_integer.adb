
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_integer is

  i : Integer;
begin
  i := (0);
  i := i - (1);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  i := i + (55);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  i := i * (13);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  i := i / (2);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  i := i + (1);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  i := i / (3);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  i := i - (1);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  --
  --http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
  --
  
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image((117) /
  (17)), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image((117) /
  (-(17))), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image((-(117)) /
  (17)), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image((-(117)) /
  (-(17))), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image((117) rem
  (17)), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image((117) rem
  (-(17))), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image((-(117)) rem
  (17)), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image((-(117)) rem
  (-(17))), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;
