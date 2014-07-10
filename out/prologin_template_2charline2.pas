program prologin_template_2charline2;

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

type r = array of char;
function read_char_line(n : Longint) : r;
var
  i : Longint;
  t : char;
  tab : r;
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

function programme_candidat(tableau1 : r; taille1 : Longint; tableau2 : r; taille2 : Longint) : Longint;
var
  i : Longint;
  j : Longint;
  out_ : Longint;
begin
  out_ := 0;
  for i := 0 to  taille1 - 1 do
  begin
    out_ := out_ + ord(tableau1[i]) * i;
    Write(tableau1[i]);
  end;
  Write('--'#10'');
  for j := 0 to  taille2 - 1 do
  begin
    out_ := out_ + ord(tableau2[j]) * j * 100;
    Write(tableau2[j]);
  end;
  Write('--'#10'');
  exit(out_);
end;


var
  a : Longint;
  b : Longint;
  c : Longint;
  d : Longint;
  e : r;
  f : Longint;
  g : r;
  h : Longint;
  k : char;
  l : r;
  m : Longint;
  o : r;
  p : Longint;
  q : char;
  tableau1 : r;
  tableau2 : r;
  taille1 : Longint;
  taille2 : Longint;
begin
  b := 0;
  b := read_int_();
  skip();
  a := b;
  taille1 := a;
  d := 0;
  d := read_int_();
  skip();
  c := d;
  taille2 := c;
  f := taille1;
  SetLength(g, f);
  for h := 0 to  f - 1 do
  begin
    k := #95;
    k := read_char_();
    g[h] := k;
  end;
  skip();
  e := g;
  tableau1 := e;
  m := taille2;
  SetLength(o, m);
  for p := 0 to  m - 1 do
  begin
    q := #95;
    q := read_char_();
    o[p] := q;
  end;
  skip();
  l := o;
  tableau2 := l;
  Write(programme_candidat(tableau1, taille1, tableau2, taille2));
  Write(''#10'');
end.


