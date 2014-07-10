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

type v = array of Longint;
function read_int_line(n : Longint) : v;
var
  i : Longint;
  t : Longint;
  tab : v;
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

type w = array of char;
function read_char_line(n : Longint) : w;
var
  i : Longint;
  t : char;
  tab : w;
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
  d : v;
  e : v;
  f : Longint;
  g : Longint;
  h : v;
  i : Longint;
  i3 : Longint;
  i_ : Longint;
  j : Longint;
  k : v;
  l : Longint;
  len : Longint;
  m : Longint;
  o : Longint;
  p : Longint;
  q : w;
  r : w;
  s : Longint;
  strlen : Longint;
  tab : v;
  tab2 : v;
  tab4 : w;
  tmpc : char;
  u : char;
begin
  b := 0;
  b := read_int_();
  skip();
  a := b;
  len := a;
  Write(len);
  Write('=len'#10'');
  SetLength(e, len);
  for f := 0 to  len - 1 do
  begin
    g := 0;
    g := read_int_();
    skip();
    e[f] := g;
  end;
  d := e;
  tab := d;
  for i := 0 to  len - 1 do
  begin
    Write(i);
    Write('=>');
    Write(tab[i]);
    Write(' ');
  end;
  Write(''#10'');
  SetLength(k, len);
  for l := 0 to  len - 1 do
  begin
    m := 0;
    m := read_int_();
    skip();
    k[l] := m;
  end;
  h := k;
  tab2 := h;
  for i_ := 0 to  len - 1 do
  begin
    Write(i_);
    Write('==>');
    Write(tab2[i_]);
    Write(' ');
  end;
  p := 0;
  p := read_int_();
  skip();
  o := p;
  strlen := o;
  Write(strlen);
  Write('=strlen'#10'');
  SetLength(r, strlen);
  for s := 0 to  strlen - 1 do
  begin
    u := #95;
    u := read_char_();
    r[s] := u;
  end;
  skip();
  q := r;
  tab4 := q;
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


