program euler21;

type b = array of Longint;
function eratostene(t : b; max_ : Longint) : Longint;
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

function sumdiv(nprimes : Longint; primes : b; n : Longint) : Longint;
var
  a : Longint;
  i : Longint;
  max_ : Longint;
  t : b;
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
  maximumprimes := 10001;
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
  for n := 2 to  10000 do
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


