program aaa_read;

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
function read_char() : char;
var
   c : char;
begin
   c := read_char_aux();
   skip_char();
   read_char := c;
end;
function read_int() : integer;
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



{
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
}

var
  b : char;
  c : integer;
  i : integer;
  i_ : integer;
  j : integer;
  len : integer;
  strlen : integer;
  tab : array of integer;
  tab2 : array of integer;
  tab4 : array of char;
  tmpc : char;
  tmpi1 : integer;
  tmpi2 : integer;
  toto : integer;
begin
  len := 0;
  len := read_int();
  skip();
  write(len);
  write('=len'#10'');
  SetLength(tab, len);
  for i := 0 to  len - 1 do
  begin
    tmpi1 := 0;
    tmpi1 := read_int();
    skip();
    write(i);
    write('=>');
    write(tmpi1);
    write(' ');
    tab[i] := tmpi1;
  end;
  write(''#10'');
  SetLength(tab2, len);
  for i_ := 0 to  len - 1 do
  begin
    tmpi2 := 0;
    tmpi2 := read_int();
    skip();
    write(i_);
    write('==>');
    write(tmpi2);
    write(' ');
    tab2[i_] := tmpi2;
  end;
  strlen := 0;
  strlen := read_int();
  skip();
  write(strlen);
  write('=strlen'#10'');
  SetLength(tab4, strlen);
  for toto := 0 to  strlen - 1 do
  begin
    tmpc := #95;
    tmpc := read_char();
    c := ord(tmpc);
    write(tmpc);
    write(':');
    write(c);
    write(' ');
    if tmpc <> #32
    then
      begin
        c := ((c - ord(#97)) + 13) Mod 26 + ord(#97);
      end;
    tab4[toto] := chr(c);
  end;
  for j := 0 to  strlen - 1 do
  begin
    b := tab4[j];
    write(b);
  end;
end.


