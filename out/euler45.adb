
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler45 is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

function triangle(n : in Integer) return Integer is
begin
  if (n rem 2) = 0
  then
    return (n / 2) * (n + 1);
  else
    return n * ((n + 1) / 2);
  end if;
end;

function penta(n : in Integer) return Integer is
begin
  if (n rem 2) = 0
  then
    return (n / 2) * (3 * n - 1);
  else
    return ((3 * n - 1) / 2) * n;
  end if;
end;

function hexa(n : in Integer) return Integer is
begin
  return n * (2 * n - 1);
end;

function findPenta2(n : in Integer; a : in Integer; b : in Integer) return Boolean is
  p : Integer;
  c : Integer;
begin
  if b = a + 1
  then
    return penta(a) = n or else penta(b) = n;
  end if;
  c := (a + b) / 2;
  p := penta(c);
  if p = n
  then
    return TRUE;
  else
    if p < n
    then
      return findPenta2(n, c, b);
    else
      return findPenta2(n, a, c);
    end if;
  end if;
end;

function findHexa2(n : in Integer; a : in Integer; b : in Integer) return Boolean is
  p : Integer;
  c : Integer;
begin
  if b = a + 1
  then
    return hexa(a) = n or else hexa(b) = n;
  end if;
  c := (a + b) / 2;
  p := hexa(c);
  if p = n
  then
    return TRUE;
  else
    if p < n
    then
      return findHexa2(n, c, b);
    else
      return findHexa2(n, a, c);
    end if;
  end if;
end;


  t : Integer;
begin
  for n in integer range 285..55385 loop
    t := triangle(n);
    if findPenta2(t, n / 5, n) and then findHexa2(t, n / 5, n / 2 + 10)
    then
      PInt(n);
      PString("" & Character'Val(10));
      PInt(t);
      PString("" & Character'Val(10));
    end if;
  end loop;
end;
