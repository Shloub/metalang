
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure pathfinding0 is
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

type bl is Array (Integer range <>) of Integer;
type bl_PTR is access bl;
type bm is Array (Integer range <>) of bl_PTR;
type bm_PTR is access bm;
type bn is Array (Integer range <>) of Character;
type bn_PTR is access bn;
type bo is Array (Integer range <>) of bn_PTR;
type bo_PTR is access bo;
function pathfind_aux(cache : in bm_PTR; tab : in bo_PTR; x : in Integer;
y : in Integer; posX : in Integer; posY : in Integer) return Integer is
  w : Integer;
  val4 : Integer;
  val3 : Integer;
  val2 : Integer;
  val1 : Integer;
  v : Integer;
  u : Integer;
  s : Integer;
  r : Integer;
  out0 : Integer;
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
          s := min2_0(val1, val2);
          u := min2_0(s, val3);
          v := min2_0(u, val4);
          w := v;
          r := w;
          out0 := (1) + r;
          cache(posY)(posX) := out0;
          return out0;
        end if;
      end if;
    end if;
  end if;
end;

function pathfind(tab : in bo_PTR; x : in Integer;
y : in Integer) return Integer is
  tmp : bl_PTR;
  cache : bm_PTR;
begin
  cache := new bm (0..y);
  for i in integer range (0)..y - (1) loop
    tmp := new bl (0..x);
    for j in integer range (0)..x - (1) loop
      Character'Write (Text_Streams.Stream (Current_Output), tab(i)(j));
      tmp(j) := (-(1));
    end loop;
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
    cache(i) := tmp;
  end loop;
  return pathfind_aux(cache, tab, x, y, (0), (0));
end;


  y : Integer;
  x : Integer;
  tab : bo_PTR;
  result : Integer;
  bj : Character;
  bh : bn_PTR;
  bf : bo_PTR;
  bd : Integer;
  bb : Integer;
begin
  Get(bb);
  SkipSpaces;
  x := bb;
  Get(bd);
  SkipSpaces;
  y := bd;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(x), Left));
  String'Write (Text_Streams.Stream (Current_Output), " ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(y), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  bf := new bo (0..y);
  for bg in integer range (0)..y - (1) loop
    bh := new bn (0..x);
    for bi in integer range (0)..x - (1) loop
      Get(bj);
      bh(bi) := bj;
    end loop;
    SkipSpaces;
    bf(bg) := bh;
  end loop;
  tab := bf;
  result := pathfind(tab, x, y);
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(result), Left));
end;
