
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

type bi is Array (Integer range <>) of Integer;
type bi_PTR is access bi;
type bj is Array (Integer range <>) of bi_PTR;
type bj_PTR is access bj;
function find(n : in Integer; m : in bj_PTR; x : in Integer; y : in Integer;
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

type bk is Array (Integer range <>) of tuple_int_int_PTR;
type bk_PTR is access bk;

  w : tuple_int_int_PTR;
  v : Integer;
  u : Integer;
  s : bi_PTR;
  r : Integer;
  max0 : Integer;
  m : bj_PTR;
  h : Integer;
  dy : Integer;
  dx : Integer;
  directions : bk_PTR;
  bh : tuple_int_int_PTR;
  bg : tuple_int_int_PTR;
  bf : tuple_int_int_PTR;
  be : tuple_int_int_PTR;
  bd : tuple_int_int_PTR;
  bc : tuple_int_int_PTR;
  bb : tuple_int_int_PTR;
  ba : tuple_int_int_PTR;
begin
  directions := new bk (0..(8));
  for i in integer range (0)..(8) - (1) loop
    if i = (0)
    then
      bh := new tuple_int_int;
      bh.tuple_int_int_field_0 := (0);
      bh.tuple_int_int_field_1 := (1);
      directions(i) := bh;
    else
      if i = (1)
      then
        bg := new tuple_int_int;
        bg.tuple_int_int_field_0 := (1);
        bg.tuple_int_int_field_1 := (0);
        directions(i) := bg;
      else
        if i = (2)
        then
          bf := new tuple_int_int;
          bf.tuple_int_int_field_0 := (0);
          bf.tuple_int_int_field_1 := (-(1));
          directions(i) := bf;
        else
          if i = (3)
          then
            be := new tuple_int_int;
            be.tuple_int_int_field_0 := (-(1));
            be.tuple_int_int_field_1 := (0);
            directions(i) := be;
          else
            if i = (4)
            then
              bd := new tuple_int_int;
              bd.tuple_int_int_field_0 := (1);
              bd.tuple_int_int_field_1 := (1);
              directions(i) := bd;
            else
              if i = (5)
              then
                bc := new tuple_int_int;
                bc.tuple_int_int_field_0 := (1);
                bc.tuple_int_int_field_1 := (-(1));
                directions(i) := bc;
              else
                if i = (6)
                then
                  bb := new tuple_int_int;
                  bb.tuple_int_int_field_0 := (-(1));
                  bb.tuple_int_int_field_1 := (1);
                  directions(i) := bb;
                else
                  ba := new tuple_int_int;
                  ba.tuple_int_int_field_0 := (-(1));
                  ba.tuple_int_int_field_1 := (-(1));
                  directions(i) := ba;
                end if;
              end if;
            end if;
          end if;
        end if;
      end if;
    end if;
  end loop;
  max0 := (0);
  h := (20);
  m := new bj (0..(20));
  for o in integer range (0)..(20) - (1) loop
    s := new bi (0..h);
    for q in integer range (0)..h - (1) loop
      Get(r);
      SkipSpaces;
      s(q) := r;
    end loop;
    m(o) := s;
  end loop;
  for j in integer range (0)..(7) loop
    w := directions(j);
    dx := w.tuple_int_int_field_0;
    dy := w.tuple_int_int_field_1;
    for x in integer range (0)..(19) loop
      for y in integer range (0)..(19) loop
        v := find((4), m, x, y, dx, dy);
        u := max2_0(max0, v);
        max0 := u;
      end loop;
    end loop;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(max0), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;
