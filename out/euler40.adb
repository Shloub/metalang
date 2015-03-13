
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler40 is
function exp0(a : in Integer; e : in Integer) return Integer is
  o : Integer;
begin
  o := (1);
  for i in integer range (1)..e loop
    o := o * a;
  end loop;
  return o;
end;

type c is Array (Integer range <>) of Integer;
type c_PTR is access c;
function e(t : in c_PTR; b : in Integer) return Integer is
  nombre : Integer;
  n : Integer;
  chiffre : Integer;
begin
  n := b;
  for i in integer range (1)..(8) loop
    if n >= t(i) * i
    then
      n := n - t(i) * i;
    else
      nombre := exp0((10), i - (1)) + n / i;
      chiffre := i - (1) - n rem i;
      return (nombre / exp0((10), chiffre)) rem (10);
    end if;
  end loop;
  return (-(1));
end;


  v : Integer;
  t : c_PTR;
  puiss : Integer;
  out0 : Integer;
  n : Integer;
begin
  t := new c (0..(9));
  for i in integer range (0)..(9) - (1) loop
    t(i) := exp0((10), i) - exp0((10), i - (1));
  end loop;
  for i2 in integer range (1)..(8) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i2), Left));
    String'Write (Text_Streams.Stream (Current_Output), " => ");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(t(i2)), Left));
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  end loop;
  for j in integer range (0)..(80) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(e(t,
    j)), Left));
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  for k in integer range (1)..(50) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(k), Left));
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  for j2 in integer range (169)..(220) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(e(t,
    j2)), Left));
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  for k2 in integer range (90)..(110) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(k2), Left));
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  out0 := (1);
  for l in integer range (0)..(6) loop
    puiss := exp0((10), l);
    v := e(t, puiss - (1));
    out0 := out0 * v;
    String'Write (Text_Streams.Stream (Current_Output), "10^");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(l), Left));
    String'Write (Text_Streams.Stream (Current_Output), "=");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(puiss), Left));
    String'Write (Text_Streams.Stream (Current_Output), " v=");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(v), Left));
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(out0), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
end;
