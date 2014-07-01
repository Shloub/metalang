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



{
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
}

var
  a : char;
  c : Longint;
  i : Longint;
  i_ : Longint;
  j : Longint;
  len : Longint;
  strlen : Longint;
  tab : array of Longint;
  tab2 : array of Longint;
  tab4 : array of char;
  tmpc : char;
  tmpi1 : Longint;
  tmpi2 : Longint;
  toto : Longint;
begin
  len := 0;
  len := read_int_();
  skip();
  Write(len);
  Write('=len'#10'');
  len := len * 2;
  Write('len*2=');
  Write(len);
  Write(''#10'');
  len := len Div 2;
  SetLength(tab, len);
  for i := 0 to  len - 1 do
  begin
    tmpi1 := 0;
    tmpi1 := read_int_();
    skip();
    Write(i);
    Write('=>');
    Write(tmpi1);
    Write(' ');
    tab[i] := tmpi1;
  end;
  Write(''#10'');
  SetLength(tab2, len);
  for i_ := 0 to  len - 1 do
  begin
    tmpi2 := 0;
    tmpi2 := read_int_();
    skip();
    Write(i_);
    Write('==>');
    Write(tmpi2);
    Write(' ');
    tab2[i_] := tmpi2;
  end;
  strlen := 0;
  strlen := read_int_();
  skip();
  Write(strlen);
  Write('=strlen'#10'');
  SetLength(tab4, strlen);
  for toto := 0 to  strlen - 1 do
  begin
    tmpc := #95;
    tmpc := read_char_();
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
    tab4[toto] := chr(c);
  end;
  for j := 0 to  strlen - 1 do
  begin
    a := tab4[j];
    Write(a);
  end;
end.


