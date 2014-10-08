
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure pathfinding is
procedure SkipSpaces is
  C : Character;
  Eol : Boolean;
begin
  loop
    Look_Ahead(C, Eol);
    exit when Eol or C /= ' ';
    Get(C);
  end loop;
end;
function min2_0(a : in Integer; b : in Integer) return Integer is
begin
  if a < b
  then
    return a;
  else
    return b;
  end if;
end;

type r is Array (Integer range <>) of Integer;
type r_PTR is access r;
type s is Array (Integer range <>) of r_PTR;
type s_PTR is access s;
type t is Array (Integer range <>) of Character;
type t_PTR is access t;
type u is Array (Integer range <>) of t_PTR;
type u_PTR is access u;
function pathfind_aux(cache : in s_PTR; tab : in u_PTR; x : in Integer;
y : in Integer; posX : in Integer; posY : in Integer) return Integer is
  val4 : Integer;
  val3 : Integer;
  val2 : Integer;
  val1 : Integer;
  q : Integer;
  p : Integer;
  out0 : Integer;
  o : Integer;
  n : Integer;
  m : Integer;
begin
  if posX = x - (1) and then posY = y - (1)
  then
    return (0);
  else
    if posX < (0) or else posY < (0) or else posX >= x or else posY >= y
    then
      return x * y * (10);
    else
      if tab(posY)(posX) = '#'
      then
        return x * y * (10);
      else
        if cache(posY)(posX) /= (-(1))
        then
          return cache(posY)(posX);
        else
          cache(posY)(posX) := x * y * (10);
          val1 := pathfind_aux(cache, tab, x, y, posX + (1), posY);
          val2 := pathfind_aux(cache, tab, x, y, posX - (1), posY);
          val3 := pathfind_aux(cache, tab, x, y, posX, posY - (1));
          val4 := pathfind_aux(cache, tab, x, y, posX, posY + (1));
          n := min2_0(val1, val2);
          o := min2_0(n, val3);
          p := min2_0(o, val4);
          q := p;
          m := q;
          out0 := (1) + m;
          cache(posY)(posX) := out0;
          return out0;
        end if;
      end if;
    end if;
  end if;
end;

function pathfind(tab : in u_PTR; x : in Integer;
y : in Integer) return Integer is
  tmp : r_PTR;
  cache : s_PTR;
begin
  cache := new s (0..y);
  for i in integer range (0)..y - (1) loop
    tmp := new r (0..x);
    for j in integer range (0)..x - (1) loop
      tmp(j) := (-(1));
    end loop;
    cache(i) := tmp;
  end loop;
  return pathfind_aux(cache, tab, x, y, (0), (0));
end;


  y : Integer;
  x : Integer;
  tmp : Character;
  tab2 : t_PTR;
  tab : u_PTR;
  result : Integer;
begin
  x := (0);
  y := (0);
  Get(x);
  SkipSpaces;
  Get(y);
  SkipSpaces;
  tab := new u (0..y);
  for i in integer range (0)..y - (1) loop
    tab2 := new t (0..x);
    for j in integer range (0)..x - (1) loop
      tmp := Character'Val(0);
      Get(tmp);
      tab2(j) := tmp;
    end loop;
    SkipSpaces;
    tab(i) := tab2;
  end loop;
  result := pathfind(tab, x, y);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(result), Left));
end;
