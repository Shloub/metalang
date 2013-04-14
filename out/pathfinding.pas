program pathfinding;

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

function min2(a : integer; b : integer) : integer;
begin
  if a < b
  then
    begin
      exit(a);
    end;
  exit(b);
end;

function min3(a : integer; b : integer; c : integer) : integer;
begin
  exit(min2(min2(a, b), c));
end;

function min4(a : integer; b : integer; c : integer; d : integer) : integer;
begin
  exit(min3(min2(a, b), c, d));
end;

type e = array of array of integer;
type f = array of array of char;
function pathfind_aux(cache : e; tab : f; x : integer; y : integer; posX : integer; posY : integer) : integer;
var
  out_ : integer;
  val1 : integer;
  val2 : integer;
  val3 : integer;
  val4 : integer;
begin
  if (posX = (x - 1)) and (posY = (y - 1)) then
    begin
      exit(0);
    end
  else if (((posX < 0) or (posY < 0)) or (posX >= x)) or (posY >= y) then
    begin
      exit(x * y * 10);
    end
  else if tab[posY][posX] = #35 then
    begin
      exit(x * y * 10);
    end
  else if cache[posY][posX] <> -1
  then
    begin
      exit(cache[posY][posX]);
    end
  else
    begin
      cache[posY][posX] := x * y * 10;
      val1 := pathfind_aux(cache, tab, x, y, posX + 1, posY);
      val2 := pathfind_aux(cache, tab, x, y, posX - 1, posY);
      val3 := pathfind_aux(cache, tab, x, y, posX, posY - 1);
      val4 := pathfind_aux(cache, tab, x, y, posX, posY + 1);
      out_ := 1 + min4(val1, val2, val3, val4);
      cache[posY][posX] := out_;
      exit(out_);
    end;;;;
end;

type g = array of integer;
function pathfind(tab : f; x : integer; y : integer) : integer;
var
  cache : e;
  i : integer;
  j : integer;
  tmp : g;
begin
  SetLength(cache, y);
  for i := 0 to  y - 1 do
  begin
    SetLength(tmp, x);
    for j := 0 to  x - 1 do
    begin
      tmp[j] := -1;
    end;
    cache[i] := tmp;
  end;
  exit(pathfind_aux(cache, tab, x, y, 0, 0));
end;


var
  i : integer;
  j : integer;
  result : integer;
  tab : f;
  tab2 : array of char;
  tmp : char;
  x : integer;
  y : integer;
begin
  x := 0;
  y := 0;
  x := read_int();
  skip();
  y := read_int();
  skip();
  SetLength(tab, y);
  for i := 0 to  y - 1 do
  begin
    SetLength(tab2, x);
    for j := 0 to  x - 1 do
    begin
      tmp := #0;
      tmp := read_char();
      tab2[j] := tmp;
    end;
    skip();
    tab[i] := tab2;
  end;
  result := pathfind(tab, x, y);
  write(result);
end.


