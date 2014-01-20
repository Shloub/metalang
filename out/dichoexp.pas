program dichoexp;

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

function exp_(a : integer; b : integer) : integer;
var
  o : integer;
begin
  if b = 0
  then
    begin
      exit(1);
    end;
  if (b Mod 2) = 0
  then
    begin
      o := exp_(a, b Div 2);
      exit(o * o);
    end
  else
    begin
      exit(a * exp_(a, b - 1));
    end;
end;


var
  a : integer;
  b : integer;
  c : integer;
begin
  a := 0;
  b := 0;
  a := read_int();
  skip();
  b := read_int();
  c := exp_(a, b);
  write(c);
end.


