
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_07triplet is
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
type e is Array (Integer range <>) of Integer;
type e_PTR is access e;

  l : e_PTR;
  c : Integer;
  b : Integer;
  a : Integer;
begin
  for i in integer range (1)..(3) loop
    Get(a);
    SkipSpaces;
    Get(b);
    SkipSpaces;
    Get(c);
    SkipSpaces;
    String'Write (Text_Streams.Stream (Current_Output), "a = ");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(a), Left));
    String'Write (Text_Streams.Stream (Current_Output), " b = ");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(b), Left));
    String'Write (Text_Streams.Stream (Current_Output), "c =");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(c), Left));
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  end loop;
  l := new e (0..(10));
  for d in integer range (0)..(10) - (1) loop
    Get(l(d));
    SkipSpaces;
  end loop;
  for j in integer range (0)..(9) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(l(j)), Left));
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  end loop;
end;
