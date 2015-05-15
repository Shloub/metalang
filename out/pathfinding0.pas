program pathfinding0;
Uses math;

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

type k = array of Longint;
type l = array of array of Longint;
type m = array of char;
type o = array of array of char;
function pathfind_aux(cache : l; tab : o; x : Longint; y : Longint; posX : Longint; posY : Longint) : Longint;
var
  out0 : Longint;
  val1 : Longint;
  val2 : Longint;
  val3 : Longint;
  val4 : Longint;
begin
  if (posX = x - 1) and (posY = y - 1) then
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
      out0 := 1 + Min(Min(Min(val1, val2), val3), val4);
      cache[posY][posX] := out0;
      exit(out0);
    end;;;;
end;

function pathfind(tab : o; x : Longint; y : Longint) : Longint;
var
  cache : l;
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
      Write(tab[i][j]);
      tmp[j] := -1;
    end;
    Write(''#10'');
    cache[i] := tmp;
  end;
  exit(pathfind_aux(cache, tab, x, y, 0, 0));
end;


var
  e : o;
  f : Longint;
  g : m;
  h : Longint;
  result : Longint;
  tab : o;
  x : Longint;
  y : Longint;
begin
  x := read_int_();
  skip();
  y := read_int_();
  skip();
  Write(x);
  Write(' ');
  Write(y);
  Write(''#10'');
  SetLength(e, y);
  for f := 0 to  y - 1 do
  begin
    SetLength(g, x);
    for h := 0 to  x - 1 do
    begin
      g[h] := read_char_();
    end;
    skip();
    e[f] := g;
  end;
  tab := e;
  result := pathfind(tab, x, y);
  Write(result);
end.


