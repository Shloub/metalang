program aaa_readints;

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

type c = array of integer;
function read_int_line(n : integer) : c;
var
  i : integer;
  t : integer;
  tab : c;
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


var
  a : integer;
  b : integer;
  i : integer;
  l0 : c;
  len : integer;
  tab1 : c;
  tab2 : c;
begin
  l0 := read_int_line(1);
  len := l0[0];
  write(len);
  write('=len'#10'');
  tab1 := read_int_line(len);
  for i := 0 to  len - 1 do
  begin
    write(i);
    write('=>');
    a := tab1[i];
    write(a);
    write(''#10'');
  end;
  tab2 := read_int_line(len);
  for i := 0 to  len - 1 do
  begin
    write(i);
    write('=>');
    b := tab2[i];
    write(b);
    write(''#10'');
  end;
end.


