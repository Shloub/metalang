program rot13;

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
Ce test effectue un rot13 sur une chaine lue en entrée
}

var
  a : char;
  c : integer;
  j : integer;
  strlen : integer;
  tab4 : array of char;
  tmpc : char;
  toto : integer;
begin
  strlen := 0;
  strlen := read_int();
  skip();
  SetLength(tab4, strlen);
  for toto := 0 to  strlen - 1 do
  begin
    tmpc := #95;
    tmpc := read_char();
    c := ord(tmpc);
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


