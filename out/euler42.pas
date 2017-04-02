program euler42;
Uses math;

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

function is_triangular(n : Longint) : boolean;
var
  a : Longint;
begin
  {
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   }
  a := Floor(Sqrt(n * 2));
  exit(a * (a + 1) = n * 2);
end;

function score() : Longint;
var
  c : char;
  i : Longint;
  len : Longint;
  sum : Longint;
begin
  skip();
  len := read_int_();
  skip();
  sum := 0;
  for i := 1 to  len do
  begin
    c := read_char_();
    sum := sum + ord(c) - ord(#65) + 1;
    {		print c print " " print sum print " " }
  end;
  if is_triangular(sum)
  then
    begin
      exit(1);
    end
  else
    begin
      exit(0);
    end;
end;


var
  i : Longint;
  n : Longint;
  sum : Longint;
begin
  for i := 1 to  55 do
  begin
    if is_triangular(i)
    then
      begin
        Write(i);
        Write(' ');
      end;
  end;
  Write(''#10'');
  sum := 0;
  n := read_int_();
  for i := 1 to  n do
  begin
    sum := sum + score();
  end;
  Write(sum);
  Write(''#10'');
end.


