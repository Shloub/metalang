program prologin_template_intmatrix;

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

function read_int() : Longint;
var
  out_ : Longint;
begin
  out_ := 0;
  out_ := read_int_();
  skip();
  exit(out_);
end;

type k = array of Longint;
function read_int_line(n : Longint) : k;
var
  i : Longint;
  t : Longint;
  tab : k;
begin
  SetLength(tab, n);
  for i := 0 to  n - 1 do
  begin
    t := 0;
    t := read_int_();
    skip();
    tab[i] := t;
  end;
  exit(tab);
end;

type l = array of k;
function read_int_matrix(x : Longint; y : Longint) : l;
var
  a : k;
  b : k;
  c : Longint;
  d : Longint;
  tab : l;
  z : Longint;
begin
  SetLength(tab, y);
  for z := 0 to  y - 1 do
  begin
    SetLength(b, x);
    for c := 0 to  x - 1 do
    begin
      d := 0;
      d := read_int_();
      skip();
      b[c] := d;
    end;
    a := b;
    tab[z] := a;
  end;
  exit(tab);
end;

function programme_candidat(tableau : l; x : Longint; y : Longint) : Longint;
var
  i : Longint;
  j : Longint;
  out_ : Longint;
begin
  out_ := 0;
  for i := 0 to  y - 1 do
  begin
    for j := 0 to  x - 1 do
    begin
      out_ := out_ + tableau[i][j] * (i * 2 + j);
    end;
  end;
  exit(out_);
end;


var
  e : Longint;
  f : Longint;
  g : Longint;
  h : Longint;
  tableau : l;
  taille_x : Longint;
  taille_y : Longint;
begin
  f := 0;
  f := read_int_();
  skip();
  e := f;
  taille_x := e;
  h := 0;
  h := read_int_();
  skip();
  g := h;
  taille_y := g;
  tableau := read_int_matrix(taille_x, taille_y);
  Write(programme_candidat(tableau, taille_x, taille_y));
  Write(''#10'');
end.

