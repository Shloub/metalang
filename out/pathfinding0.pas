program pathfinding0;

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

function min2(a : Longint; b : Longint) : Longint;
begin
  if a < b
  then
    begin
      exit(a);
    end;
  exit(b);
end;

function min3(a : Longint; b : Longint; c : Longint) : Longint;
begin
  exit(min2(min2(a, b), c));
end;

function min4(a : Longint; b : Longint; c : Longint; d : Longint) : Longint;
begin
  exit(min3(min2(a, b), c, d));
end;

function read_int() : Longint;
var
  out_ : Longint;
begin
  out_ := 0;
  out_ := read_int_();
  skip();
  exit(out_);
end;

type f = array of char;
function read_char_line(n : Longint) : f;
var
  i : Longint;
  t : char;
  tab : f;
begin
  SetLength(tab, n);
  for i := 0 to  n - 1 do
  begin
    t := #95;
    t := read_char_();
    tab[i] := t;
  end;
  skip();
  exit(tab);
end;

type g = array of f;
function read_char_matrix(x : Longint; y : Longint) : g;
var
  tab : g;
  z : Longint;
begin
  SetLength(tab, y);
  for z := 0 to  y - 1 do
  begin
    tab[z] := read_char_line(x);
  end;
  exit(tab);
end;

type h = array of array of Longint;
function pathfind_aux(cache : h; tab : g; x : Longint; y : Longint; posX : Longint; posY : Longint) : Longint;
var
  out_ : Longint;
  val1 : Longint;
  val2 : Longint;
  val3 : Longint;
  val4 : Longint;
begin
  if (posX = (x - 1)) and (posY = (y - 1)) then
    begin
      exit(0);
    end
  else if (posX < 0) or (posY < 0) or (posX >= x) or (posY >= y) then
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

type k = array of Longint;
function pathfind(tab : g; x : Longint; y : Longint) : Longint;
var
  cache : h;
  e : char;
  i : Longint;
  j : Longint;
  tmp : k;
begin
  SetLength(cache, y);
  for i := 0 to  y - 1 do
  begin
    SetLength(tmp, x);
    for j := 0 to  x - 1 do
    begin
      e := tab[i][j];
      Write(e);
      tmp[j] := -1;
    end;
    Write(''#10'');
    cache[i] := tmp;
  end;
  exit(pathfind_aux(cache, tab, x, y, 0, 0));
end;


var
  result : Longint;
  tab : g;
  x : Longint;
  y : Longint;
begin
  x := read_int();
  y := read_int();
  Write(x);
  Write(' ');
  Write(y);
  Write(''#10'');
  tab := read_char_matrix(x, y);
  result := pathfind(tab, x, y);
  Write(result);
end.


