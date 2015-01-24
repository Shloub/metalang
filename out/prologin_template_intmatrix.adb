
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure prologin_template_intmatrix is
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
type s is Array (Integer range <>) of Integer;
type s_PTR is access s;
type u is Array (Integer range <>) of s_PTR;
type u_PTR is access u;
function programme_candidat(tableau : in u_PTR; x : in Integer;
y : in Integer) return Integer is
  out0 : Integer;
begin
  out0 := (0);
  for i in integer range (0)..y - (1) loop
    for j in integer range (0)..x - (1) loop
      out0 := out0 + tableau(i)(j) * (i * (2) + j);
    end loop;
  end loop;
  return out0;
end;


  taille_y : Integer;
  taille_x : Integer;
  tableau : u_PTR;
  r : s_PTR;
  q : Integer;
  h : Integer;
  f : Integer;
begin
  Get(f);
  SkipSpaces;
  taille_x := f;
  Get(h);
  SkipSpaces;
  taille_y := h;
  tableau := new u (0..taille_y);
  for m in integer range (0)..taille_y - (1) loop
    r := new s (0..taille_x);
    for p in integer range (0)..taille_x - (1) loop
      Get(q);
      SkipSpaces;
      r(p) := q;
    end loop;
    tableau(m) := r;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(programme_candidat(tableau,
  taille_x, taille_y)), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;
