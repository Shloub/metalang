
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_06readcouple is
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

  b : Integer;
  a : Integer;
begin
  for i in integer range (1)..(3) loop
    Get(a);
    SkipSpaces;
    Get(b);
    SkipSpaces;
    String'Write (Text_Streams.Stream (Current_Output), "a = ");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(a), Left));
    String'Write (Text_Streams.Stream (Current_Output), " b = ");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(b), Left));
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  end loop;
end;
