
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler52 is
function chiffre_sort(a : in Integer) return Integer is
  e : Integer;
  d : Integer;
  c : Integer;
  b : Integer;
begin
  if a < (10)
  then
    return a;
  else
    b := chiffre_sort(a / (10));
    c := a rem (10);
    d := b rem (10);
    e := b / (10);
    if c < d
    then
      return c + b * (10);
    else
      return d + chiffre_sort(c + e * (10)) * (10);
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
  num := (142857);
  if same_numbers(num, num * (2), num * (3), num * (4), num * (6), num * (5))
  then
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(num), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(num *
    (2)), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(num *
    (3)), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(num *
    (4)), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(num *
    (5)), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(num *
    (6)), Left));
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  end if;
end;
