
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure triangles is
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
-- Ce code a été généré par metalang
--   Il gère les entrées sorties pour un programme dynamique classique
--   dans les épreuves de prologin
--on le retrouve ici : http://projecteuler.net/problem=18
--

type c is Array (Integer range <>) of Integer;
type c_PTR is access c;
type d is Array (Integer range <>) of c_PTR;
type d_PTR is access d;
function find0(len : in Integer; tab : in d_PTR; cache : in d_PTR;
x : in Integer; y : in Integer) return Integer is
  result : Integer;
  out1 : Integer;
  out0 : Integer;
begin
  --
  --	Cette fonction est récursive
  --	
  
  if y = len - (1)
  then
    return tab(y)(x);
  else
    if x > y
    then
      return (-(10000));
    else
      if cache(y)(x) /= (0)
      then
        return cache(y)(x);
      end if;
    end if;
  end if;
  result := (0);
  out0 := find0(len, tab, cache, x, y + (1));
  out1 := find0(len, tab, cache, x + (1), y + (1));
  if out0 > out1
  then
    result := out0 + tab(y)(x);
  else
    result := out1 + tab(y)(x);
  end if;
  cache(y)(x) := result;
  return result;
end;

function find(len : in Integer; tab : in d_PTR) return Integer is
  tab3 : c_PTR;
  tab2 : d_PTR;
begin
  tab2 := new d (0..len);
  for i in integer range (0)..len - (1) loop
    tab3 := new c (0..i + (1));
    for j in integer range (0)..i + (1) - (1) loop
      tab3(j) := (0);
    end loop;
    tab2(i) := tab3;
  end loop;
  return find0(len, tab, tab2, (0), (0));
end;


  tmp : Integer;
  tab2 : c_PTR;
  tab : d_PTR;
  len : Integer;
begin
  len := (0);
  Get(len);
  SkipSpaces;
  tab := new d (0..len);
  for i in integer range (0)..len - (1) loop
    tab2 := new c (0..i + (1));
    for j in integer range (0)..i + (1) - (1) loop
      tmp := (0);
      Get(tmp);
      SkipSpaces;
      tab2(j) := tmp;
    end loop;
    tab(i) := tab2;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(find(len,
  tab)), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  for k in integer range (0)..len - (1) loop
    for l in integer range (0)..k loop
      String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(tab(k)(l)), Left));
      String'Write (Text_Streams.Stream (Current_Output), " ");
    end loop;
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  end loop;
end;
