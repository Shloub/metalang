
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler05 is
function max2_0(a : in Integer; b : in Integer) return Integer is
begin
  if a > b
  then
    return a;
  else
    return b;
  end if;
end;

type q is Array (Integer range <>) of Integer;
type q_PTR is access q;
function primesfactors(p : in Integer) return q_PTR is
  tab : q_PTR;
  n : Integer;
  d : Integer;
begin
  n := p;
  tab := new q (0..n + (1));
  for i in integer range (0)..n + (1) - (1) loop
    tab(i) := (0);
  end loop;
  d := (2);
  while n /= (1) and then d * d <= n loop
    if (n rem d) = (0)
    then
      tab(d) := tab(d) + (1);
      n := n / d;
    else
      d := d + (1);
    end if;
  end loop;
  tab(n) := tab(n) + (1);
  return tab;
end;


  t : q_PTR;
  product : Integer;
  o : q_PTR;
  n : Integer;
  lim : Integer;
begin
  lim := (20);
  o := new q (0..lim + (1));
  for m in integer range (0)..lim + (1) - (1) loop
    o(m) := (0);
  end loop;
  for i in integer range (1)..lim loop
    t := primesfactors(i);
    for j in integer range (1)..i loop
      o(j) := max2_0(o(j), t(j));
    end loop;
  end loop;
  product := (1);
  for k in integer range (1)..lim loop
    for l in integer range (1)..o(k) loop
      product := product * k;
    end loop;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(product), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;
