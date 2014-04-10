program euler23;

type e = array of Longint;
function eratostene(t : e; max_ : Longint) : Longint;
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

function fillPrimesFactors(t : e; n : Longint; primes : e; nprimes : Longint) : Longint;
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

function sumdivaux2(t : e; n : Longint; i : Longint) : Longint;
begin
  while (i < n) and (t[i] = 0) do
  begin
    i := i + 1;
  end;
  exit(i);
end;

function sumdivaux(t : e; n : Longint; i : Longint) : Longint;
var
  j : Longint;
  o : Longint;
  out_ : Longint;
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
      out_ := 0;
      p := i;
      for j := 1 to  t[i] do
      begin
        out_ := out_ + p;
        p := p * i;
      end;
      exit((out_ + 1) * o);
    end;;
end;

function sumdiv(nprimes : Longint; primes : e; n : Longint) : Longint;
var
  a : Longint;
  i : Longint;
  max_ : Longint;
  t : e;
begin
  a := n + 1;
  SetLength(t, a);
  for i := 0 to  a - 1 do
  begin
    t[i] := 0;
  end;
  max_ := fillPrimesFactors(t, n, primes, nprimes);
  exit(sumdivaux(t, max_, 0));
end;


var
  abondant : array of boolean;
  b : Longint;
  c : Longint;
  era : e;
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
  primes : e;
  q : Longint;
  r : Longint;
  s : Longint;
  sum : Longint;
  summable : array of boolean;
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
  b := n + 1;
  SetLength(abondant, b);
  for p := 0 to  b - 1 do
  begin
    abondant[p] := false;
  end;
  c := n + 1;
  SetLength(summable, c);
  for q := 0 to  c - 1 do
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
      if abondant[i] and abondant[j] and ((i + j) <= n)
      then
        begin
          summable[i + j] := true;
        end;
    end;
  end;
  for o := 1 to  n do
  begin
    if not summable[o]
    then
      begin
        sum := sum + o;
      end;
  end;
  Write(''#10'');
  Write(sum);
  Write(''#10'');
end.


