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

type a = array of Longint;
function summax(lst : a; len : Longint) : Longint;
var
  current : Longint;
  i : Longint;
  max0 : Longint;
begin
  current := 0;
  max0 := 0;
  for i := 0 to  len - 1 do
  begin
    current := current + lst[i];
    if current < 0
    then
      begin
        current := 0;
      end;
    if max0 < current
    then
      begin
        max0 := current;
      end;
  end;
  exit(max0);
end;


var
  i : Longint;
  len : Longint;
  result : Longint;
  tab : a;
  tmp : Longint;
begin
  len := 0;
  len := read_int_();
  skip();
  SetLength(tab, len);
  for i := 0 to  len - 1 do
  begin
    tmp := 0;
    tmp := read_int_();
    skip();
    tab[i] := tmp;
  end;
  result := summax(tab, len);
  Write(result);
end.


