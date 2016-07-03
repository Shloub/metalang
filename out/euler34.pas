program euler34;

type h = array of Longint;

var
  a : Longint;
  b : Longint;
  c : Longint;
  d : Longint;
  e : Longint;
  f : h;
  g : Longint;
  i : Longint;
  j : Longint;
  num : Longint;
  out0 : Longint;
  sum : Longint;
begin
  SetLength(f, 10);
  for j := 0 to  9 do
  begin
    f[j] := 1;
  end;
  for i := 1 to  9 do
  begin
    f[i] := f[i] * i * f[i - 1];
    Write(f[i]);
    Write(' ');
  end;
  out0 := 0;
  Write(''#10'');
  for a := 0 to  9 do
  begin
    for b := 0 to  9 do
    begin
      for c := 0 to  9 do
      begin
        for d := 0 to  9 do
        begin
          for e := 0 to  9 do
          begin
            for g := 0 to  9 do
            begin
              sum := f[a] + f[b] + f[c] + f[d] + f[e] + f[g];
              num := ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g;
              if a = 0
              then
                begin
                  sum := sum - 1;
                  if b = 0
                  then
                    begin
                      sum := sum - 1;
                      if c = 0
                      then
                        begin
                          sum := sum - 1;
                          if d = 0
                          then
                            begin
                              sum := sum - 1;
                            end;
                        end;
                    end;
                end;
              if (sum = num) and (sum <> 1) and (sum <> 2)
              then
                begin
                  out0 := out0 + num;
                  Write(num);
                  Write(' ');
                end;
            end;
          end;
        end;
      end;
    end;
  end;
  Write(''#10'');
  Write(out0);
  Write(''#10'');
end.


