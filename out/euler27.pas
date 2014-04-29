program euler27;

type c = array of Longint;
function eratostene(t : c; max_ : Longint) : Longint;
var
  i : Longint;
  j : Longint;
  n : Longint;
begin
  n := 0;
  for i := 2 to  max_ - 1 do
  begin
    if t[i] = i
    then
      begin
        n := n + 1;
        j := i * i;
        while (j < max_) and (j > 0) do
        begin
          t[j] := 0;
          j := j + i;
        end;
      end;
  end;
  exit(n);
end;

function isPrime(n : Longint; primes : c; len : Longint) : boolean;
var
  i : Longint;
begin
  i := 0;
  if n < 0
  then
    begin
      n := -n;
    end;
  while (primes[i] * primes[i]) < n do
  begin
    if (n Mod primes[i]) = 0
    then
      begin
        exit(false);
      end;
    i := i + 1;
  end;
  exit(true);
end;

function test(a : Longint; b : Longint; primes : c; len : Longint) : Longint;
var
  j : Longint;
  n : Longint;
begin
  for n := 0 to  200 do
  begin
    j := n * n + a * n + b;
    if not isPrime(j, primes, len)
    then
      begin
        exit(n);
      end;
  end;
  exit(200);
end;


var
  a : Longint;
  b : Longint;
  era : c;
  j : Longint;
  k : Longint;
  l : Longint;
  ma : Longint;
  max_ : Longint;
  maximumprimes : Longint;
  mb : Longint;
  n1 : Longint;
  n2 : Longint;
  nprimes : Longint;
  o : Longint;
  primes : c;
  result : Longint;
begin
  maximumprimes := 1000;
  SetLength(era, maximumprimes);
  for j := 0 to  maximumprimes - 1 do
  begin
    era[j] := j;
  end;
  result := 0;
  max_ := 0;
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
  ma := 0;
  mb := 0;
  for b := 3 to  999 do
  begin
    if era[b] = b
    then
      begin
        for a := -999 to  999 do
        begin
          n1 := test(a, b, primes, nprimes);
          n2 := test(a, -b, primes, nprimes);
          if n1 > max_
          then
            begin
              max_ := n1;
              result := a * b;
              ma := a;
              mb := b;
            end;
          if n2 > max_
          then
            begin
              max_ := n2;
              result := -a * b;
              ma := a;
              mb := -b;
            end;
        end;
      end;
  end;
  Write(ma);
  Write(' ');
  Write(mb);
  Write(''#10'');
  Write(max_);
  Write(''#10'');
  Write(result);
  Write(''#10'');
end.


