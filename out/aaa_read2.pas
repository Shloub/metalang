program aaa_read2;

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

type y = array of Longint;
function read_int_line(n : Longint) : y;
var
  i : Longint;
  t : Longint;
  tab : y;
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

type z = array of char;
function read_char_line(n : Longint) : z;
var
  i : Longint;
  t : char;
  tab : z;
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

{
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
}

var
  a : Longint;
  b : Longint;
  c : Longint;
  d : y;
  e : Longint;
  f : y;
  g : Longint;
  h : Longint;
  i : Longint;
  i3 : Longint;
  i_ : Longint;
  j : Longint;
  k : y;
  l : Longint;
  len : Longint;
  m : y;
  o : Longint;
  p : Longint;
  q : Longint;
  r : Longint;
  s : z;
  strlen : Longint;
  tab : y;
  tab2 : y;
  tab4 : z;
  tmpc : char;
  u : Longint;
  v : z;
  w : Longint;
  x : char;
begin
  b := 0;
  b := read_int_();
  skip();
  a := b;
  len := a;
  Write(len);
  Write('=len'#10'');
  e := len;
  SetLength(f, e);
  for g := 0 to  e - 1 do
  begin
    h := 0;
    h := read_int_();
    skip();
    f[g] := h;
  end;
  d := f;
  tab := d;
  for i := 0 to  len - 1 do
  begin
    Write(i);
    Write('=>');
    Write(tab[i]);
    Write(' ');
  end;
  Write(''#10'');
  l := len;
  SetLength(m, l);
  for o := 0 to  l - 1 do
  begin
    p := 0;
    p := read_int_();
    skip();
    m[o] := p;
  end;
  k := m;
  tab2 := k;
  for i_ := 0 to  len - 1 do
  begin
    Write(i_);
    Write('==>');
    Write(tab2[i_]);
    Write(' ');
  end;
  r := 0;
  r := read_int_();
  skip();
  q := r;
  strlen := q;
  Write(strlen);
  Write('=strlen'#10'');
  u := strlen;
  SetLength(v, u);
  for w := 0 to  u - 1 do
  begin
    x := #95;
    x := read_char_();
    v[w] := x;
  end;
  skip();
  s := v;
  tab4 := s;
  for i3 := 0 to  strlen - 1 do
  begin
    tmpc := tab4[i3];
    c := ord(tmpc);
    Write(tmpc);
    Write(':');
    Write(c);
    Write(' ');
    if tmpc <> #32
    then
      begin
        c := ((c - ord(#97)) + 13) Mod 26 + ord(#97);
      end;
    tab4[i3] := chr(c);
  end;
  for j := 0 to  strlen - 1 do
  begin
    Write(tab4[j]);
  end;
end.


