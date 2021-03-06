program euler43;


type a = array of boolean;

var
  allowed : a;
  d1 : Longint;
  d10 : Longint;
  d2 : Longint;
  d3 : Longint;
  d4 : Longint;
  d5 : Longint;
  d6 : Longint;
  d7 : Longint;
  d8 : Longint;
  d9 : Longint;
  i : Longint;
  i4 : Longint;
  i6 : Longint;
begin
  {
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

d2d3d4=406 is divisible by 2
d3d4d5=063 is divisible by 3
d4d5d6=635 is divisible by 5
d5d6d7=357 is divisible by 7
d6d7d8=572 is divisible by 11
d7d8d9=728 is divisible by 13
d8d9d10=289 is divisible by 17
Find the sum of all 0 to 9 pandigital numbers with this property.

d4 % 2 == 0
(d3 + d4 + d5) % 3 == 0
d6 = 5 ou d6 = 0
(d5 * 100 + d6 * 10 + d7  ) % 7 == 0
(d6 * 100 + d7 * 10 + d8  ) % 11 == 0
(d7 * 100 + d8 * 10 + d9  ) % 13 == 0
(d8 * 100 + d9 * 10 + d10 ) % 17 == 0


d4 % 2 == 0
d6 = 5 ou d6 = 0

(d3 + d4 + d5) % 3 == 0
(d5 * 2 + d6 * 3 + d7) % 7 == 0
}
  SetLength(allowed, 10);
  for i := 0 to  9 do
  begin
    allowed[i] := true;
  end;
  for i6 := 0 to  1 do
  begin
    d6 := i6 * 5;
    if allowed[d6]
    then
      begin
        allowed[d6] := false;
        for d7 := 0 to  9 do
        begin
          if allowed[d7]
          then
            begin
              allowed[d7] := false;
              for d8 := 0 to  9 do
              begin
                if allowed[d8]
                then
                  begin
                    allowed[d8] := false;
                    for d9 := 0 to  9 do
                    begin
                      if allowed[d9]
                      then
                        begin
                          allowed[d9] := false;
                          for d10 := 1 to  9 do
                          begin
                            if allowed[d10] and ((d6 * 100 + d7 * 10 + d8) Mod 11 = 0) and ((d7 * 100 + d8 * 10 + d9) Mod 13 = 0) and ((d8 * 100 + d9 * 10 + d10) Mod 17 = 0)
                            then
                              begin
                                allowed[d10] := false;
                                for d5 := 0 to  9 do
                                begin
                                  if allowed[d5]
                                  then
                                    begin
                                      allowed[d5] := false;
                                      if (d5 * 100 + d6 * 10 + d7) Mod 7 = 0
                                      then
                                        begin
                                          for i4 := 0 to  4 do
                                          begin
                                            d4 := i4 * 2;
                                            if allowed[d4]
                                            then
                                              begin
                                                allowed[d4] := false;
                                                for d3 := 0 to  9 do
                                                begin
                                                  if allowed[d3]
                                                  then
                                                    begin
                                                      allowed[d3] := false;
                                                      if (d3 + d4 + d5) Mod 3 = 0
                                                      then
                                                        begin
                                                          for d2 := 0 to  9 do
                                                          begin
                                                            if allowed[d2]
                                                            then
                                                              begin
                                                                allowed[d2] := false;
                                                                for d1 := 0 to  9 do
                                                                begin
                                                                  if allowed[d1]
                                                                  then
                                                                    begin
                                                                      allowed[d1] := false;
                                                                      Write(d1);
                                                                      Write(d2);
                                                                      Write(d3);
                                                                      Write(d4);
                                                                      Write(d5);
                                                                      Write(d6);
                                                                      Write(d7);
                                                                      Write(d8);
                                                                      Write(d9);
                                                                      Write(d10);
                                                                      Write(' + ');
                                                                      allowed[d1] := true;
                                                                    end;
                                                                end;
                                                                allowed[d2] := true;
                                                              end;
                                                          end;
                                                        end;
                                                      allowed[d3] := true;
                                                    end;
                                                end;
                                                allowed[d4] := true;
                                              end;
                                          end;
                                        end;
                                      allowed[d5] := true;
                                    end;
                                end;
                                allowed[d10] := true;
                              end;
                          end;
                          allowed[d9] := true;
                        end;
                    end;
                    allowed[d8] := true;
                  end;
              end;
              allowed[d7] := true;
            end;
        end;
        allowed[d6] := true;
      end;
  end;
  Write(0);
  Write(''#10'');
end.


