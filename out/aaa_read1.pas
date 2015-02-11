program aaa_read1;

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
type b = array of char;

var
  a : Longint;
  i : Longint;
  str : b;
begin
  SetLength(str, 12);
  for a := 0 to  12 - 1 do
  begin
    str[a] := read_char_();
  end;
  skip();
  for i := 0 to  11 do
  begin
    Write(str[i]);
  end;
end.


