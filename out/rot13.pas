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
Ce test effectue un rot13 sur une chaine lue en entrée
}
type a = array of char;

var
  c : Longint;
  j : Longint;
  strlen : Longint;
  tab4 : a;
  tmpc : char;
  toto : Longint;
begin
  strlen := read_int_();
  skip();
  SetLength(tab4, strlen);
  for toto := 0 to  strlen - 1 do
  begin
    tmpc := read_char_();
    c := ord(tmpc);
    if tmpc <> #32
    then
      begin
        c := (c - ord(#97) + 13) Mod 26 + ord(#97);
      end;
    tab4[toto] := chr(c);
  end;
  for j := 0 to  strlen - 1 do
  begin
    Write(tab4[j]);
  end;
end.


