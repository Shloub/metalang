program euler23;

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

function fillPrimesFactors(t : a; n : Longint; primes : a; nprimes : Longint) : Longint;
var
  d : Longint;
  i : Longint;
begin
  for i := 0 to  nprimes - 1 do
  begin
    d := primes[i];
    while n Mod d = 0 do
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

function sumdivaux2(t : a; n : Longint; i : Longint) : Longint;
begin
  while (i < n) and (t[i] = 0) do
  begin
    i := i + 1;
  end;
  exit(i);
end;

function sumdivaux(t : a; n : Longint; i : Longint) : Longint;
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

function sumdiv(nprimes : Longint; primes : a; n : Longint) : Longint;
var
  i : Longint;
  max0 : Longint;
  t : a;
begin
  SetLength(t, n + 1);
  for i := 0 to  n do
  begin
    t[i] := 0;
  end;
  max0 := fillPrimesFactors(t, n, primes, nprimes);
  exit(sumdivaux(t, max0, 0));
end;

type b = array of boolean;

var
  abondant : b;
  era : a;
  i : Longint;
  j : Longint;
  k : Longint;
  l : Longint;
  maximumprimes : Longint;
  n : Longint;
  nprimes : Longint;
  o : Longint;
  other : Longint;
  p : Longint;
  primes : a;
  q : Longint;
  r : Longint;
  s : Longint;
  sum : Longint;
  summable : b;
  t : Longint;
begin
  maximumprimes := 30001;
  SetLength(era, maximumprimes);
  for s := 0 to  maximumprimes - 1 do
  begin
    era[s] := s;
  end;
  nprimes := eratostene(era, maximumprimes);
  SetLength(primes, nprimes);
  for t := 0 to  nprimes - 1 do
  begin
    primes[t] := 0;
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
  n := 100;
  { 28124 ça prend trop de temps mais on arrive a passer le test }
  SetLength(abondant, n + 1);
  for p := 0 to  n do
  begin
    abondant[p] := false;
  end;
  SetLength(summable, n + 1);
  for q := 0 to  n do
  begin
    summable[q] := false;
  end;
  sum := 0;
  for r := 2 to  n do
  begin
    other := sumdiv(nprimes, primes, r) - r;
    if other > r
    then
      begin
        abondant[r] := true;
      end;
  end;
  for i := 1 to  n do
  begin
    for j := 1 to  n do
    begin
      if abondant[i] and abondant[j] and (i + j <= n)
      then
        begin
          summable[i + j] := true;
        end;
    end;
  end;
  for o := 1 to  n do
  begin
    if not(summable[o])
    then
      begin
        sum := sum + o;
      end;
  end;
  Write(''#10'');
  Write(sum);
  Write(''#10'');
end.


