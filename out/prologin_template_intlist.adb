
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure prologin_template_intlist is
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
type g is Array (Integer range <>) of Integer;
type g_PTR is access g;
function programme_candidat(tableau : in g_PTR;
taille : in Integer) return Integer is
  out0 : Integer;
begin
  out0 := (0);
  for i in integer range (0)..taille - (1) loop
    out0 := out0 + tableau(i);
  end loop;
  return out0;
end;


  taille : Integer;
  tableau : g_PTR;
  d : g_PTR;
  b : Integer;
begin
  Get(b);
  SkipSpaces;
  taille := b;
  d := new g (0..taille);
  for e in integer range (0)..taille - (1) loop
    Get(d(e));
    SkipSpaces;
  end loop;
  tableau := d;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(programme_candidat(tableau,
  taille)), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;
