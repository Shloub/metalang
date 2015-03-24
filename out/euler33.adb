
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler33 is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
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

function min2_0(a : in Integer; b : in Integer) return Integer is
begin
  if a < b
  then
    return a;
  else
    return b;
  end if;
end;

function pgcd(a : in Integer; b : in Integer) return Integer is
  reste : Integer;
  d : Integer;
  c : Integer;
begin
  c := min2_0(a, b);
  d := max2_0(a, b);
  reste := d rem c;
  if reste = 0
  then
    return c;
  else
    return pgcd(c, reste);
  end if;
end;


  top : Integer;
  p : Integer;
  bottom : Integer;
  b : Integer;
  a : Integer;
begin
  top := 1;
  bottom := 1;
  for i in integer range 1..9 loop
    for j in integer range 1..9 loop
      for k in integer range 1..9 loop
        if i /= j and then j /= k
        then
          a := i * 10 + j;
          b := j * 10 + k;
          if a * k = i * b
          then
            PInt(a);
            PString("/");
            PInt(b);
            PString("" & Character'Val(10));
            top := top * a;
            bottom := bottom * b;
          end if;
        end if;
      end loop;
    end loop;
  end loop;
  PInt(top);
  PString("/");
  PInt(bottom);
  PString("" & Character'Val(10));
  p := pgcd(top, bottom);
  PString("pgcd=");
  PInt(p);
  PString("" & Character'Val(10));
  PInt(bottom / p);
  PString("" & Character'Val(10));
end;
