
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure prologin_template_2charline is
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
type c is Array (Integer range <>) of Character;
type c_PTR is access c;
function programme_candidat(tableau1 : in c_PTR; taille1 : in Integer;
tableau2 : in c_PTR; taille2 : in Integer) return Integer is
  out0 : Integer;
begin
  out0 := (0);
  for i in integer range (0)..taille1 - (1) loop
    out0 := out0 + Character'Pos(tableau1(i)) * i;
    Character'Write (Text_Streams.Stream (Current_Output), tableau1(i));
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), "--" & Character'Val(10));
  for j in integer range (0)..taille2 - (1) loop
    out0 := out0 + Character'Pos(tableau2(j)) * j * (100);
    Character'Write (Text_Streams.Stream (Current_Output), tableau2(j));
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), "--" & Character'Val(10));
  return out0;
end;


  taille2 : Integer;
  taille1 : Integer;
  tableau2 : c_PTR;
  tableau1 : c_PTR;
begin
  Get(taille1);
  SkipSpaces;
  tableau1 := new c (0..taille1);
  for a in integer range (0)..taille1 - (1) loop
    Get(tableau1(a));
  end loop;
  SkipSpaces;
  Get(taille2);
  SkipSpaces;
  tableau2 := new c (0..taille2);
  for b in integer range (0)..taille2 - (1) loop
    Get(tableau2(b));
  end loop;
  SkipSpaces;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(programme_candidat(tableau1,
  taille1, tableau2, taille2)), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
end;
