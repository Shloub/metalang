
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure prologin_template_charline is
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
type b is Array (Integer range <>) of Character;
type b_PTR is access b;
function programme_candidat(tableau : in b_PTR; taille : in Integer) return Integer is
  out0 : Integer;
begin
  out0 := (0);
  for i in integer range (0)..taille - (1) loop
    out0 := out0 + Character'Pos(tableau(i)) * i;
    Character'Write (Text_Streams.Stream (Current_Output), tableau(i));
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), "--" & Character'Val(10));
  return out0;
end;


  taille : Integer;
  tableau : b_PTR;
begin
  Get(taille);
  SkipSpaces;
  tableau := new b (0..taille);
  for a in integer range (0)..taille - (1) loop
    Get(tableau(a));
  end loop;
  SkipSpaces;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(programme_candidat(tableau, taille)), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
end;
