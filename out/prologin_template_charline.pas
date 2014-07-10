program prologin_template_charline;

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

function read_int() : Longint;
var
  out_ : Longint;
begin
  out_ := 0;
  out_ := read_int_();
  skip();
  exit(out_);
end;

type g = array of char;
function read_char_line(n : Longint) : g;
var
  i : Longint;
  t : char;
  tab : g;
begin
  SetLength(tab, n);
  for i := 0 to  n - 1 do
  begin
    t := #95;
    t := read_char_();
    tab[i] := t;
  end;
  skip();
  exit(tab);
end;

function programme_candidat(tableau : g; taille : Longint) : Longint;
var
  i : Longint;
  out_ : Longint;
begin
  out_ := 0;
  for i := 0 to  taille - 1 do
  begin
    out_ := out_ + ord(tableau[i]) * i;
    Write(tableau[i]);
  end;
  Write('--'#10'');
  exit(out_);
end;


var
  a : Longint;
  b : Longint;
  c : g;
  d : g;
  e : Longint;
  f : char;
  tableau : g;
  taille : Longint;
begin
  b := 0;
  b := read_int_();
  skip();
  a := b;
  taille := a;
  SetLength(d, taille);
  for e := 0 to  taille - 1 do
  begin
    f := #95;
    f := read_char_();
    d[e] := f;
  end;
  skip();
  c := d;
  tableau := c;
  Write(programme_candidat(tableau, taille));
  Write(''#10'');
end.


