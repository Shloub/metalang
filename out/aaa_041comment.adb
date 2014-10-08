
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_041comment is

  i : Integer;
begin
  i := (4);
  --while i < 10 do 
  
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
  i := i + (1);
  --  end 
  
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;
