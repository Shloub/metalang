program summax_souslist;

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

type a = array of integer;
function summax(lst : a; len : integer) : integer;
var
  current : integer;
  i : integer;
  max_ : integer;
begin
  current := 0;
  max_ := 0;
  for i := 0 to  len - 1 do
  begin
    current := current + lst[i];
    if current < 0
    then
      begin
        current := 0;
      end;
    if max_ < current
    then
      begin
        max_ := current;
      end;
  end;
  exit(max_);
end;


var
  i : integer;
  len : integer;
  result : integer;
  tab : a;
  tmp : integer;
begin
  len := 0;
  len := read_int();
  skip();
  SetLength(tab, len);
  for i := 0 to  len - 1 do
  begin
    tmp := 0;
    tmp := read_int();
    skip();
    tab[i] := tmp;
  end;
  result := summax(tab, len);
  Write(result);
end.


