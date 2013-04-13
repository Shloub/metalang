program montagnes;


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


type c = array of integer;
function montagnes_(tab : c; len : integer) : integer;
var
  i : integer;
  j : integer;
  max_ : integer;
  x : integer;
begin
  max_ := 1;
  j := 1;
  i := len - 2;
  while i >= 0 do
  begin
    x := tab[i];
    while (j >= 0) and (x > tab[len - j]) do
    begin
      j := j - 1;
    end;
    j := j + 1;
    tab[len - j] := x;
    if j > max_
    then
      begin
        max_ := j;
      end;
    i := i - 1;
  end;
  exit(max_);
end;


var
  b : integer;
  i : integer;
  len : integer;
  tab : c;
  x : integer;
begin
  len := 0;
  len := read_int();
  skip();
  SetLength(tab, len);
  for i := 0 to  len - 1 do
  begin
    x := 0;
    x := read_int();
    skip();
    tab[i] := x;
  end;
  b := montagnes_(tab, len);
  write(b);
end.


