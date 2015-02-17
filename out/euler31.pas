program euler31;

type a = array of Longint;
type b = array of array of Longint;
function result(sum : Longint; t : a; maxIndex : Longint; cache : b) : Longint;
var
  div0 : Longint;
  i : Longint;
  out0 : Longint;
begin
  if cache[sum][maxIndex] <> 0 then
    begin
      exit(cache[sum][maxIndex]);
    end
  else if (sum = 0) or (maxIndex = 0)
  then
    begin
      exit(1);
    end
  else
    begin
      out0 := 0;
      div0 := sum Div t[maxIndex];
      for i := 0 to  div0 do
      begin
        out0 := out0 + result(sum - i * t[maxIndex], t, maxIndex - 1, cache);
      end;
      cache[sum][maxIndex] := out0;
      exit(out0);
    end;;
end;


var
  cache : b;
  i : Longint;
  j : Longint;
  k : Longint;
  o : a;
  t : a;
begin
  SetLength(t, 8);
  for i := 0 to  8 - 1 do
  begin
    t[i] := 0;
  end;
  t[0] := 1;
  t[1] := 2;
  t[2] := 5;
  t[3] := 10;
  t[4] := 20;
  t[5] := 50;
  t[6] := 100;
  t[7] := 200;
  SetLength(cache, 201);
  for j := 0 to  201 - 1 do
  begin
    SetLength(o, 8);
    for k := 0 to  8 - 1 do
    begin
      o[k] := 0;
    end;
    cache[j] := o;
  end;
  Write(result(200, t, 7, cache));
end.


