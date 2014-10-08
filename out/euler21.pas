program euler21;

type b = array of Longint;
function eratostene(t : b; max0 : Longint) : Longint;
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
        j := i * i;
        while (j < max0) and (j > 0) do
        begin
          t[j] := 0;
          j := j + i;
        end;
      end;
  end;
  exit(n);
end;

function fillPrimesFactors(t : b; n : Longint; primes : b; nprimes : Longint) : Longint;
var
  d : Longint;
  i : Longint;
begin
  for i := 0 to  nprimes - 1 do
  begin
    d := primes[i];
    while (n Mod d) = 0 do
    begin
      t[d] := t[d] + 1;
      n := n Div d;
    end;
    if n = 1
    then
      begin
        exit(primes[i]);
      end;
  end;
  exit(n);
end;

function sumdivaux2(t : b; n : Longint; i : Longint) : Longint;
begin
  while (i < n) and (t[i] = 0) do
  begin
    i := i + 1;
  end;
  exit(i);
end;

function sumdivaux(t : b; n : Longint; i : Longint) : Longint;
var
  j : Longint;
  o : Longint;
  out0 : Longint;
  p : Longint;
begin
  if i > n then
    begin
      exit(1);
    end
  else if t[i] = 0
  then
    begin
      exit(sumdivaux(t, n, sumdivaux2(t, n, i + 1)));
    end
  else
    begin
      o := sumdivaux(t, n, sumdivaux2(t, n, i + 1));
      out0 := 0;
      p := i;
      for j := 1 to  t[i] do
      begin
        out0 := out0 + p;
        p := p * i;
      end;
      exit((out0 + 1) * o);
    end;;
end;

function sumdiv(nprimes : Longint; primes : b; n : Longint) : Longint;
var
  i : Longint;
  max0 : Longint;
  t : b;
begin
  SetLength(t, n + 1);
  for i := 0 to  n + 1 - 1 do
  begin
    t[i] := 0;
  end;
  max0 := fillPrimesFactors(t, n, primes, nprimes);
  exit(sumdivaux(t, max0, 0));
end;


var
  era : b;
  j : Longint;
  k : Longint;
  l : Longint;
  maximumprimes : Longint;
  n : Longint;
  nprimes : Longint;
  o : Longint;
  other : Longint;
  othersum : Longint;
  primes : b;
  sum : Longint;
begin
  maximumprimes := 1001;
  SetLength(era, maximumprimes);
  for j := 0 to  maximumprimes - 1 do
  begin
    era[j] := j;
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
  sum := 0;
  for n := 2 to  1000 do
  begin
    other := sumdiv(nprimes, primes, n) - n;
    if other > n
    then
      begin
        othersum := sumdiv(nprimes, primes, other) - other;
        if othersum = n
        then
          begin
            Write(other);
            Write(' & ');
            Write(n);
            Write(''#10'');
            sum := sum + other + n;
          end;
      end;
  end;
  Write(''#10'');
  Write(sum);
  Write(''#10'');
end.


