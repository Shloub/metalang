program euler45;

function triangle(n : Longint) : Longint;
begin
  if n Mod 2 = 0
  then
    begin
      exit((n Div 2) * (n + 1));
    end
  else
    begin
      exit(n * ((n + 1) Div 2));
    end;
end;

function penta(n : Longint) : Longint;
begin
  if n Mod 2 = 0
  then
    begin
      exit((n Div 2) * (3 * n - 1));
    end
  else
    begin
      exit(((3 * n - 1) Div 2) * n);
    end;
end;

function hexa(n : Longint) : Longint;
begin
  exit(n * (2 * n - 1));
end;

function findPenta2(n : Longint; a : Longint; b : Longint) : boolean;
var
  c : Longint;
  p : Longint;
begin
  if b = a + 1
  then
    begin
      exit((penta(a) = n) or (penta(b) = n));
    end;
  c := (a + b) Div 2;
  p := penta(c);
  if p = n then
    begin
      exit(true);
    end
  else if p < n
  then
    begin
      exit(findPenta2(n, c, b));
    end
  else
    begin
      exit(findPenta2(n, a, c));
    end;;
end;

function findHexa2(n : Longint; a : Longint; b : Longint) : boolean;
var
  c : Longint;
  p : Longint;
begin
  if b = a + 1
  then
    begin
      exit((hexa(a) = n) or (hexa(b) = n));
    end;
  c := (a + b) Div 2;
  p := hexa(c);
  if p = n then
    begin
      exit(true);
    end
  else if p < n
  then
    begin
      exit(findHexa2(n, c, b));
    end
  else
    begin
      exit(findHexa2(n, a, c));
    end;;
end;


var
  n : Longint;
  t : Longint;
begin
  for n := 285 to  55385 do
  begin
    t := triangle(n);
    if findPenta2(t, n Div 5, n) and findHexa2(t, n Div 5, n Div 2 + 10)
    then
      begin
        Write(n);
        Write(''#10'');
        Write(t);
        Write(''#10'');
      end;
  end;
end.


