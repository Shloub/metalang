program euler30;

type g = array of Longint;

var
  a : Longint;
  b : Longint;
  c : Longint;
  d : Longint;
  e : Longint;
  f : Longint;
  i : Longint;
  p : g;
  r : Longint;
  s : Longint;
  sum : Longint;
begin
  {
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
}
  SetLength(p, 10);
  for i := 0 to  9 do
  begin
    p[i] := i * i * i * i * i;
  end;
  sum := 0;
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
            for f := 0 to  9 do
            begin
              s := p[a] + p[b] + p[c] + p[d] + p[e] + p[f];
              r := a + b * 10 + c * 100 + d * 1000 + e * 10000 + f * 100000;
              if (s = r) and (r <> 1)
              then
                begin
                  Write(f);
                  Write(e);
                  Write(d);
                  Write(c);
                  Write(b);
                  Write(a);
                  Write(' ');
                  Write(r);
                  Write(''#10'');
                  sum := sum + r;
                end;
            end;
          end;
        end;
      end;
    end;
  end;
  Write(sum);
end.


