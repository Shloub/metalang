program prologin_template_charmatrix;

var global_char : char;
var global_has_char : boolean;

procedure skip_char();
begin
   global_has_char := true;
   read(global_char);
end; 
procedure skip();
var
   n : char;
   t : char;
   s : char;
begin
   n := #13;
   t := #10;
   s := #32;
   if not( global_has_char ) then
      skip_char();
   while (global_char = s) or (global_char = n) or (global_char = t) do
   begin
      skip_char();
   end;
end;
function read_char_aux() : char;
begin
   if global_has_char then
      read_char_aux := global_char
   else
   begin
      skip_char();
      read_char_aux := global_char;
   end
end;
function read_char_() : char;
var
   c : char;
begin
   c := read_char_aux();
   skip_char();
   read_char_ := c;
end;
function read_int_() : Longint;
var
   c    : char;
   i    : Longint;
   sign :  Longint;
begin
   i := 0;
   c := read_char_aux();
   if c = '-' then begin
      skip_char();
      sign := -1;
   end
   else
      sign := 1;

   repeat
      c := read_char_aux();
      if (ord(c) <=57) and (ord(c) >= 48) then
      begin
         i := i * 10 + ord(c) - 48;
         skip_char();
      end
      else
         exit(i * sign);
   until false;
end;

type k = array of array of char;
type l = array of char;
function read_char_matrix(x : Longint; y : Longint) : k;
var
  b : l;
  c : Longint;
  d : char;
  tab : k;
  z : Longint;
begin
  SetLength(tab, y);
  for z := 0 to  y - 1 do
  begin
    SetLength(b, x);
    for c := 0 to  x - 1 do
    begin
      d := read_char_();
      b[c] := d;
    end;
    skip();
    tab[z] := b;
  end;
  exit(tab);
end;

function programme_candidat(tableau : k; taille_x : Longint; taille_y : Longint) : Longint;
var
  i : Longint;
  j : Longint;
  out_ : Longint;
begin
  out_ := 0;
  for i := 0 to  taille_y - 1 do
  begin
    for j := 0 to  taille_x - 1 do
    begin
      out_ := out_ + ord(tableau[i][j]) * (i + j * 2);
      Write(tableau[i][j]);
    end;
    Write('--'#10'');
  end;
  exit(out_);
end;


var
  f : Longint;
  h : Longint;
  tableau : k;
  taille_x : Longint;
  taille_y : Longint;
begin
  f := read_int_();
  skip();
  taille_x := f;
  h := read_int_();
  skip();
  taille_y := h;
  tableau := read_char_matrix(taille_x, taille_y);
  Write(programme_candidat(tableau, taille_x, taille_y));
  Write(''#10'');
end.


