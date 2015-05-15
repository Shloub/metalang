program euler32;

{
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier,
and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a
1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.


(a * 10 + b) ( c * 100 + d * 10 + e) =
  a * c * 1000 +
  a * d * 100 +
  a * e * 10 +
  b * c * 100 +
  b * d * 10 +
  b * e
  => b != e != b * e % 10 ET
  a != d != (b * e / 10 + b * d + a * e ) % 10
}
type f = array of boolean;
function okdigits(ok : f; n : Longint) : boolean;
var
  digit : Longint;
  o : boolean;
begin
  if n = 0
  then
    begin
      exit(true);
    end
  else
    begin
      digit := n Mod 10;
      if ok[digit]
      then
        begin
          ok[digit] := false;
          o := okdigits(ok, n Div 10);
          ok[digit] := true;
          exit(o);
        end
      else
        begin
          exit(false);
        end;
    end;
end;


var
  a : Longint;
  allowed : f;
  b : Longint;
  be : Longint;
  c : Longint;
  count : Longint;
  counted : f;
  d : Longint;
  e : Longint;
  i : Longint;
  j : Longint;
  product : Longint;
  product2 : Longint;
begin
  count := 0;
  SetLength(allowed, 10);
  for i := 0 to  10 - 1 do
  begin
    allowed[i] := i <> 0;
  end;
  SetLength(counted, 100000);
  for j := 0 to  100000 - 1 do
  begin
    counted[j] := false;
  end;
  for e := 1 to  9 do
  begin
    allowed[e] := false;
    for b := 1 to  9 do
    begin
      if allowed[b]
      then
        begin
          allowed[b] := false;
          be := b * e Mod 10;
          if allowed[be]
          then
            begin
              allowed[be] := false;
              for a := 1 to  9 do
              begin
                if allowed[a]
                then
                  begin
                    allowed[a] := false;
                    for c := 1 to  9 do
                    begin
                      if allowed[c]
                      then
                        begin
                          allowed[c] := false;
                          for d := 1 to  9 do
                          begin
                            if allowed[d]
                            then
                              begin
                                allowed[d] := false;
                                { 2 * 3 digits }
                                product := (a * 10 + b) * (c * 100 + d * 10 + e);
                                if not(counted[product]) and okdigits(allowed, product Div 10)
                                then
                                  begin
                                    counted[product] := true;
                                    count := count + product;
                                    Write(product);
                                    Write(' ');
                                  end;
                                { 1  * 4 digits }
                                product2 := b * (a * 1000 + c * 100 + d * 10 + e);
                                if not(counted[product2]) and okdigits(allowed, product2 Div 10)
                                then
                                  begin
                                    counted[product2] := true;
                                    count := count + product2;
                                    Write(product2);
                                    Write(' ');
                                  end;
                                allowed[d] := true;
                              end;
                          end;
                          allowed[c] := true;
                        end;
                    end;
                    allowed[a] := true;
                  end;
              end;
              allowed[be] := true;
            end;
          allowed[b] := true;
        end;
    end;
    allowed[e] := true;
  end;
  Write(count);
  Write(''#10'');
end.


