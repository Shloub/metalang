program countchar;

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

type a = array of char;
function nth(tab : a; tofind : char; len : Longint) : Longint;
var
  i : Longint;
  out_ : Longint;
begin
  out_ := 0;
  for i := 0 to  len - 1 do
  begin
    if tab[i] = tofind
    then
      begin
        out_ := out_ + 1;
      end;
  end;
  exit(out_);
end;


var
  i : Longint;
  len : Longint;
  result : Longint;
  tab : a;
  tmp : char;
  tofind : char;
begin
  len := 0;
  len := read_int_();
  skip();
  tofind := #0;
  tofind := read_char_();
  skip();
  SetLength(tab, len);
  for i := 0 to  len - 1 do
  begin
    tmp := #0;
    tmp := read_char_();
    tab[i] := tmp;
  end;
  result := nth(tab, tofind, len);
  Write(result);
end.


