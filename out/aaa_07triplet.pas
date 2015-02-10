program aaa_07triplet;

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

type q = array of Longint;

var
  a : Longint;
  b : Longint;
  c : Longint;
  i : Longint;
  j : Longint;
  l : q;
  o : Longint;
begin
  for i := 1 to  3 do
  begin
    a := read_int_();
    skip();
    b := read_int_();
    skip();
    c := read_int_();
    skip();
    Write('a = ');
    Write(a);
    Write(' b = ');
    Write(b);
    Write('c =');
    Write(c);
    Write(''#10'');
  end;
  SetLength(l, 10);
  for o := 0 to  10 - 1 do
  begin
    l[o] := read_int_();
    skip();
  end;
  for j := 0 to  9 do
  begin
    Write(l[j]);
    Write(''#10'');
  end;
end.


