
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure small_inline is
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
type a is Array (Integer range <>) of Integer;
type a_PTR is access a;

  t : a_PTR;
  c : a_PTR;
begin
  c := new a (0..(2));
  for d in integer range (0)..(2) - (1) loop
    Get(c(d));
    SkipSpaces;
  end loop;
  t := c;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(t((0))), Left));
  String'Write (Text_Streams.Stream (Current_Output), " - ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(t((1))), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;
