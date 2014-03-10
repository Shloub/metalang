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
function read_int_() : integer;
var
   c    : char;
   i    : integer;
   sign :  integer;
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



function read_int() : integer;
var
  out_ : integer;
begin
  out_ := 0;
  out_ := read_int_();
  skip();
  exit(out_);
end;

type e = array of integer;
function read_int_line(n : integer) : e;
var
  i : integer;
  t_ : integer;
  tab : e;
begin
  SetLength(tab, n);
  for i := 0 to  n - 1 do
  begin
    t_ := 0;
    t_ := read_int_();
    skip();
    tab[i] := t_;
  end;
  exit(tab);
end;

type f = array of char;
function read_char_line(n : integer) : f;
var
  i : integer;
  t_ : char;
  tab : f;
begin
  SetLength(tab, n);
  for i := 0 to  n - 1 do
  begin
    t_ := #95;
    t_ := read_char_();
    tab[i] := t_;
  end;
  skip();
  exit(tab);
end;

{
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
}

var
  a : integer;
  b : integer;
  c : integer;
  d : char;
  i : integer;
  i3 : integer;
  i_ : integer;
  j : integer;
  len : integer;
  strlen : integer;
  tab : e;
  tab2 : e;
  tab4 : f;
  tmpc : char;
begin
  len := read_int();
  Write(len);
  Write('=len'#10'');
  tab := read_int_line(len);
  for i := 0 to  len - 1 do
  begin
    Write(i);
    Write('=>');
    a := tab[i];
    Write(a);
    Write(' ');
  end;
  Write(''#10'');
  tab2 := read_int_line(len);
  for i_ := 0 to  len - 1 do
  begin
    Write(i_);
    Write('==>');
    b := tab2[i_];
    Write(b);
    Write(' ');
  end;
  strlen := read_int();
  Write(strlen);
  Write('=strlen'#10'');
  tab4 := read_char_line(strlen);
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
    d := tab4[j];
    Write(d);
  end;
end.


