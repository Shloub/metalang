
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_read0 is
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

  len : Integer;
begin
  Get(len);
  SkipSpaces;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(len), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;
