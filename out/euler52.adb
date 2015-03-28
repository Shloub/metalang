
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure euler52 is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

function chiffre_sort(a : in Integer) return Integer is
  e : Integer;
  d : Integer;
  c : Integer;
  b : Integer;
begin
  if a < 10
  then
    return a;
  else
    b := chiffre_sort(a / 10);
    c := a rem 10;
    d := b rem 10;
    e := b / 10;
    if c < d
    then
      return c + b * 10;
    else
      return d + chiffre_sort(c + e * 10) * 10;
    end if;
  end if;
end;

function same_numbers(a : in Integer; b : in Integer; c : in Integer; d : in Integer; e : in Integer; f : in Integer) return Boolean is
  ca : Integer;
begin
  ca := chiffre_sort(a);
  return ca = chiffre_sort(b) and then ca = chiffre_sort(c) and then ca =
  chiffre_sort(d) and then ca = chiffre_sort(e) and then ca = chiffre_sort(f);
end;


  num : Integer;
begin
  num := 142857;
  if same_numbers(num, num * 2, num * 3, num * 4, num * 6, num * 5)
  then
    PInt(num);
    PString(new char_array'( To_C(" ")));
    PInt(num * 2);
    PString(new char_array'( To_C(" ")));
    PInt(num * 3);
    PString(new char_array'( To_C(" ")));
    PInt(num * 4);
    PString(new char_array'( To_C(" ")));
    PInt(num * 5);
    PString(new char_array'( To_C(" ")));
    PInt(num * 6);
    PString(new char_array'( To_C("" & Character'Val(10))));
  end if;
end;
