program euler12;
Uses math;


type c = array of Longint;
function eratostene(t : c; max0 : Longint) : Longint;
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
        j := i * i;
        n := n + 1;
        while (j < max0) and (j > 0) do
        begin
          t[j] := 0;
          j := j + i;
        end;
      end;
  end;
  exit(n);
end;

function fillPrimesFactors(t : c; n : Longint; primes : c; nprimes : Longint) : Longint;
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

function find(ndiv2 : Longint) : Longint;
var
  era : c;
  i : Longint;
  j : Longint;
  k : Longint;
  l : Longint;
  m : Longint;
  max0 : Longint;
  maximumprimes : Longint;
  n : Longint;
  ndivs : Longint;
  nprimes : Longint;
  o : Longint;
  primes : c;
  primesFactors : c;
begin
  maximumprimes := 110;
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
  for n := 1 to  10000 do
  begin
    SetLength(primesFactors, n + 2);
    for m := 0 to  n + 1 do
    begin
      primesFactors[m] := 0;
    end;
    max0 := Max(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes));
    primesFactors[2] := primesFactors[2] - 1;
    ndivs := 1;
    for i := 0 to  max0 do
    begin
      if primesFactors[i] <> 0
      then
        begin
          ndivs := ndivs * (1 + primesFactors[i]);
        end;
    end;
    if ndivs > ndiv2
    then
      begin
        exit(n * (n + 1) Div 2);
      end;
    { print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" }
  end;
  exit(0);
end;


begin
  Write(find(500));
  Write(''#10'');
end.


