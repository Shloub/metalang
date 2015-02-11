
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler11 is
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
function max2_0(a : in Integer; b : in Integer) return Integer is
begin
  if a > b
  then
    return a;
  else
    return b;
  end if;
end;

type u is Array (Integer range <>) of Integer;
type u_PTR is access u;
type v is Array (Integer range <>) of u_PTR;
type v_PTR is access v;
function find(n : in Integer; m : in v_PTR; x : in Integer; y : in Integer;
dx : in Integer; dy : in Integer) return Integer is
begin
  if x < (0) or else x = (20) or else y < (0) or else y = (20)
  then
    return (-(1));
  else
    if n = (0)
    then
      return (1);
    else
      return m(y)(x) * find(n - (1), m, x + dx, y + dy, dx, dy);
    end if;
  end if;
end;


type tuple_int_int;
type tuple_int_int_PTR is access tuple_int_int;
type tuple_int_int is record
  tuple_int_int_field_0 : Integer;
  tuple_int_int_field_1 : Integer;
end record;

type w is Array (Integer range <>) of tuple_int_int_PTR;
type w_PTR is access w;

  s : tuple_int_int_PTR;
  q : u_PTR;
  o : Integer;
  max0 : Integer;
  m : v_PTR;
  l : tuple_int_int_PTR;
  k : tuple_int_int_PTR;
  h : tuple_int_int_PTR;
  g : tuple_int_int_PTR;
  f : tuple_int_int_PTR;
  e : tuple_int_int_PTR;
  dy : Integer;
  dx : Integer;
  directions : w_PTR;
  d : tuple_int_int_PTR;
  c : tuple_int_int_PTR;
begin
  directions := new w (0..(8));
  for i in integer range (0)..(8) - (1) loop
    if i = (0)
    then
      c := new tuple_int_int;
      c.tuple_int_int_field_0 := (0);
      c.tuple_int_int_field_1 := (1);
      directions(i) := c;
    else
      if i = (1)
      then
        d := new tuple_int_int;
        d.tuple_int_int_field_0 := (1);
        d.tuple_int_int_field_1 := (0);
        directions(i) := d;
      else
        if i = (2)
        then
          e := new tuple_int_int;
          e.tuple_int_int_field_0 := (0);
          e.tuple_int_int_field_1 := (-(1));
          directions(i) := e;
        else
          if i = (3)
          then
            f := new tuple_int_int;
            f.tuple_int_int_field_0 := (-(1));
            f.tuple_int_int_field_1 := (0);
            directions(i) := f;
          else
            if i = (4)
            then
              g := new tuple_int_int;
              g.tuple_int_int_field_0 := (1);
              g.tuple_int_int_field_1 := (1);
              directions(i) := g;
            else
              if i = (5)
              then
                h := new tuple_int_int;
                h.tuple_int_int_field_0 := (1);
                h.tuple_int_int_field_1 := (-(1));
                directions(i) := h;
              else
                if i = (6)
                then
                  k := new tuple_int_int;
                  k.tuple_int_int_field_0 := (-(1));
                  k.tuple_int_int_field_1 := (1);
                  directions(i) := k;
                else
                  l := new tuple_int_int;
                  l.tuple_int_int_field_0 := (-(1));
                  l.tuple_int_int_field_1 := (-(1));
                  directions(i) := l;
                end if;
              end if;
            end if;
          end if;
        end if;
      end if;
    end if;
  end loop;
  max0 := (0);
  o := (20);
  m := new v (0..(20));
  for p in integer range (0)..(20) - (1) loop
    q := new u (0..o);
    for r in integer range (0)..o - (1) loop
      Get(q(r));
      SkipSpaces;
    end loop;
    m(p) := q;
  end loop;
  for j in integer range (0)..(7) loop
    s := directions(j);
    dx := s.tuple_int_int_field_0;
    dy := s.tuple_int_int_field_1;
    for x in integer range (0)..(19) loop
      for y in integer range (0)..(19) loop
        max0 := max2_0(max0, find((4), m, x, y, dx, dy));
      end loop;
    end loop;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(max0), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
end;
