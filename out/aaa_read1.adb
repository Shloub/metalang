
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_read1 is
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
type f is Array (Integer range <>) of Character;
type f_PTR is access f;

  str : f_PTR;
  c : f_PTR;
begin
  c := new f (0..(12));
  for d in integer range (0)..(12) - (1) loop
    Get(c(d));
  end loop;
  SkipSpaces;
  str := c;
  for i in integer range (0)..(11) loop
    Character'Write (Text_Streams.Stream (Current_Output), str(i));
  end loop;
end;
