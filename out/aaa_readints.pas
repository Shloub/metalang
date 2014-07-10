program aaa_readints;

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

type p = array of Longint;
function read_int_line(n : Longint) : p;
var
  i : Longint;
  t : Longint;
  tab : p;
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

type q = array of p;
function read_int_matrix(x : Longint; y : Longint) : q;
var
  a : p;
  b : p;
  c : Longint;
  d : Longint;
  tab : q;
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


var
  e : Longint;
  f : Longint;
  g : p;
  h : p;
  i : Longint;
  j : Longint;
  k : Longint;
  l : Longint;
  len : Longint;
  m : Longint;
  o : Longint;
  tab1 : p;
  tab2 : q;
begin
  f := 0;
  f := read_int_();
  skip();
  e := f;
  len := e;
  Write(len);
  Write('=len'#10'');
  SetLength(h, len);
  for k := 0 to  len - 1 do
  begin
    l := 0;
    l := read_int_();
    skip();
    h[k] := l;
  end;
  g := h;
  tab1 := g;
  for i := 0 to  len - 1 do
  begin
    Write(i);
    Write('=>');
    Write(tab1[i]);
    Write(''#10'');
  end;
  o := 0;
  o := read_int_();
  skip();
  m := o;
  len := m;
  tab2 := read_int_matrix(len, len - 1);
  for i := 0 to  len - 2 do
  begin
    for j := 0 to  len - 1 do
    begin
      Write(tab2[i][j]);
      Write(' ');
    end;
    Write(''#10'');
  end;
end.


