program npi;

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


function is_number(c : char) : boolean;
begin
  exit((ord(c) <= ord(#57)) and (ord(c) >= ord(#48)));
end;

{
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
}
type a = array of char;
function npi_(str : a; len : integer) : integer;
var
  i : integer;
  num : integer;
  ptrStack : integer;
  ptrStr : integer;
  stack : array of integer;
begin
  SetLength(stack, len);
  for i := 0 to  len - 1 do
  begin
    stack[i] := 0;
  end;
  ptrStack := 0;
  ptrStr := 0;
  while ptrStr < len do
  begin
    if str[ptrStr] = #32 then
      begin
        ptrStr := ptrStr + 1;
      end
    else if is_number(str[ptrStr]) then
      begin
        num := 0;
        while str[ptrStr] <> #32 do
        begin
          num := num * 10 + ord(str[ptrStr]) - ord(#48);
          ptrStr := ptrStr + 1;
        end;
        stack[ptrStack] := num;
        ptrStack := ptrStack + 1;
      end
    else if str[ptrStr] = #43
    then
      begin
        stack[ptrStack - 2] := stack[ptrStack - 2] + stack[ptrStack - 1];
        ptrStack := ptrStack - 1;
        ptrStr := ptrStr + 1;
      end;;;
  end;
  exit(stack[0]);
end;


var
  i : integer;
  len : integer;
  result : integer;
  tab : a;
  tmp : char;
begin
  len := 0;
  len := read_int_();
  skip();
  SetLength(tab, len);
  for i := 0 to  len - 1 do
  begin
    tmp := #0;
    tmp := read_char_();
    tab[i] := tmp;
  end;
  result := npi_(tab, len);
  Write(result);
end.


