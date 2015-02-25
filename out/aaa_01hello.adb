
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_01hello is

  e : Boolean;
  d : Boolean;
  c : Boolean;
  b : Boolean;
  a : Integer;
begin
  String'Write (Text_Streams.Stream (Current_Output), "Hello World");
  a := (5);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(((4) +
                                                                           (6)) *
  (2)), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(a), Left));
  String'Write (Text_Streams.Stream (Current_Output), "foo");
  String'Write (Text_Streams.Stream (Current_Output), "");
  b := (1) + (((1) + (1)) * (2) * ((3) + (8))) / (4) - ((1) - (2)) - (3) = (12) and then TRUE;
  if b
  then
    String'Write (Text_Streams.Stream (Current_Output), "True");
  else
    String'Write (Text_Streams.Stream (Current_Output), "False");
  end if;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  c := ((3) * ((4) + (5) + (6)) * (2) = (45)) = FALSE;
  if c
  then
    String'Write (Text_Streams.Stream (Current_Output), "True");
  else
    String'Write (Text_Streams.Stream (Current_Output), "False");
  end if;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image((((4) +
                                                                            (1)) /
                                                                           (3)) /
  ((2) + (1))), Left));
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image((((4) *
                                                                            (1)) /
                                                                           (3)) /
  ((2) * (1))), Left));
  d := (not ((not (a = (0))) and then (not (a = (4)))));
  if d
  then
    String'Write (Text_Streams.Stream (Current_Output), "True");
  else
    String'Write (Text_Streams.Stream (Current_Output), "False");
  end if;
  e := TRUE and then (not FALSE) and then (not (TRUE and then FALSE));
  if e
  then
    String'Write (Text_Streams.Stream (Current_Output), "True");
  else
    String'Write (Text_Streams.Stream (Current_Output), "False");
  end if;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
end;
