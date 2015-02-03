
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
type s is Array (Integer range <>) of Character;
type s_PTR is access s;
type u is Array (Integer range <>) of s_PTR;
type u_PTR is access u;
function programme_candidat(tableau : in u_PTR; taille_x : in Integer;
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
  tableau : u_PTR;
  r : s_PTR;
  l : u_PTR;
begin
  Get(taille_x);
  SkipSpaces;
  Get(taille_y);
  SkipSpaces;
  l := new u (0..taille_y);
  for m in integer range (0)..taille_y - (1) loop
    r := new s (0..taille_x);
    for p in integer range (0)..taille_x - (1) loop
      Get(r(p));
    end loop;
    SkipSpaces;
    l(m) := r;
  end loop;
  tableau := l;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(programme_candidat(tableau,
  taille_x, taille_y)), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;
