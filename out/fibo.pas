program fibo;

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

{
La suite de fibonaci
}
function fibo_(a : integer; b : integer; i : integer) : integer;
var
  a2 : integer;
  b2 : integer;
  j : integer;
  out_ : integer;
  tmp : integer;
begin
  out_ := 0;
  a2 := a;
  b2 := b;
  for j := 0 to  i + 1 do
  begin
    out_ := out_ + a2;
    tmp := b2;
    b2 := b2 + a2;
    a2 := tmp;
  end;
  exit(out_);
end;


var
  a : integer;
  b : integer;
  c : integer;
  i : integer;
begin
  a := 0;
  b := 0;
  i := 0;
  a := read_int_();
  skip();
  b := read_int_();
  skip();
  i := read_int_();
  c := fibo_(a, b, i);
  Write(c);
end.


