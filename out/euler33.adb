
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler33 is
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
  if reste = (0)
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
  top := (1);
  bottom := (1);
  for i in integer range (1)..(9) loop
    for j in integer range (1)..(9) loop
      for k in integer range (1)..(9) loop
        if i /= j and then j /= k
        then
          a := i * (10) + j;
          b := j * (10) + k;
          if a * k = i * b
          then
            String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(a), Left));
            String'Write (Text_Streams.Stream (Current_Output), "/");
            String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(b), Left));
            String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
            top := top * a;
            bottom := bottom * b;
          end if;
        end if;
      end loop;
    end loop;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(top), Left));
  String'Write (Text_Streams.Stream (Current_Output), "/");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(bottom), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  p := pgcd(top, bottom);
  String'Write (Text_Streams.Stream (Current_Output), "pgcd=");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(p), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(bottom /
  p), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
end;
