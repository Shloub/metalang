program devine;

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

type b = array of integer;
function devine_(nombre : integer; tab : b; len : integer) : boolean;
var
  i : integer;
  max_ : integer;
  min_ : integer;
begin
  min_ := tab[0];
  max_ := tab[1];
  for i := 2 to  len - 1 do
  begin
    if (tab[i] > max_) or (tab[i] < min_)
    then
      begin
        exit(false);
      end;
    if tab[i] < nombre
    then
      begin
        min_ := tab[i];
      end;
    if tab[i] > nombre
    then
      begin
        max_ := tab[i];
      end;
    if (tab[i] = nombre) and (len <> (i + 1))
    then
      begin
        exit(false);
      end;
  end;
  exit(true);
end;


var
  a : boolean;
  i : integer;
  len : integer;
  nombre : integer;
  tab : b;
  tmp : integer;
begin
  nombre := 0;
  nombre := read_int_();
  skip();
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
  a := devine_(nombre, tab, len);
  if a
  then
    begin
      Write('True');
    end
  else
    begin
      Write('False');
    end;
end.


