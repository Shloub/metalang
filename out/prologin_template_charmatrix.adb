
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure prologin_template_charmatrix is
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
type e is Array (Integer range <>) of Character;
type e_PTR is access e;
type f is Array (Integer range <>) of e_PTR;
type f_PTR is access f;
function programme_candidat(tableau : in f_PTR; taille_x : in Integer;
taille_y : in Integer) return Integer is
  out0 : Integer;
begin
  out0 := (0);
  for i in integer range (0)..taille_y - (1) loop
    for j in integer range (0)..taille_x - (1) loop
      out0 := out0 + Character'Pos(tableau(i)(j)) * (i + j * (2));
      Character'Write (Text_Streams.Stream (Current_Output), tableau(i)(j));
    end loop;
    String'Write (Text_Streams.Stream (Current_Output), "--" & Character'Val(10) & "");
  end loop;
  return out0;
end;


  taille_y : Integer;
  taille_x : Integer;
  tableau : f_PTR;
  c : e_PTR;
  a : f_PTR;
begin
  Get(taille_x);
  SkipSpaces;
  Get(taille_y);
  SkipSpaces;
  a := new f (0..taille_y);
  for b in integer range (0)..taille_y - (1) loop
    c := new e (0..taille_x);
    for d in integer range (0)..taille_x - (1) loop
      Get(c(d));
    end loop;
    SkipSpaces;
    a(b) := c;
  end loop;
  tableau := a;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(programme_candidat(tableau,
  taille_x, taille_y)), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;
