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

{
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
}

var
  b : Longint;
  c : Longint;
  e : array of Longint;
  f : Longint;
  i : Longint;
  i3 : Longint;
  i_ : Longint;
  j : Longint;
  k : array of Longint;
  l : Longint;
  len : Longint;
  p : Longint;
  r : array of char;
  s : Longint;
  strlen : Longint;
  tab : array of Longint;
  tab2 : array of Longint;
  tab4 : array of char;
  tmpc : char;
begin
  b := read_int_();
  skip();
  len := b;
  Write(len);
  Write('=len'#10'');
  SetLength(e, len);
  for f := 0 to  len - 1 do
  begin
    e[f] := read_int_();
    skip();
  end;
  tab := e;
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
    k[l] := read_int_();
    skip();
  end;
  tab2 := k;
  for i_ := 0 to  len - 1 do
  begin
    Write(i_);
    Write('==>');
    Write(tab2[i_]);
    Write(' ');
  end;
  p := read_int_();
  skip();
  strlen := p;
  Write(strlen);
  Write('=strlen'#10'');
  SetLength(r, strlen);
  for s := 0 to  strlen - 1 do
  begin
    r[s] := read_char_();
  end;
  skip();
  tab4 := r;
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


