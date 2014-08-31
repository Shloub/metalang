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

function min2_(a : Longint; b : Longint) : Longint;
begin
  if a < b
  then
    begin
      exit(a);
    end
  else
    begin
      exit(b);
    end;
end;

type be = array of array of char;
type bf = array of char;
function read_char_matrix(x : Longint; y : Longint) : be;
var
  o : bf;
  p : Longint;
  q : char;
  tab : be;
  z : Longint;
begin
  SetLength(tab, y);
  for z := 0 to  y - 1 do
  begin
    SetLength(o, x);
    for p := 0 to  x - 1 do
    begin
      q := read_char_();
      o[p] := q;
    end;
    skip();
    tab[z] := o;
  end;
  exit(tab);
end;

type bg = array of array of Longint;
function pathfind_aux(cache : bg; tab : be; x : Longint; y : Longint; posX : Longint; posY : Longint) : Longint;
var
  out_ : Longint;
  r : Longint;
  s : Longint;
  u : Longint;
  v : Longint;
  val1 : Longint;
  val2 : Longint;
  val3 : Longint;
  val4 : Longint;
  w : Longint;
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
      s := min2_(val1, val2);
      u := min2_(s, val3);
      v := min2_(u, val4);
      w := v;
      r := w;
      out_ := 1 + r;
      cache[posY][posX] := out_;
      exit(out_);
    end;;;;
end;

type bh = array of Longint;
function pathfind(tab : be; x : Longint; y : Longint) : Longint;
var
  cache : bg;
  i : Longint;
  j : Longint;
  tmp : bh;
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
  bb : Longint;
  bd : Longint;
  result : Longint;
  tab : be;
  x : Longint;
  y : Longint;
begin
  bb := read_int_();
  skip();
  x := bb;
  bd := read_int_();
  skip();
  y := bd;
  Write(x);
  Write(' ');
  Write(y);
  Write(''#10'');
  tab := read_char_matrix(x, y);
  result := pathfind(tab, x, y);
  Write(result);
end.


