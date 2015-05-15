program euler40;

function exp0(a : Longint; e : Longint) : Longint;
var
  i : Longint;
  o : Longint;
begin
  o := 1;
  for i := 1 to  e do
  begin
    o := o * a;
  end;
  exit(o);
end;

type b = array of Longint;
function e(t : b; n : Longint) : Longint;
var
  chiffre : Longint;
  i : Longint;
  nombre : Longint;
begin
  for i := 1 to  8 do
  begin
    if n >= t[i] * i
    then
      begin
        n := n - t[i] * i;
      end
    else
      begin
        nombre := exp0(10, i - 1) + n Div i;
        chiffre := i - 1 - n Mod i;
        exit(nombre Div exp0(10, chiffre) Mod 10);
      end;
  end;
  exit(-1);
end;


var
  i : Longint;
  i2 : Longint;
  j : Longint;
  j2 : Longint;
  k : Longint;
  k2 : Longint;
  l : Longint;
  out0 : Longint;
  puiss : Longint;
  t : b;
  v : Longint;
begin
  SetLength(t, 9);
  for i := 0 to  9 - 1 do
  begin
    t[i] := exp0(10, i) - exp0(10, i - 1);
  end;
  for i2 := 1 to  8 do
  begin
    Write(i2);
    Write(' => ');
    Write(t[i2]);
    Write(''#10'');
  end;
  for j := 0 to  80 do
  begin
    Write(e(t, j));
  end;
  Write(''#10'');
  for k := 1 to  50 do
  begin
    Write(k);
  end;
  Write(''#10'');
  for j2 := 169 to  220 do
  begin
    Write(e(t, j2));
  end;
  Write(''#10'');
  for k2 := 90 to  110 do
  begin
    Write(k2);
  end;
  Write(''#10'');
  out0 := 1;
  for l := 0 to  6 do
  begin
    puiss := exp0(10, l);
    v := e(t, puiss - 1);
    out0 := out0 * v;
    Write('10^');
    Write(l);
    Write('=');
    Write(puiss);
    Write(' v=');
    Write(v);
    Write(''#10'');
  end;
  Write(out0);
  Write(''#10'');
end.


