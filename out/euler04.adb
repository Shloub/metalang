
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler04 is
function max2_0(a : in Integer; b : in Integer) return Integer is
begin
  if a > b
  then
    return a;
  else
    return b;
  end if;
end;

--
--
--(a + b * 10 + c * 100) * (d + e * 10 + f * 100) =
--a * d + a * e * 10 + a * f * 100 +
--10 * (b * d + b * e * 10 + b * f * 100)+
--100 * (c * d + c * e * 10 + c * f * 100) =
--
--a * d       + a * e * 10   + a * f * 100 +
--b * d * 10  + b * e * 100  + b * f * 1000 +
--c * d * 100 + c * e * 1000 + c * f * 10000 =
--
--a * d +
--10 * ( a * e + b * d) +
--100 * (a * f + b * e + c * d) +
--(c * e + b * f) * 1000 +
--c * f * 10000
--
--

function chiffre(c : in Integer; m : in Integer) return Integer is
begin
  if c = (0)
  then
    return m rem (10);
  else
    return chiffre(c - (1), m / (10));
  end if;
end;


  mul : Integer;
  m : Integer;
begin
  m := (1);
  for a in integer range (0)..(9) loop
    for f in integer range (1)..(9) loop
      for d in integer range (0)..(9) loop
        for c in integer range (1)..(9) loop
          for b in integer range (0)..(9) loop
            for e in integer range (0)..(9) loop
              mul := a * d + (10) * (a * e + b * d) + (100) * (a * f + b * e +
                                                                c * d) + (1000) * (c *
                                                                    e + b * f) + (10000) * c * f;
              if chiffre((0), mul) = chiffre((5), mul) and then chiffre((1),
              mul) = chiffre((4), mul) and then chiffre((2), mul) =
              chiffre((3), mul)
              then
                m := max2_0(mul, m);
              end if;
            end loop;
          end loop;
        end loop;
      end loop;
    end loop;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(m), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;
