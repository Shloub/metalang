program aaa_missing;

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

type b = array of integer;
function read_int_line(n : integer) : b;
var
  i : integer;
  t : integer;
  tab : b;
begin
  SetLength(tab, n);
  for i := 0 to  n - 1 do
  begin
    t := 0;
    t := read_int();
    skip();
    tab[i] := t;
  end;
  exit(tab);
end;

{
  Ce test a été généré par Metalang.
}
function result(len : integer; tab : b) : integer;
var
  i : integer;
  i1 : integer;
  i2 : integer;
  tab2 : array of boolean;
begin
  SetLength(tab2, len);
  for i := 0 to  len - 1 do
  begin
    tab2[i] := false;
  end;
  for i1 := 0 to  len - 1 do
  begin
    tab2[tab[i1]] := true;
  end;
  for i2 := 0 to  len - 1 do
  begin
    if not tab2[i2]
    then
      begin
        exit(i2);
      end;
  end;
  exit(-1);
end;


var
  a : integer;
  l0 : b;
  len : integer;
  tab : b;
begin
  l0 := read_int_line(1);
  len := l0[0];
  tab := read_int_line(len);
  a := result(len, tab);
  Write(a);
end.


