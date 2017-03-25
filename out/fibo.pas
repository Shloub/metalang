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
La suite de fibonaci
}
function fibo0(a : Longint; b : Longint; i : Longint) : Longint;
var
  a2 : Longint;
  b2 : Longint;
  j : Longint;
  out0 : Longint;
  tmp : Longint;
begin
  out0 := 0;
  a2 := a;
  b2 := b;
  for j := 0 to  i + 1 do
  begin
    out0 := out0 + a2;
    tmp := b2;
    b2 := b2 + a2;
    a2 := tmp;
  end;
  exit(out0);
end;


var
  a : Longint;
  b : Longint;
  i : Longint;
begin
  a := read_int_();
  skip();
  b := read_int_();
  skip();
  i := read_int_();
  Write(fibo0(a, b, i));
end.


