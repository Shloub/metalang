program euler33;

function max2(a : Longint; b : Longint) : Longint;
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

function min2(a : Longint; b : Longint) : Longint;
begin
  if a < b
  then
    begin
      exit(a);
    end
  else
    begin
      exit(b);
    end;
end;

function pgcd(a : Longint; b : Longint) : Longint;
var
  c : Longint;
  d : Longint;
  reste : Longint;
begin
  c := min2(a, b);
  d := max2(a, b);
  reste := d Mod c;
  if reste = 0
  then
    begin
      exit(c);
    end
  else
    begin
      exit(pgcd(c, reste));
    end;
end;


var
  a : Longint;
  b : Longint;
  bottom : Longint;
  e : Longint;
  i : Longint;
  j : Longint;
  k : Longint;
  p : Longint;
  top : Longint;
begin
  top := 1;
  bottom := 1;
  for i := 1 to  9 do
  begin
    for j := 1 to  9 do
    begin
      for k := 1 to  9 do
      begin
        if (i <> j) and (j <> k)
        then
          begin
            a := i * 10 + j;
            b := j * 10 + k;
            if (a * k) = (i * b)
            then
              begin
                Write(a);
                Write('/');
                Write(b);
                Write(''#10'');
                top := top * a;
                bottom := bottom * b;
              end;
          end;
      end;
    end;
  end;
  Write(top);
  Write('/');
  Write(bottom);
  Write(''#10'');
  p := pgcd(top, bottom);
  Write('pgcd=');
  Write(p);
  Write(''#10'');
  e := bottom Div p;
  Write(e);
  Write(''#10'');
end.


