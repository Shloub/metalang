program euler04;

function max2_(a : Longint; b : Longint) : Longint;
begin
  if a > b
  then
    begin
      exit(a);
    end
  else
    begin
      exit(b);
    end;
end;

{

(a + b * 10 + c * 100) * (d + e * 10 + f * 100) =
a * d + a * e * 10 + a * f * 100 +
10 * (b * d + b * e * 10 + b * f * 100)+
100 * (c * d + c * e * 10 + c * f * 100) =

a * d       + a * e * 10   + a * f * 100 +
b * d * 10  + b * e * 100  + b * f * 1000 +
c * d * 100 + c * e * 1000 + c * f * 10000 =

a * d +
10 * ( a * e + b * d) +
100 * (a * f + b * e + c * d) +
(c * e + b * f) * 1000 +
c * f * 10000

}
function chiffre(c : Longint; m : Longint) : Longint;
begin
  if c = 0
  then
    begin
      exit(m Mod 10);
    end
  else
    begin
      exit(chiffre(c - 1, m Div 10));
    end;
end;


var
  a : Longint;
  b : Longint;
  c : Longint;
  d : Longint;
  e : Longint;
  f : Longint;
  m : Longint;
  mul : Longint;
begin
  m := 1;
  for a := 0 to  9 do
  begin
    for f := 1 to  9 do
    begin
      for d := 0 to  9 do
      begin
        for c := 1 to  9 do
        begin
          for b := 0 to  9 do
          begin
            for e := 0 to  9 do
            begin
              mul := a * d + 10 * (a * e + b * d) + 100 * (a * f + b * e + c *
                                                            d) + 1000 * (c * e +
                                                                          b * f) + 10000 * c * f;
              if (chiffre(0, mul) = chiffre(5, mul)) and (chiffre(1, mul) =
                                                           chiffre(4, mul)) and (chiffre(2,
                                                                                mul)
                                                                                =
                                                                                chiffre(3,
                                                                                mul))
              then
                begin
                  m := max2_(mul, m);
                end;
            end;
          end;
        end;
      end;
    end;
  end;
  Write(m);
  Write(''#10'');
end.


