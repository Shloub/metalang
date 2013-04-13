program sort;


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
procedure sort_(tab : c; len : integer);
var
  i : integer;
  j : integer;
  tmp : integer;
begin
  for i := 0 to  len - 1 do
  begin
    for j := i + 1 to  len - 1 do
    begin
      if tab[i] > tab[j]
      then
        begin
          tmp := tab[i];
          tab[i] := tab[j];
          tab[j] := tmp;
        end;
    end;
  end;
end;


var
  b : integer;
  i : integer;
  len : integer;
  tab : c;
  tmp : integer;
begin
  len := 2;
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
  sort_(tab, len);
  for i := 0 to  len - 1 do
  begin
    b := tab[i];
    write(b);
  end;
end.


