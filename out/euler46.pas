program euler46;

type a = array of Longint;
function eratostene(t : a; max0 : Longint) : Longint;
var
  i : Longint;
  j : Longint;
  n : Longint;
begin
  n := 0;
  for i := 2 to  max0 - 1 do
  begin
    if t[i] = i
    then
      begin
        n := n + 1;
        if (max0 Div i) > i
        then
          begin
            j := i * i;
            while (j < max0) and (j > 0) do
            begin
              t[j] := 0;
              j := j + i;
            end;
          end;
      end;
  end;
  exit(n);
end;

type b = array of boolean;

var
  canbe : b;
  era : a;
  i : Longint;
  i_ : Longint;
  j : Longint;
  j_ : Longint;
  k : Longint;
  l : Longint;
  m : Longint;
  m2 : Longint;
  maximumprimes : Longint;
  n : Longint;
  nprimes : Longint;
  o : Longint;
  primes : a;
begin
  maximumprimes := 6000;
  SetLength(era, maximumprimes);
  for j_ := 0 to  maximumprimes - 1 do
  begin
    era[j_] := j_;
  end;
  nprimes := eratostene(era, maximumprimes);
  SetLength(primes, nprimes);
  for o := 0 to  nprimes - 1 do
  begin
    primes[o] := 0;
  end;
  l := 0;
  for k := 2 to  maximumprimes - 1 do
  begin
    if era[k] = k
    then
      begin
        primes[l] := k;
        l := l + 1;
      end;
  end;
  Write(l);
  Write(' == ');
  Write(nprimes);
  Write(''#10'');
  SetLength(canbe, maximumprimes);
  for i_ := 0 to  maximumprimes - 1 do
  begin
    canbe[i_] := false;
  end;
  for i := 0 to  nprimes - 1 do
  begin
    for j := 0 to  maximumprimes - 1 do
    begin
      n := primes[i] + 2 * j * j;
      if n < maximumprimes
      then
        begin
          canbe[n] := true;
        end;
    end;
  end;
  for m := 1 to  maximumprimes do
  begin
    m2 := m * 2 + 1;
    if (m2 < maximumprimes) and not canbe[m2]
    then
      begin
        Write(m2);
        Write(''#10'');
      end;
  end;
end.


