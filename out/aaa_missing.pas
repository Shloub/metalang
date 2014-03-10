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

function read_int() : integer;
var
  out_ : integer;
begin
  out_ := 0;
  out_ := read_int_();
  skip();
  exit(out_);
end;

type b = array of integer;
function read_int_line(n : integer) : b;
var
  i : integer;
  t_ : integer;
  tab : b;
begin
  SetLength(tab, n);
  for i := 0 to  n - 1 do
  begin
    t_ := 0;
    t_ := read_int_();
    skip();
    tab[i] := t_;
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
  len : integer;
  tab : b;
begin
  len := read_int();
  Write(len);
  Write(''#10'');
  tab := read_int_line(len);
  a := result(len, tab);
  Write(a);
end.


